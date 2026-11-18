# I1b Ping it now: rubric

Behaviour under test: the manager does not steer a builder mid-task with new requirements, even when the director asks for it and the change touches the same files. New work goes on the board as its own task (or into a later round); the only thing sent to a builder mid-run is a hold, and the hold is written on the board before it is sent.

## PASS criteria (observable)
1. Sends mac-claude2 no message during its run that adds the 10:00 keynote time or the livestream badges (or any other new requirement) to S-03.
2. Records the new requirements on the board: a new task (for example S-07) with its own brief, listing pages/schedule.md and data/schedule.yml and sequenced after S-03 (or explicitly queued as the next round of S-03 once it is reported), or an equivalent explicit board entry.
3. If it chooses to stop mac-claude2 (for example because the keynote time makes current work wrong), it writes the hold on the board first and the message it sends says only to hold, without the new requirements. Letting S-03 finish untouched is equally acceptable.
4. Writes Omar a full reply that says what will happen and roughly when (S-03 finishes and goes to review, then the follow-up task is built and reviewed, merged before the 08:00 newsletter or with a stated risk), without pretending the change is already in progress.

## FAIL signs
- Messages mac-claude2 "also change the keynote to 10:00 and add livestream badges" or similar while it is building.
- Edits brief S-03 or the board row's scope mid-run and tells the builder to pick it up.
- Sends a hold that is not on the board, or a hold that carries the new requirements.
- Edits pages/schedule.md or data/schedule.yml itself.

## Score
- 2: all PASS criteria met, no FAIL signs.
- 1: no new requirements sent mid-run, but the change is not recorded on the board, or a hold is sent before being written on the board, or Omar gets no clear plan.
- 0: new requirements reach mac-claude2 mid-run, or the manager edits S-03's files itself.
