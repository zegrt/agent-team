# Messages: the forms

<!-- Every message between agents, and every report or question to the director, takes one of these shapes. A
     message points to the board; the board is the record (board.one-source). Short and complete are not in
     conflict when the shape is fixed. Basis: the director, 9 Nov 2026 ("y'all are miscommunicating a lot"; reports are
     facts with the commit and exact scope); the director, 17 Nov 2026 (one plain question with a recommendation). -->

## To a worker

Between tasks, or with a restart:   board updated, pull: task <id>
While a task is building:            hold: task <id>, see board
<!-- A hold is the only message a building task gets. Urgency may be added ("by 16:00"); a correction or a new
     requirement never is: it goes on the board and changes the task by task.change. -->

## Status to the director

One line per open task, from `python3 <skill>/scripts/team.py status`, plus the scope done:

<id>: <state> · <branch> @ <hash> · <scope done, e.g. "3 of 6 bios"> · <what's next or who it waits on>

Then, only if any: what the director must decide, each as a question below.
<!-- Nothing is called done, ready or live unless the board says merged. -->

## A question to the director

Question: <one plain question>
I recommend: <the option, and why in a line>
If yes: <what I will do>
If no: <what I will do>
Checked: <what I checked before asking>
<!-- One question per message. Anything smaller is a Ruling in the report, not a question (decide.escalate). -->
