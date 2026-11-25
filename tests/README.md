# Tests

How each rule is checked: fresh agents get a real situation, with and without the skill, and graders score each
answer blind against a rubric (0 fail, 1 partial, 2 pass). A rule that changes nothing is cut.

## In short

- **The skill mostly helps.** On scenarios it had never seen, scores went up in most cases on both Claude and Codex.
  The one drop (I2b on Claude, 1.2 to 1.0) came from the rubric asking a builder to edit the board, which the skill
  reserves for the manager.
- **It isn't perfect.** Some held-out scores with the skill are still 1 out of 2, some gaps remain, and one scenario
  (S2 on Claude) gave no result because of a harness limit. All of it is in the log below.
- **The lab has a limit.** Each held-out scenario counts as fresh only until it shapes the skill. The results below
  cover earlier revisions.

## The method

- **Scenarios** pair a prompt about a fictional project with a rubric. A fixture supplies files and Git history
  where needed. Earlier held-out scenarios were written without access to the skill's wording.
- **Two arms.** Both arms get the same prompt and board header when the fixture has a board. The skill arm copies
  `SKILL.md` and `scripts/` with either `team/` or the earlier `RULES.md` and `templates/` layout. Rubrics and
  results stay outside both copies.
- **Blind grading.** The grader strips card IDs, the skill name and paths to its files before grading. Codex uses an
  empty home for runs and retains its configured `CODEX_HOME` for authentication.
- **Held out once.** A held-out scenario counts as a test only until its result changes the wording; after that it
  is a tuning scenario.

| Set | Folder | Project | Status |
|---|---|---|---|
| Tuning | `scenarios/` (T1 to T5, H1, H2, R1, R2) | northwind-guide | all have shaped the wording |
| Held-out 2 | `scenarios-v2/` (S1 to S4) | larder-site | used once, now tuning |
| Ideas, tuning | `scenarios-v3/` (I1a, I2a, I3a) | summit-site | tuning |
| Ideas, held out | `scenarios-v3-held/` (I1b, I2b, I3b) | summit-site | used once, now tuning |
| Two modes | `scenarios-v7/` (F01 to F10, G01 to G03, P01, S01) | fictional kiosks and tram app | tuning scenarios |

## Running it

Runs are full agent sessions on your own Claude Code and Codex logins, so they count against your usage limits. A
full pass is well over a hundred sessions. Runs are read-only, on copies of the fixture under `work/`.

```sh
cd tests
bash make-fixture.sh                                    # builds ./fixture for scenarios/
bash batch.sh base  scenarios out 5                     # 5 runs per scenario, Claude and Codex, no skill
bash batch.sh skill scenarios out 5 "$(cd .. && pwd)"   # the same, with the skill
python3 grade.py out scenarios                          # blind grades, per scenario, arm and grader

# The other sets each build their own fixture and need it named:
bash scenarios-v3/fixture.sh "$PWD/fixture-v3"
FIXTURE=$PWD/fixture-v3 bash batch.sh skill scenarios-v3 out-v3 5 "$(cd .. && pwd)"
```

Options: `batch.sh <arm> <scenario-folder> <out> <runs> [skill-folder] [tools]` (tools defaults to
`"claude codex"`). `CLAUDE_MODEL=haiku` runs Claude on a smaller model; `GRADERS=codex` grades with one model only.
`scenarios-v2/fixture.sh <dir> S1` builds the variant S1 needs; put S1's prompt in its own folder.

Saved grades for every run are in `results/`.

### V7 and the Northwind fixture

V7 covers the ten team changes, mode selection, solo growth, the six solo habits and the final report-in.
Most prompts supply project state and grade the agent's stated actions. The neutral fixture has no board.
For G02, use the worker fixture, which has the named assignment, the brief and the scoped files.

```sh
cd tests
bash scenarios-v7/fixture.sh "$PWD/fixture-v7"
FIXTURE="$PWD/fixture-v7" bash run.sh codex skill scenarios-v7/G01-mode-gate.prompt.md 1 out-v7/codex-skill ..
bash scenarios-v7/fixture.sh "$PWD/fixture-v7-worker" worker
FIXTURE="$PWD/fixture-v7-worker" bash run.sh codex skill scenarios-v7/G02-board-worker.prompt.md 1 out-v7/codex-skill ..
GRADERS=codex python3 grade.py out-v7 scenarios-v7
```

Run `bash tests/check-team.sh` from the project root to check protected branches, approval pins, status counts
and rehearsal cleanup with real local Git. The test intercepts all pushes.

The old Northwind fixture only listed tasks 21–24. It now also includes T14 and T15 for H1 and T9 for H2, with
their briefs and Git evidence. H1 now labels T14 `building` because the worker has already started. H2 can read
the palette, the task branch and the incoming review. Older scenario scores are historical.

## Log

### Earlier results, 17 Nov 2026 (kept for the record; weaker method)

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

After talking with the first project's manager (17 Nov): self-check named apart from the independent review, Small
keeps any approval the board requires, "Proposals" renamed "Noticed", one team per board. Rerun of T3, T4 and R1,
3 runs each: all 2.0 on both tools.

A new rule adds a scenario; a rule that changes no score is cut.

### Held-out set 2, 18 Nov 2026 (mean out of 2, 5 runs per arm, both graders averaged; no skill -> skill)

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

### Check of the old scenarios after the 18 Nov changes (skill arm only, 2 runs, both graders)

With the Claude grader every scenario scored 2.0 on both tools. The Codex grader gave 1.0 to 1.5 on a few (Codex
T1, T2, T4, T5, R1; Claude H1, H2, R2, T5). Nothing fell to 0 on both graders. Grades in `results/`.

