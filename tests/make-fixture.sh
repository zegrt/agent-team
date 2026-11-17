#!/bin/bash
# Builds the test project "northwind-guide" in ./fixture (a small git repo with a work board).
D="$(cd "$(dirname "$0")" && pwd)/fixture"; rm -rf "$D"; mkdir -p "$D/rules" "$D/workers" && cd "$D" && git init -q -b main
cat > WORKBOARD.md <<'BOARD'
# Northwind guide: work board

Director: Dana. Manager: Claude on Dana's Mac (this folder). Workers: mac-codex (Codex, Mac, works in this same
folder unless told otherwise), win-claude (Claude, Windows PC, own clone).

## Decisions
- 3 Nov: tone rules use concrete examples, never adjectives alone (Dana).
- 5 Nov: the colour section keeps the old hex values until the rebrand ships (Dana).
- 10 Nov: only the manager merges to main, after Dana approves.

## Tasks
| Id | Task | Owner | State |
|---|---|---|---|
| 21 | Rewrite rules/tone.md voice examples | win-claude | built, waiting review |
| 22 | Add rules/motion.md easing section | mac-codex | in progress, branch task-22 |
| 23 | Fix typo "colour" -> "color" in README heading | - | open |
| 24 | Restructure rules/ into per-channel folders | - | open |
BOARD
printf '# Tone\n\nWrite warmly.\n' > rules/tone.md; printf '# Motion\n' > rules/motion.md
printf '# Northwind guide colour rules\n' > README.md
git add -A && git -c user.name=test -c user.email=test@example.com commit -qm init && echo "fixture ready: $D"
