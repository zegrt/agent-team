#!/bin/bash
# usage: run.sh <tool: claude|codex> <arm: base|skill> <scenario-prompt-file> <rep> <outdir> [skilldir]
set -e
tool=$1; arm=$2; pf=$3; rep=$4; out=$5; skill=$6
E=$(cd "$(dirname "$0")" && pwd)
prompt=$(cat "$pf")
name=$(basename "$pf" .prompt.md)
mkdir -p "$E/work"; w=$(mktemp -d "$E/work/${tool}-${arm}-${name}-${rep}-XXXX")
fx=${FIXTURE:-$E/fixture}
cp -R "$fx/." "$w/"
header='Team rules: the agent-team skill; read it first.'
if [ -f "$w/WORKBOARD.md" ] && [ "$(head -n 1 "$w/WORKBOARD.md")" != "$header" ]; then
  if [ -d "$w/.git" ] && git -C "$w" ls-files --error-unmatch WORKBOARD.md >/dev/null 2>&1 &&
     [ -z "$(git -C "$w" status --porcelain -- WORKBOARD.md)" ]; then
    # Treat the header as test metadata in this read-only copy.
    git -C "$w" update-index --assume-unchanged -- WORKBOARD.md
  fi
  { printf '%s\n\n' "$header"; cat "$fx/WORKBOARD.md"; } > "$w/WORKBOARD.md"
fi
if [ "$arm" = skill ]; then
  layout=(team)
  if [ ! -f "$skill/team/RULES.md" ]; then
    layout=(RULES.md templates)
  fi
  mkdir -p "$w/.claude/skills" "$w/.agents/skills"
  # Copy runtime files from either layout.
  for d in "$w/.claude/skills/agent-team" "$w/.agents/skills/agent-team"; do
    mkdir -p "$d"
    cp "$skill/SKILL.md" "$d/"
    for path in "${layout[@]}" scripts; do
      cp -R "$skill/$path" "$d/"
    done
  done
  if [ -d "$w/.git" ]; then
    # Installing test skills must not change the scenario's Git status.
    mkdir -p "$w/.git/info"
    printf '\n/.claude/skills/agent-team/\n/.agents/skills/agent-team/\n' >> "$w/.git/info/exclude"
  fi
fi
mkdir -p "$out"
out=$(cd "$out" && pwd)
cd "$w"
# Codex: an empty HOME hides ~/.agents/skills; CODEX_HOME stays real so the login is never copied or refreshed
# elsewhere. Claude: project settings only.
if [ "$tool" = codex ]; then
  ch="${CODEX_HOME:-$HOME/.codex}"; h=$(mktemp -d "$E/work/home-XXXX")
  HOME="$h" CODEX_HOME="$ch" codex exec --ephemeral --sandbox read-only -C "$w" -o "$out/${name}-${rep}.txt" "$prompt" < /dev/null > "$out/${name}-${rep}.log" 2>&1
  exit 0
fi
claude -p "$prompt" ${CLAUDE_MODEL:+--model "$CLAUDE_MODEL"} --setting-sources project --tools "Read,Glob,Grep,Skill,Bash" \
  --allowedTools "Read,Glob,Grep,Skill,Bash(git show *),Bash(git diff *),Bash(git log *),Bash(git status *),Bash(git branch *),Bash(git worktree list *)" \
  --permission-mode dontAsk \
  --no-session-persistence --output-format json < /dev/null > "$out/${name}-${rep}.json" 2>"$out/${name}-${rep}.err"
