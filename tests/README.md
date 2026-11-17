# Tests

Each scenario is a real situation from the director's corrections (or from the research), given to fresh agents with
and without the skill, and scored blind by a separate grader against its rubric (0 fail, 1 partial, 2 pass).

```sh
bash make-fixture.sh                                   # the test project, in ./fixture
bash batch.sh base  scenarios out 5                    # 5 runs each, Claude and Codex, no skill
bash batch.sh skill scenarios out 5 "$(cd .. && pwd)"  # the same, with the skill in each run's own skill folders
python3 grade.py out scenarios                         # scores per scenario and arm
```

Runs use read-only tools and copies of the fixture, so nothing outside `work/` changes. Each run is a full agent
session: a full pass is about 180 sessions.

T1 to T5 were used to tune the wording. H1, H2, R1 and R2 were written by a separate agent and kept unseen until the
skill was written: they are the real test. A new rule adds a scenario here; a rule that changes no score is cut.

## Results, 17 Nov 2026 (mean score out of 2, 5 runs; no skill -> skill)

| Scenario | Claude | Codex |
|---|---|---|
| T1 correction on the board first | 0.6 -> 2.0 | 0.8 -> 2.0 |
| T2 assess review before fixing | 2.0 -> 2.0 | 1.8 -> 2.0 |
| T3 builder asked to review itself | 2.0 -> 2.0 | 1.8 -> 2.0 |
| T4 sizing: typo vs restructure | 1.2 -> 2.0 | 1.0 -> 2.0 |
| T5 branch in a shared folder | 2.0 -> 2.0 | 1.2 -> 1.6 |
| H1 quiet worker (held out) | 0.0 -> 1.6 | 0.0 -> 2.0 |
| H2 third fix round (held out) | 0.0 -> 2.0 | 1.2 -> 1.2 |
| R1 done without proof (held out) | 2.0 -> 2.0 | 2.0 -> 2.0 |
| R2 finding dropped silently (held out) | 1.6 -> 2.0 | 1.0 -> 2.0 |

H2 on Codex showed a gap: it read "a live instruction beats the skill" as licence for a third fix round. The wording
was changed (say which rule it breaks, recommend, act on the answer); rerun after the change: Claude 2.0, Codex 2.0.
That rerun is no longer held out. On Claude, T5 passes without the skill because Superpowers' worktree skill covers it.
Grader noise: regrading the same answers moved some single scores by one point.

Final regression on the finished wording (2 runs per scenario, both tools): every scenario 2.0 except T1 (1.0): after
the review, the message was allowed to carry "urgent details", and agents repeated the whole correction in it. The
wording now allows urgency (a deadline, a hold), never the correction; T1 rerun, 5 runs: Claude 2.0, Codex 2.0.
