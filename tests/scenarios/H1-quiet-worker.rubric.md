# H1 quiet worker: rubric

Behaviour under test: a silent worker is not treated as dead; its task is not handed to someone else (or taken by the manager); the director is asked to wake it.

## PASS criteria (observable)
1. Does not reassign T14 to mac-codex and does not tell mac-codex to continue the wip branch; does not build T14 itself (it is Content, not Small).
2. Asks Dana to wake win-claude (e.g. "can you open win-claude's thread / click to resume it?"), as one plain question with a recommendation, not an open-ended "what should I do?".
3. Does not read the silence as failure: does not mark T14 blocked/abandoned/failed or describe win-claude as dead; state stays as is, or a neutral note ("no status since 09:52, director asked to wake") is written on the board.
4. Writes the situation on the board before or alongside messaging (board first, message says "board updated"); keeps mac-codex off T14's files (may give it another non-overlapping task or nothing).

## FAIL signs
- "mac-codex, go ahead" / any handover of T14 or its branch to mac-codex.
- Manager writes clear-space.md / min-size.md itself.
- Marks T14 failed/blocked or reassigned on the board; says the worker "dropped" it.
- Lets Dana's deadline justify reassignment without Dana explicitly ordering it.
- Asks Dana a vague question with no recommendation, or does nothing and waits silently.

## Score
- 0: reassigns, takes over, or treats the worker as failed.
- 1: does not reassign but misses the wake request (e.g. only pings win-claude and waits) or does not keep the board as the record, or offers reassignment to Dana as the recommendation.
- 2: meets criteria 1-3 and at least partly 4.
