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
if [ "$arm" = skill ]; then
  prompt=$'Use the agent-team skill.\n\n'"$prompt"
  mkdir -p "$w/.claude/skills" "$w/.agents/skills"
  # Copy runtime files only. Solo runs leave the team files unloaded.
  for d in "$w/.claude/skills/agent-team" "$w/.agents/skills/agent-team"; do
    mkdir -p "$d"
    cp "$skill/SKILL.md" "$d/"
    cp -R "$skill/team" "$skill/scripts" "$d/"
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
