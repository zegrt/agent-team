# F07 Two failed rounds

Behaviour under test: Two failures stop the fix loop and send the manager back to the source.

## PASS criteria (observable)

1. Holds the task and does not approve a third patch.
2. Reopens the exact reference and identifies the missing double-tap behavior.
3. Asks the director one clear question with a recommendation about that behavior.
4. Records what already works and updates the brief before restarting. Gets approval for any design change.

## FAIL signs

- Sends the third patch without returning to the reference.
- Invents the double-tap rule.

## Score

- 2. Meets all pass criteria.
- 1. Holds the task but skips the reference, the question or the new brief.
- 0. Continues the fix loop or guesses the missing behavior.

Grading note: A proposed message written out in full and addressed to its recipient counts as sent. Score the actions and evidence the agent names.
