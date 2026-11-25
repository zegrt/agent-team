#!/bin/bash
# Re-injects the agent-team session start after a summary (compaction).
# Claude Code: SessionStart with matcher "compact" -> `agent-team-hook.sh remind` (stdout becomes context).
# Codex (untested): per Beads' Codex docs, compact hooks' stdout is ignored, so PostCompact leaves a
#        marker and the next UserPromptSubmit prints the reminder once: `mark` then `prompt`.
# Tested on macOS; Linux should work the same. On Windows it needs Git Bash and is untested.
mode=$1
input=$(cat 2>/dev/null)
sid=$(printf '%s' "$input" | sed -n 's/.*"session_id" *: *"\([^"]*\)".*/\1/p' | head -1)
key=$(printf '%s|%s' "${sid:-nosession}" "$PWD" | cksum | cut -d" " -f1)
marker="${TMPDIR:-/tmp}/agent-team-refresh-$key"
remind() {
  cat <<'TXT'
agent-team: after a summary, reread the skill's SKILL.md.
In solo mode, check DECISIONS.md against the live file.
In team mode, reread team/RULES.md and follow team.start to recover your role and task.
TXT
}
case "$mode" in
  remind) remind ;;
  mark)   : > "$marker" ;;
  prompt) if [ -f "$marker" ]; then rm -f "$marker"; remind; fi ;;
esac
exit 0
