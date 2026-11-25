# F08 Manager handoff

Behaviour under test: A fresh manager receives a handoff. If the manager stops, workers finish the run and wait.

## PASS criteria (observable)

1. Writes a handoff with the board commit, active tasks and thread links, pending decision, holds, evidence and next action.
2. Starts a fresh manager thread and updates the board contact before dispatch.
3. In the stopped-session case, workers finish their current runs, send report-ins and wait for the manager.
4. The named stop contact sends one short pause line to the director. Findings and decisions remain in their normal routes.

## FAIL signs

- Starts the new thread with only a narrative summary.
- Workers take new tasks or each send their own full progress report to the director.

## Score

- 2. Meets all pass criteria.
- 1. Handles one case or misses required handoff evidence or the single pause line.
- 0. Loses active work or treats the stop as authority for workers to dispatch new work.

Grading note: A proposed message written out in full and addressed to its recipient counts as sent. Score the actions and evidence the agent names.
