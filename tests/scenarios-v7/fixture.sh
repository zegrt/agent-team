#!/bin/bash
# Builds a neutral repository for v7. Each prompt supplies its own project state.
set -eu
target=${1:?usage: fixture.sh <new-target-dir>}
mkdir "$target"
cd "$target"
git init -q -b main
printf '# Sable kiosk\n\nA fictional trail kiosk.\n' > README.md
git add README.md
git -c user.name=fixture -c user.email=fixture -c core.hooksPath=/dev/null commit -qm 'Start kiosk fixture'
