# G01 Mode gate

Behaviour under test: Solo is the default. A team needs disjoint work and testable handoffs.

## PASS criteria (observable)

1. Does the single typo solo without a board, worker or review.
2. Uses team mode for B, assigning independent file scopes and naming the export and print checks.
3. Uses solo for C because both treatments change the same timeline state.
4. Loads team-specific instructions only for the team case.

## FAIL signs

- Delegates the single edit or splits the shared timeline between builders.
- Picks team mode just because B names two outputs, without checking scope and handoff tests.

## Score

- 2. Meets all pass criteria.
- 1. Chooses solo for A and team for B but misses a handoff check, the coupled case or load behavior.
- 0. Gets the single edit or the independent split wrong.

Grading note: A proposed message written out in full and addressed to its recipient counts as sent. Score the actions and evidence the agent names.
