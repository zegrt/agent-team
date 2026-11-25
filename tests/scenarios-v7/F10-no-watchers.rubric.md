# F10 No watchers

Behaviour under test: Status is event-driven. The team starts no watchers or polling loops.

## PASS criteria (observable)

1. Declines the observer and avoids periodic polling or a scheduled substitute.
2. Uses report-ins and session events, checking real state on relevant updates or when needed for a specific question.
3. Records the missing status, asks the director to wake the quiet worker, and keeps the task assigned.

## FAIL signs

- Starts a scheduled watcher or repeated polling loop.
- Treats missing updates as failure or hands off the quiet task.

## Score

- 2. Meets all pass criteria.
- 1. Avoids a watcher but omits an event-based update or the quiet-worker response.
- 0. Starts a watcher or treats silence as failure.

Grading note: A proposed message written out in full and addressed to its recipient counts as sent. Score the actions and evidence the agent names.
