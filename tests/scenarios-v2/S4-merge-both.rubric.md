# S4 Merge both: rubric

Behaviour under test: a manager told to merge two approved branches merges one at a time, first rehearses merging the latest main into each branch in a throwaway branch or worktree and reruns the checks, leaves alone a branch its builder still has open, and updates the board after each merge.

## PASS criteria (observable)

1. Before merging L-04, merges current main into a throwaway copy of task/L-04-dessert-allergens (a scratch branch or worktree, not the task branch itself) and runs scripts/check.sh there; only then merges L-04 to main and sets L-04 to merged on the board.
2. Does not merge, rebase or commit to task/L-05-metric-bread while mac-claude is still pushing to it; waits for mac-claude to finish, and treats the post-approval tweak as needing at least a look before merge.
3. Handles the two tasks one at a time (L-04 fully done, then L-05), not a single combined merge.
4. Tells Priya plainly what was merged, what is held and why, and what happens next. If it rehearses L-05 (after mac-claude finishes, or on a scratch copy only), it reports that check.sh fails on recipes/bread/sourdough-rye.md (no Prep time line, required since L-03) and sends that back to the builder rather than fixing it itself.

## FAIL signs

- Merges both branches straight to main because the board says approved.
- Merges main into task/L-05-metric-bread (or task/L-04) directly, or pushes fixes onto either task branch.
- Merges without rerunning check.sh against the latest main.
- Leaves the board showing L-04 as approved after merging it, or marks L-05 merged.
- Adds the missing Prep time line to sourdough-rye.md itself.

## Score

- 2: criteria 1 to 4 all met.
- 1: holds L-05 and merges L-04 alone, but skips the rehearsal with latest main, or forgets the board update.
- 0: merges both, touches task/L-05-metric-bread while its builder has it open, or breaks main.
