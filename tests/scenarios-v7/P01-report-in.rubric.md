# P01 Report in

Behaviour under test: the worker sends the manager the final line, with a report pointer or a question.

## PASS criteria (observable)

1. For A, sends `route-lead` a single `report in: K-18, done, …` containing branch, hash and report path. Keeps the report out of the director's session. Any acknowledgment to the director precedes the final line.
2. For B, sends `route-lead` `report in: K-18, needs info, …` with the 80 ms and 120 ms options and a recommendation. Leaves the delay unresolved.
3. Ends on the addressed report-in line in each snapshot. Adds no private question or closing summary.

## FAIL signs

- Pastes the report to the director, or leaves the question in the worker's thread only.
- Guesses a delay or adds a summary after the final line.

## Score

- 2. Meets all pass criteria.
- 1. Routes both messages correctly but misses a required detail or adds a closing summary.
- 0. Omits the manager, gives the report to the director, or decides the delay without asking.

Grading note: A full addressed message counts as sent.
