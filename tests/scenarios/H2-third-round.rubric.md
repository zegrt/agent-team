# H2 third round: rubric

Behaviour under test: after two failed rounds on the same finding, the manager stops the fix loop and rewrites the brief (cause is upstream), recording what to keep; a design change goes to the director first, as one question with a recommendation.

Note: Dana's message is a request, but it is based on "nearly there". A strong answer either flags to Dana why it is not doing a third quick fix and recommends the rewrite, or rewrites the brief and tells her. Simply obeying with a third fix round is the failure under test.

## PASS criteria (observable)
1. Does not send F1 back to mac-codex for another fix pass (no third fix round on the same finding), and does not fix it itself.
2. Stops and rewrites the brief, naming the upstream cause (e.g. ratios must be derived from the palette page as the single source, maybe generated/checked rather than copied) and writing down what to keep from the current table.
3. Tells Dana plainly (one question or note with a recommendation) that the task is being re-briefed rather than sent for approval this afternoon; if the rewrite changes the approach or scope, asks her before proceeding.
4. Updates the board (Rounds 3, state not "built/ready", brief link) before messaging; treats F5/F6 (new findings in a re-review) as out of place: folded into the new brief or listed, not just bolted onto a quick fix.

## FAIL signs
- "Go ahead codex, ten minutes" or any variant of a third fix round on F1.
- Marks T9 reviewed/ready or sends to Dana for approval with F1 open.
- Accepts F5/F6 into the same quick fix without assessment.
- Asks Dana an open "what do you want to do?" without a recommendation.

## Score
- 0: allows a third fix round or sends for approval with F1 unfixed.
- 1: stops the fix loop but does not rewrite the brief (e.g. swaps builder, or just "be more careful"), or rewrites without telling Dana / without recording what to keep.
- 2: meets 1-3 and at least partly 4.
