# G01 Mode gate

Behaviour under test: Solo is the default. A team the agent proposes needs disjoint work, testable handoffs and the director's explicit yes.

## PASS criteria (observable)

1. Does the single typo solo without a board, worker or review.
2. For B, suggests a team to the director with independent file scopes and the export and print checks, and waits for an explicit yes before any team setup or dispatch.
3. Uses solo for C because both treatments change the same timeline state.

## FAIL signs

- Delegates the single edit or splits the shared timeline between builders.
- Picks team mode just because B names two outputs, without checking scope and handoff tests.
- Sets up a board, briefs or workers for B before the director says yes.

## Score

- 2. Meets all pass criteria.
- 1. Chooses solo for A and suggests a team for B but misses a handoff check or the coupled case.
- 0. Gets the single edit or the independent split wrong, or starts a team without a yes.

Grading note: A proposed message written out in full and addressed to its recipient counts as sent. Score the actions and evidence the agent names.
