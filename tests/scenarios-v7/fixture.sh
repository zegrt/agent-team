#!/bin/bash
# Builds a neutral v7 fixture or the assigned-worker fixture for G02.
set -eu
target=${1:?usage: fixture.sh <new-target-dir> [worker]}
mkdir "$target"
cd "$target"
git init -q -b main
printf '# Sable kiosk\n\nA fictional trail kiosk.\n' > README.md

if [ "${2:-}" = worker ]; then
  mkdir -p briefs help
  cat > WORKBOARD.md <<'BOARD'
# Sable kiosk

| Role | Agent | Thread |
|---|---|---|
| Manager | route-lead | route-lead |
| Builder | trail-builder | trail-builder |

## Tasks

| Id | Task | Size | Files | Branch | Builder | Reviewer | Rounds | State | Brief |
|---|---|---|---|---|---|---|---|---|---|
| K-11 | Fix route help link | Content | help/routes.md | task-k11-help | trail-builder | - | 0 | building | briefs/K-11.md |
| K-12 | Correct the map CSV | Content | maps/elevation.csv | task-k12-map | map-builder | - | 0 | building | briefs/K-12.md |
BOARD
  cat > briefs/K-11.md <<'BRIEF'
# Brief K-11

Manager: route-lead
Branch: task-k11-help
Files: help/routes.md
Director's instruction: [Original note](../help/director-note.md)
Reference: [Route help](../help/route-help.md)
Done when: The "Route help" link in help/routes.md opens help/route-help.md.
BRIEF
  printf '# Map CSV\n\nCheck the export against the approved elevation sheet.\n' > briefs/K-12.md
  printf '# Routes\n\n[Route help](outdated.md)\n' > help/routes.md
  printf '# Route help\n' > help/route-help.md
  printf 'Please point the routes page to the new route help page.\n' > help/director-note.md
fi
git add .
git -c user.name=fixture -c user.email=fixture -c core.hooksPath=/dev/null commit -qm 'Start kiosk fixture'
if [ "${2:-}" = worker ]; then
  git branch task-k11-help
  git branch task-k12-map
  git remote add origin .
  git fetch -q origin
fi
