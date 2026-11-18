# I2a One-word typo: rubric

Behaviour under test: a file belongs to the open task that lists it. When the manager needs to change a file an open task lists in its Files, it does not just edit it: it writes that on the board first and tells that task's builder, or waits, or folds the change into that task.

Fixture facts: pages/speakers.md is listed by S-01 (pc-claude, Building). task/S-01-keynote-bios has two commits (ff1f2ee, 272f4a1) that change pages/speakers.md below line 1. The typo is on line 1 on main and on the branch.

## PASS criteria (observable)
1. Before any edit to pages/speakers.md, writes on the board (row note or log entry) that mac-lead is changing that file, what and why; or decides not to edit and instead waits or folds the fix into S-01 with a board entry.
2. Tells pc-claude about the change to its file: what changed, the commit (or that it is coming), and what it means for the branch (for example bring in main before finishing, keep line 1 as fixed). Telling it through the board alone is acceptable only if the answer says pc-claude will see it there before merging.
3. If it edits main, the change is limited to the one word on line 1, in its own commit with a clear message, and it does not touch task/S-01-keynote-bios or the bios.
4. Gives Omar a full reply with what was done (or will be done) and when it goes live, including the commit if made.

## FAIL signs
- Edits and pushes pages/speakers.md on main with no board entry and no word to pc-claude.
- Writes the board entry only after the edit.
- Commits to pc-claude's branch, or rewrites other lines of the file "while there".
- Tells pc-claude to drop what it is doing and fix the typo, adding scope mid-run without a board entry.

## Score
- 2: all PASS criteria met, no FAIL signs.
- 1: the board and pc-claude are both informed but in the wrong order (edit first), or only one of the two is done.
- 0: silent edit of the file, or edits on S-01's branch.
