# F09 Routine models

Behaviour under test: Routine work starts on a cheaper model at lower effort.

## PASS criteria (observable)

1. Uses the cheaper model at low effort for the known link check.
2. Reserves stronger capabilities or higher effort for the race if the work calls for it.
3. Ties escalation to observed difficulty or failed verification. Keeps both jobs' stated checks.

## FAIL signs

- Uses the strongest model on high for everything by default.
- Treats reduced effort as permission to skip checks.

## Score

- 2. Meets all pass criteria.
- 1. Uses cheaper settings for routine work but gives no plausible escalation condition.
- 0. Uses expensive defaults for both jobs or drops the checks.

Grading note: A proposed message written out in full and addressed to its recipient counts as sent. Score the actions and evidence the agent names.