### Three ideas from the first project's inbox, 18 Nov 2026 (mean out of 2, 5 runs, both graders averaged)

The first project's board kept 7 general rules the skill didn't hold. Two were already covered; the other five came down to three
ideas: a run is one task (and nobody steers a worker mid-run except to hold it); a file belongs to the open task
that lists it; what goes to the director is facts with commit hashes and exact scope, and a question says what
happens on each answer. A separate agent wrote two scenarios for each: "a" ones to tune on (`scenarios-v3/`), "b"
ones sealed until the final run (`scenarios-v3-held/`). Fixture: `scenarios-v3/fixture.sh <dir>`.

Tuning set, no skill -> skill before the new lines -> skill with them:

| Scenario | Claude | Codex |
|---|---|---|
| I1a builder asked "while you're at it" | 0.0 -> 1.2 -> 1.0 | 0.0 -> 1.1 -> 1.0 |
| I2a manager fixes a typo in a task's file | 1.0 -> 1.3 -> 1.7 | 1.0 -> 1.7 -> 1.7 |
| I3a end-of-day report | 0.7 -> 1.0 -> 0.8 | 1.0 -> 1.0 -> 1.5 |

Held-out set, no skill -> skill with the new lines:

| Scenario | Claude | Codex |
|---|---|---|
| I1b director asks to add requirements to a running task | 0.0 -> 0.0 | 0.0 -> 1.4 |
| I2b builder needs a file another task owns | 1.2 -> 1.0 | 0.5 -> 1.0 |
| I3b decision question under time pressure | 0.8 -> 1.2 | 1.0 -> 1.5 |

What it shows:
- I1a and I2b: with the skill, every remaining lost point is the rubric asking a builder to edit the board, which the
  skill reserves for the manager. On the skill's own terms those answers pass.
- I1b: with the skill, Claude amends the running task's brief on the board and tells the builder to pull. Board
  first and no steering mid-run pull against each other there; the skill doesn't yet say which wins.
- I3: Claude's reports to the director still often leave out commit hashes.

### Restructure check, 18 Nov 2026 (one task-change card, message forms, scripts)

Claude's usage limit ran out mid-run, so Claude was checked on Haiku (the smallest model, `CLAUDE_MODEL=haiku`),
new wording against the committed wording, graded by Codex only. Mean out of 2:

| Scenario | Haiku, committed wording (3 runs) | Haiku, new wording (3 runs) | Codex, new wording (5 runs) |
|---|---|---|---|
| I1b change to a running task | 0.0 | 0.7 | 1.0 |
| I3a end-of-day report | 0.7 | 1.0 | 1.2 |
| I3b decision question | 0.0 | 0.3 | 1.0 |
| T1 correction on the board first | 0.3 | 0.0 | 2.0 |

The new wording is ahead on the three scenarios it was for. T1 fails on Haiku with either wording (it repeats the
correction in the message), so that is the model, not the change; Codex keeps 2.0. One run of every older scenario
on the new wording, on Codex: none fell to 0 (H1 went from 2 to 1 on its single run). These are tuning checks on spent scenarios, not proof; real use
(the board's Corrections list) is the test from here.

### The `report in` line, 19 Nov 2026 (first change from real use)

From a real project: a reviewer sent its findings to the director, and the manager was polling threads to see
who had finished. New: every builder or reviewer run ends with one line to the manager, `report in: <id>, <status>,
<where>`, never to the director even when asked ([message form](../team/templates/MESSAGES.md)). Two new scenarios
(`scenarios-v4`, written blind), with the director asking in the worker's own session for the report. Old wording
against new, 3 runs each, graded by Codex only. Mean out of 2:

| Scenario | Haiku, old | Haiku, new | Codex, old | Codex, new |
|---|---|---|---|---|
| P1 builder, director says "paste it to me" | 0.0 | 0.0 | 1.0 | 1.3 |
| P2 reviewer, director asked for findings directly | 0.0 | 0.3 | 1.0 | 1.3 |

A small gain, and nothing went down. Codex's lost points: it also gave the director a summary, or asked the director
to confirm the rule. Haiku gives in to the director with either wording (as in I3b). P1 on Haiku is not a fair
read: the fixture has no commit 4b9e1d7, so Haiku found the work "missing" and held its report. Fix the fixture
before reusing P1. These scenarios now count as tuning.

### "No one reads your thread", 22 Nov 2026 (second change from real use)

From a real project: workers narrated as if the director were reading, and some questions in workers' own
threads went unanswered. A count across that project's 132 threads: agents' own prose is about 4% of all text (tool
traffic is the rest), and 27% of that prose is in-run narration. Builders and reviewers narrate most (44 to 85%), PMs
least (about 10%). So the token cost is small; the real cost is questions nobody sees. New: the brief names the
manager's address; a question goes to the manager as `report in: <id>, needs info, <question, options,
recommendation>`; the run's last message is that line, with no summary for the director.

One new blind scenario (`scenarios-v5`, P3: a builder hits a real ambiguity while no one is watching), old wording
against new, 3 runs each, graded by Codex. The first grading gave every run 0 because the test runs have no messaging
tool and agents said so honestly; the rubric now counts a message written out in full as sent, and both arms were
re-graded. Mean out of 2:

| Scenario | Haiku, old | Haiku, new | Codex, old | Codex, new |
|---|---|---|---|---|
| P3 builder with a question, nobody watching | 1.0 | 1.0 | 0.0 | 1.0 |

With the old wording, Codex wrote the question in its own session and sent mac-lead only a pointer to it, which is
the failure seen in real use. With the new wording it put the question in the line (one run scored 2). Haiku reaches
the manager either way but writes too much. This scenario now counts as tuning.
