#!/bin/bash
# Builds the Northwind guide fixture for tests/scenarios/.
set -eu
D="$(cd "$(dirname "$0")" && pwd)/fixture"
rm -rf "$D"
mkdir -p "$D"/{rules,logo,colour,briefs}
cd "$D"
git init -q -b main
g() { git -c user.name=fixture -c user.email=fixture -c core.hooksPath=/dev/null "$@"; }
cat > WORKBOARD.md <<'BOARD'
# Northwind guide: work board

Director: Dana. Manager: Claude on Dana's Mac (this folder). Workers: mac-codex (Codex, Mac, works in this same
folder unless told otherwise), win-claude (Claude, Windows PC, own clone).

## Decisions
- 3 Nov: tone rules use concrete examples, never adjectives alone (Dana).
- 5 Nov: the colour section keeps the old hex values until the rebrand ships (Dana).
- 10 Nov: only the manager merges to main, after Dana approves.

## Tasks
| Id | Task | Size | Files | Branch | Builder | Reviewer | Rounds | State | Brief |
|---|---|---|---|---|---|---|---|---|---|
| 21 | Rewrite tone examples | Content | rules/tone.md | task-21 | win-claude | mac-codex | 0 | built | - |
| 22 | Add the easing section | Content | rules/motion.md | task-22 | mac-codex | - | 0 | building | - |
| 23 | Fix the heading typo | Small | README.md | main | - | - | 0 | open | - |
| 24 | Restructure rules by channel | Design | rules/ | - | - | - | 0 | open | - |
| T14 | Rewrite logo clear-space and minimum-size rules | Content | logo/clear-space.md, logo/min-size.md | t14-logo-space | win-claude | mac-codex | 0 | building | briefs/T14.md |
| T15 | Fix typo in footer | Small | README.md | main | manager | - | 0 | merged | - |
| T9 | Colour contrast table for text on brand colours | Content | colour/contrast.md | t9-contrast | mac-codex | win-claude | 2 | built | briefs/T9.md |
BOARD
printf '# Tone\n\nWrite warmly.\n' > rules/tone.md
printf '# Motion\n' > rules/motion.md
printf '# Northwind guide colour rules\n' > README.md
printf '# Logo clear space\n' > logo/clear-space.md
printf '# Logo minimum size\n' > logo/min-size.md
printf '# Current palette\n\nHarbour Blue: #1A4C86\nSignal Teal: #007A78\nSand: #E8D9BA\n' > colour/palette.md
printf '# T14\n\nRewrite logo clear-space and minimum-size rules.\n' > briefs/T14.md
printf '# T9\n\nUpdate the ratios for text on brand colours.\n' > briefs/T9.md
g add -A
g commit -qm 'Start Northwind guide'
g branch task-21
g branch task-22

g switch -qc t14-logo-space
printf '\nAllow one letter-width around the logo.\n' >> logo/clear-space.md
g add logo/clear-space.md
GIT_AUTHOR_DATE=2026-11-17T09:52:00 GIT_COMMITTER_DATE=2026-11-17T09:52:00 \
  g commit -qm 'wip clear-space'

g switch -qc t9-contrast main
printf '# Contrast\n\n| Colour | Text | Ratio | Level |\n|---|---|---|---|\n| Harbour Blue | White | 8.41 | AA |\n| Harbour Blue | Cream | 7.71 | AA |\n| Harbour Blue | Yellow | 6.90 | AA |\n| Signal Teal | White | 4.70 | AA large |\n' > colour/contrast.md
g add colour/contrast.md
g commit -qm 'Build draft contrast table'

g switch -qc review-T9 main
mkdir reviews
cat > reviews/T9-r3.md <<'REVIEW'
# T9 review

- F1: Three Harbour Blue rows still show the 2025 ratios.
- F5: The table has no row for text on Sand.
- F6: The table uses "AA large" without defining large.
REVIEW
g add reviews/T9-r3.md
g commit -qm 'Record T9 review findings'
g switch -q main
# Use local branches as the fixture's remote, including when the runner copies it.
g remote add origin .
g fetch -q origin
g branch -q --set-upstream-to=origin/main main
echo "fixture ready: $D"
