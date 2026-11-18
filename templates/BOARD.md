Team rules: the agent-team skill; read it first.

# <Project>: work board

<!-- Only the manager edits this file, and only the manager commits to main. Workers push only to their own
     branches: the report (reports/<id>.md) to the task branch, the review (reviews/<id>.md) to review-<id> (from main), the
     handoff (workers/<name>.md) to worker-<name>. Basis: playbook manager and blind review, 18 Nov 2026.
     Why: one writer per file, the board included. Basis: Cyril, 9 Nov 2026. -->

Approved state: branch `approved` <!-- the last state the director approved; restore from it if main breaks.
     Moved after each approved merge: git branch -f approved main && git push origin approved. Cyril, 9 Nov 2026 -->

## Roles

| Role | Who | Where (machine, thread) |
|---|---|---|
| Director | | |
| Manager | | |
| Builder / reviewer | | |

Director's profile: <path, or none>

## Project rules

<!-- Only additions to or tightenings of the skill's rules, each with its date. Don't copy the skill. -->

## Decisions

<!-- Dated, newest last. "<date>: <decision> (<who>)". A live instruction from the director goes here straight away; one that breaks a
     skill rule goes in as "pending: breaks <rule>, asked director" until the director answers. -->

## Tasks

<!-- Size: Small / Content / Design, stated so the director can overrule it (task.size).
     Files: what it touches; nothing assigned whose Files overlap an open task (Cyril, 9 Nov 2026).
     Branch: checked before every commit (team.worktree; Cyril, 17 Nov 2026).
     Builder and Reviewer must differ; a builder's own review counts for nothing (Cyril, 17 Nov 2026).
     Rounds: failed review rounds so far; at 2 failed, review.restart.
     State: open, built, blocked, reviewed, approved (date), merged. Checked against the work, never trusted
     (Gas Town #4505: blocked work marked done). -->

| Id | Task | Size | Files | Branch | Builder | Reviewer | Rounds | State | Brief |
|---|---|---|---|---|---|---|---|---|---|

## Noticed

<!-- Anything a worker noticed outside its task, with the task it came from. Nobody acts on one until the manager
     makes it a task. Basis: BMAD deferred-work; Beads discovered-from. -->
