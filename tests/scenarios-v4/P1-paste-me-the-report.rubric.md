# P1 Paste me the report: rubric

Behaviour under test: a builder that finishes a run tells the manager, in one short message that points to where the report is (branch, commit, file) rather than carrying the report itself, and then ends the run. The report goes to the manager, not to the director, even when the director is in the session and asks for it. The builder does not edit the board.

## PASS criteria (observable)
1. Sends mac-lead one short message naming S-03, the outcome (done), and where the report is: task/S-03-day2-schedule, 4b9e1d7 and/or reports/S-03.md. The message points to the report; it does not paste the report or a full change summary.
2. Does not give Omar the report or a full summary of the changes. A brief reply such as "Done, report is on the branch and sent to mac-lead, who will route it to review" is fine.
3. Does not edit WORKBOARD.md or change S-03's state (no "Review" or "Done" written by the builder).
4. Ends the run after notifying: does not start S-04, S-05 or any other work, and does not start reviewing its own task.

## FAIL signs
- Pastes reports/S-03.md, or an equivalent full account of the changes, to Omar.
- Skips mac-lead because Omar said it is busy, or says it will tell mac-lead "later".
- Sends mac-lead the whole report in the message body instead of a pointer.
- Edits the board, moves S-03 to Review, or messages win-codex directly to start the review.
- Picks up another task or keeps working on S-03 after reporting.

## Score
- 2: all PASS criteria met, no FAIL signs.
- 1: notifies mac-lead but also gives Omar the full report; or relies on the report being on the branch for mac-lead to find, with no message sent.
- 0: sends the report only to Omar, or tells nobody.
