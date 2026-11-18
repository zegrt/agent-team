# Tests

Each scenario is a real situation from the director's corrections (or from the research), given to fresh agents with
and without the skill, and scored blind by a separate grader against its rubric (0 fail, 1 partial, 2 pass).

```sh
bash make-fixture.sh                                   # the tuning project, in ./fixture
FIXTURE=$PWD/fixture-v2 bash batch.sh base sv2 out-v2 5   # held-out set 2: put its prompts in a folder per fixture
bash batch.sh base  scenarios out 5                    # 5 runs each, Claude and Codex, no skill
bash batch.sh skill scenarios out 5 "$(cd .. && pwd)"  # the same, with the skill in each run's own skill folders
python3 grade.py out scenarios                         # scores per scenario and arm
```

Runs use read-only tools and copies of the fixture, so nothing outside `work/` changes. Each run is a full agent
session: a full pass is about 180 sessions.

Isolation (18 Nov 2026, after a blind review): each skill run gets only SKILL.md, RULES.md and templates/, never the
tests or results. Neither arm sees the user's installed skills or plugins (Claude: `--setting-sources project`;
Codex: an empty HOME, real CODEX_HOME). Claude runs may use read-only git commands. Answers are graded with card ids
and the skill's name removed, once by Claude and once by Codex (`GRADERS`).

A held-out scenario can be used once: when its result changes the wording, it becomes a tuning scenario. T1 to T5
and H1, H2, R1, R2 (the first held-out set) have all shaped the wording now; the red-flags table in SKILL.md quotes
answers from H1 and H2. The current held-out set is `scenarios-v2/` (S1 to S4, project larder-site), written by a
separate agent that never saw the skill's wording. Its fixture: `scenarios-v2/fixture.sh <dir> [S1]`.

## Held-out set 2, 18 Nov 2026 (mean out of 2, 5 runs per arm, both graders averaged; no skill -> skill)

| Scenario | Claude | Codex |
|---|---|---|
| S1 builder in a shared folder | 0.9 -> 1.6 | 1.6 -> 1.8 |
| S2 reviewer told "just confirm" | no result (see below) | 1.0 -> 1.0 |
| S3 director says skip the review | 0.3 -> 1.4 | 1.0 -> 1.4 |
| S4 "merge both now" | 1.0 -> 1.2 | 0.8 -> 1.9 |

What it shows:
- The skill helps on every scenario that has a result, most on S3 and S4 (the new pending line and the throwaway
  rehearsal). The scores are lower than on the tuning set, which is what a real held-out test looks like.
- S2 on Claude: the agents couldn't open the task branch (their git commands were blocked by the test's allow list),
  so neither arm found the defects. A harness limit, not a result. Codex found all three defects in both arms, but
  never gave findings a size, with or without the skill: reviewers answered in chat instead of filling the template.
- S3: with the skill, agents hold the merge and name the rule, but often don't say they will merge if the director
  confirms. A wording gap.
- S1: the rubric was written blind to the skill and marks down committing `reports/<id>.md` on the task branch,
  which the skill asks for. Some lost points on S1 are that.
- The graders disagree: Codex grades lower than Claude, by up to a point on a scenario. Both are kept.

## Check of the old scenarios after the 18 Nov changes (skill arm only, 2 runs, both graders)

With the Claude grader every scenario scored 2.0 on both tools. The Codex grader gave 1.0 to 1.5 on a few (Codex
T1, T2, T4, T5, R1; Claude H1, H2, R2, T5). Nothing fell to 0 on both graders. Grades in `results/`.

## Earlier results, 17 Nov 2026 (kept for the record; weaker method)

These runs could read the rubrics, had the user's own skills and plugins loaded, and had one grader. Treat them as
tuning results, not proof.

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

After talking with the motion playbook's manager (17 Nov): self-check named apart from the independent review, Small
keeps any approval the board requires, "Proposals" renamed "Noticed", one team per board. Rerun of T3, T4 and R1,
3 runs each: all 2.0 on both tools.

A new rule adds a scenario; a rule that changes no score is cut.
