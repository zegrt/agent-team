#!/bin/bash
# usage: run.sh <tool: claude|codex> <arm: base|skill> <scenario-prompt-file> <rep> <outdir> [skilldir]
tool=$1; arm=$2; pf=$3; rep=$4; out=$5; skill=$6
E=$(cd "$(dirname "$0")" && pwd)
name=$(basename "$pf" .prompt.md)
mkdir -p "$E/work"; w=$(mktemp -d "$E/work/${tool}-${arm}-${name}-${rep}-XXXX")
fx=${FIXTURE:-$E/fixture}
cp -R "$fx/." "$w/"
if [ "$arm" = skill ]; then
  mkdir -p "$w/.claude/skills" "$w/.agents/skills"
  # only the skill's own files: never the tests, rubrics or results (blind review, 18 Nov 2026)
  for d in "$w/.claude/skills/agent-team" "$w/.agents/skills/agent-team"; do
    mkdir -p "$d"; cp "$skill/SKILL.md" "$skill/RULES.md" "$d/"; cp -R "$skill/templates" "$d/"
  done
  { echo "Team rules: the agent-team skill; read it first."; echo; cat "$fx/WORKBOARD.md"; } > "$w/WORKBOARD.md"
fi
mkdir -p "$out"
cd "$w"
# Neither arm sees the user's installed skills or plugins; only the run's own folder (blind review, 18 Nov 2026).
# Codex: an empty HOME hides ~/.agents/skills; CODEX_HOME stays real so the login is never copied or refreshed
# elsewhere. Claude: project settings only.
if [ "$tool" = codex ]; then
  ch="${CODEX_HOME:-$HOME/.codex}"; h=$(mktemp -d "$E/work/home-XXXX")
  HOME="$h" CODEX_HOME="$ch" codex exec --ephemeral --sandbox read-only -C "$w" -o "$out/${name}-${rep}.txt" "$(cat "$pf")" < /dev/null > "$out/${name}-${rep}.log" 2>&1
  exit 0
fi
claude -p "$(cat "$pf")" --setting-sources project --tools "Read,Glob,Grep,Skill,Bash" \
  --allowedTools "Read,Glob,Grep,Skill,Bash(git show *),Bash(git diff *),Bash(git log *),Bash(git status *),Bash(git branch *),Bash(git worktree list *)" \
  --permission-mode dontAsk \
  --no-session-persistence --output-format json < /dev/null > "$out/${name}-${rep}.json" 2>"$out/${name}-${rep}.err"
