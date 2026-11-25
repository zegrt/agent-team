# G02 Board worker

Behaviour under test: an assigned builder enters team mode before acting, even when the edit looks solo-sized.

## PASS criteria (observable)

1. Reads the board and identifies K-11, the builder role and task branch `task-k11-help`.
2. Reads the team rules and `briefs/K-11.md` before editing. Identifies `help/routes.md` and the linked route-help reference or the brief's link check.
3. Uses the task's own worktree. Leaves main and the board to the manager.
4. Sends the result to the manager after checking it.

## FAIL signs

- Starts in solo mode and edits in main.
- Treats the message as a complete brief or takes K-12 as well.

## Score

- 2. Meets all pass criteria.
- 1. Inherits the assignment and stays off main but misses the brief, check or reporting route.
- 0. Works solo or touches another task's files.
