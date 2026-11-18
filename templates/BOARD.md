Team rules: the agent-team skill; read it first.

# <Project>: work board

<!-- Only the manager edits this file. Why: one writer per file, the board included. Basis: the director, 9 Nov 2026. -->

## Where files go

| File | Branch | Written by |
|---|---|---|
| WORKBOARD.md, briefs/<id>.md, everything merged | main | manager only |
| the work, reports/<id>.md | the task's branch | its builder |
| reviews/<id>.md | review-<id>, made from main | its reviewer |
| workers/<name>.md (handoff) | worker-<name>, never deleted | that worker |

<!-- The manager reads workers' files with git show origin/<branch>:<path>. Basis: playbook manager and blind
     review, 18 Nov 2026 (git won't open one branch in two folders). -->

Approved state: branch `approved` <!-- the last state the director approved; restore from it if main breaks.
     Moved after each approved merge: git branch -f approved main && git push origin approved. the director, 9 Nov 2026 -->

## Roles

| Role | Who | Where (machine, thread) |
|---|---|---|
| Director | | |
| Manager | | |
| Builder / reviewer | | |

Director's profile: <path, or none>

## Project rules

<!-- Only additions to or tightenings of the skill's rules, each with its date. Don't copy the skill. -->

## Corrections

<!-- Every correction from the director, dated, in their words, with the rule it applies or "new". The same correction
     twice means a rule is failing: send it to the skill's inbox. This list is how the skill is tested in real use.
     Basis: 18 Nov 2026 (real use, not lab tests, is the test). -->

## Decisions

<!-- Dated, newest last. "<date>: <decision> (<who>)". A live instruction from the director goes here straight away; one that breaks a
     skill rule goes in as "pending: breaks <rule>, asked director" until the director answers. -->

## Tasks

<!-- Size: Small / Content / Design, stated so the director can overrule it (task.size).
     Files: what it touches; nothing assigned whose Files overlap an open task (the director, 9 Nov 2026).
     Branch: checked before every commit (team.worktree; the director, 17 Nov 2026).
     Builder and Reviewer must differ; a builder's own review counts for nothing (the director, 17 Nov 2026).
     Rounds: failed review rounds so far; at 2 failed, review.restart.
     State: open, building, built, in review, reviewed, approved (date), merged; or held, blocked, needs info,
     pending. Only the manager moves it (task.change). Checked against the work, never trusted
     (Gas Town #4505: blocked work marked done). python3 <skill>/scripts/team.py status shows each with its hash. -->

| Id | Task | Size | Files | Branch | Builder | Reviewer | Rounds | State | Brief |
|---|---|---|---|---|---|---|---|---|---|

## Noticed

<!-- Anything a worker noticed outside its task, with the task it came from. Nobody acts on one until the manager
     makes it a task. Basis: BMAD deferred-work; Beads discovered-from. -->
