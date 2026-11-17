#!/bin/bash
# usage: batch.sh <arm> <scenario-dir> <outroot> <reps> [skilldir] [tools: "claude codex"]
E=$(cd "$(dirname "$0")" && pwd); arm=$1; sd=$2; root=$3; reps=$4; skill=$5; tools=${6:-"claude codex"}
for tool in $tools; do for pf in "$sd"/*.prompt.md; do for r in $(seq 1 $reps); do
  name=$(basename "$pf" .prompt.md)
  [ -s "$root/$tool-$arm/$name-$r.json" ] || [ -s "$root/$tool-$arm/$name-$r.txt" ] && continue
  while [ "$(jobs -rp | wc -l)" -ge 6 ]; do sleep 2; done
  "$E/run.sh" "$tool" "$arm" "$pf" "$r" "$root/$tool-$arm" "$skill" &
done; done; done
wait; echo DONE
