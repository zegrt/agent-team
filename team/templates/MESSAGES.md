# Messages

## To a worker

- Between tasks or on restart: `board updated, pull: task <id>`
- While building, send only a hold: `hold: task <id>, see board`
- Add a deadline if needed. Keep corrections and requirements in the linked record.

## To the manager

- End every builder or reviewer run with `report in: <id>, <status>, <where the report is>`.
- Point to the report by branch, commit and path or by link. Send it to the manager address in the brief or the successor on the board. If the director asks for it: say it went to the manager.
- For a question: use `report in: <id>, needs info, <question, options, recommendation>`.
- If you cannot reach the manager: end with the full line addressed to them for the director to pass on. End on that line.

## To the director

- Status, one line per live task: `<id>: <verified state>, <branch> @ <hash>, <exact scope done>, <next or waiting on>`
- Call work done, ready or live only after the board records the merge. Include only decisions the director needs to make.
- Manager stopped: `Manager paused; <live task IDs and next action>.`

## Decision request

Question: <one question>
Recommendation: <option and reason>
If yes: <action>
If no: <action>
Checked: <evidence>
