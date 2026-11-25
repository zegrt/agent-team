#!/bin/bash
# Exercise the Git helper against a disposable repo. Intercept every push.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
team="$here/../scripts/team.py"
mkdir -p "$here/work"
work=$(mktemp -d "$here/work/team-script-XXXX")
trap 'rm -rf "$work"' EXIT
mkdir "$work/bin" "$work/tmp" "$work/project"
export REAL_GIT=$(command -v git)
export PUSH_LOG="$work/pushes"
export TMPDIR="$work/tmp"
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export GIT_AUTHOR_NAME=fixture GIT_COMMITTER_NAME=fixture
export GIT_AUTHOR_EMAIL=fixture GIT_COMMITTER_EMAIL=fixture
cat > "$work/bin/git" <<'SH'
#!/bin/bash
if [ "$1" = push ]; then
  printf '%s\n' "$*" >> "$PUSH_LOG"
  exit 0
fi
exec "$REAL_GIT" "$@"
SH
chmod +x "$work/bin/git"
export PATH="$work/bin:$PATH"

cd "$work/project"
git init -q -b main
printf '# Fixture\n' > README.md
printf '# Decisions\n\nKeep the route link.\n' > DECISIONS.md
git add .
git commit -qm 'Start project'
base=$(git rev-parse HEAD)
git switch -qc task-17
printf 'Route help\n' > routes.md
git add routes.md
git commit -qm 'Change route help'
task=$(git rev-parse HEAD)
git switch -qc review-T17 main
mkdir reviews
printf '# Review T17\n\nReviewed commit: %s\n' "$base" > reviews/T17.md
git add reviews/T17.md
git commit -qm 'Review the wrong version'
wrong_review=$(git rev-parse HEAD)
printf '# Review T17\n\nReviewed commit: %s\n' "$task" > reviews/T17.md
git add reviews/T17.md
git commit -qm 'Review the tested version'
review=$(git rev-parse HEAD)
git switch -q main
git remote add origin .

board() {
  cat > WORKBOARD.md <<BOARD
# Work board

## Tasks

| Id | Size | Branch | Reviewer | State | Tested commit | Review commit |
|---|---|---|---|---|---|---|
| T17 | $1 | $2 | $3 | $4 | $5 | $6 |
| T16 | Small | main | - | merged (date) | - | - |
BOARD
  git add WORKBOARD.md
  git commit -qm 'Update work board'
}

refuses() {
  if output=$(python3 "$team" merge T17 2>&1); then
    printf 'Expected the merge to fail: %s\n' "$1" >&2
    exit 1
  fi
  printf '%s\n' "$output" | grep -Fq "$1"
  test ! -e "$PUSH_LOG"
}

board Small main - approved "$base" -
refuses 'Land Small task T17 directly on main'
board Content main - approved "$base" -
refuses 'Refusing to delete protected branch main'
git config --add agent-team.protectedBranch 'task-*'
board Content task-17 - approved "$task" -
refuses 'Refusing to delete protected branch task-17'
git config --unset-all agent-team.protectedBranch
board Content task-17 - pending "$task" -
refuses 'Only the director'
board Content task-17 - approved "$base" -
refuses 'does not match its approved commit'

board Content task-17 reviewer approved "$task" "$wrong_review"
refuses 'does not match its approved commit'
git branch -f review-T17 "$wrong_review"
refuses 'does not cover the approved task commit'
git branch -f review-T17 "$review"

board Content task-17 reviewer approved "$task" "$review"
status=$(python3 "$team" status)
printf '%s\n' "$status" | grep -Fxq 'WORKBOARD.md: 8 lines'
printf '%s\n' "$status" | grep -Fxq 'DECISIONS.md: 3 lines'
printf '%s\n' "$status" | grep -Fxq 'Merged rows still on the board: 1'
output=$(python3 "$team" rehearse T17 -- 'test -f routes.md')
printf '%s\n' "$output" | grep -Fq "Task commit: $task."
test "$(git worktree list --porcelain | grep -c '^worktree ')" -eq 1
output=$(python3 "$team" rehearse T17 -- 'printf "evidence\n" > target-check.txt')
kept=$(printf '%s\n' "$output" | sed -n 's/^Rehearsal worktree kept at \(.*\)\. Preserve any cited evidence before removing it\.$/\1/p')
test -f "$kept/target-check.txt"

python3 "$team" merge T17
git merge-base --is-ancestor "$task" HEAD
git merge-base --is-ancestor "$review" HEAD
test "$(git rev-parse approved)" = "$(git rev-parse HEAD)"
grep -Fq -- "--force-with-lease=refs/heads/task-17:$task --force-with-lease=refs/heads/review-T17:$review origin --delete refs/heads/task-17 refs/heads/review-T17" "$PUSH_LOG"
printf 'Protected refs, approval pins, status counts and rehearsal cleanup passed. Pushes were intercepted.\n'
