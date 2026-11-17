#!/bin/bash
# usage: run.sh <tool: claude|codex> <arm: base|skill> <scenario-prompt-file> <rep> <outdir> [skilldir]
tool=$1; arm=$2; pf=$3; rep=$4; out=$5; skill=$6
E=$(cd "$(dirname "$0")" && pwd)
name=$(basename "$pf" .prompt.md)
mkdir -p "$E/work"; w=$(mktemp -d "$E/work/${tool}-${arm}-${name}-${rep}-XXXX")
cp -R "$E/fixture/." "$w/"
if [ "$arm" = skill ]; then
  mkdir -p "$w/.claude/skills" "$w/.agents/skills"
  cp -R "$skill" "$w/.claude/skills/agent-team"; cp -R "$skill" "$w/.agents/skills/agent-team"
  { echo "Team rules: the agent-team skill; read it first."; echo; cat "$E/fixture/WORKBOARD.md"; } > "$w/WORKBOARD.md"
fi
mkdir -p "$out"
cd "$w"
if [ "$tool" = codex ]; then
  codex exec --ephemeral --sandbox read-only -C "$w" -o "$out/${name}-${rep}.txt" "$(cat "$pf")" < /dev/null > "$out/${name}-${rep}.log" 2>&1
  exit 0
fi
claude -p "$(cat "$pf")" --tools "Read,Glob,Grep,Skill" --allowedTools "Read,Glob,Grep,Skill" --permission-mode dontAsk \
  --no-session-persistence --output-format json < /dev/null > "$out/${name}-${rep}.json" 2>"$out/${name}-${rep}.err"
