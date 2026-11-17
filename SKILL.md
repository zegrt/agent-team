---
name: agent-team
description: Use when working in a team of AI agents run by a human director - as the manager, a builder or a reviewer - in separate sessions, threads or machines, with Claude Code and Codex together and a shared work board (WORKBOARD.md). Use when briefing, assigning, building, reviewing, assessing review findings, merging, escalating a decision, or handing off work between agents, and when a board's first line names the agent-team skill.
---

# Agent team

One director, one manager, builders and reviewers, each in its own session. The board is the record; messages only
point to it. The checks live in forms (`templates/`); the judgment calls live in cards (`RULES.md`). This file is the
start; read the form or card it points to when you reach that step.

## Every session, first

1. `git pull --ff-only` in this skill's folder, then pull the project.
2. Read the board, your own handoff (`workers/<you>.md`) and the director's profile, if the project has one.
3. Check your folder is clean and on the branch your task names. If the folder is shared and your task has its own
   branch, make your own worktree for it (see Builder). If it is dirty or on a branch you can't explain, stop and ask
   the manager. Never switch branches in a folder someone else works in (`team.worktree`).
4. After a summary or a resume you are a new session: trust the board and `git log` over your memory, and re-read this
   file.

Precedence: a live instruction from the director, then the board, then the director's profile, then this skill. The
manager writes any live instruction onto the board straight away. If a live instruction goes against a rule here (for
example "one more quick fix" after two failed rounds), don't follow it yet: tell the director plainly which rule it
breaks and why the rule exists, give your recommendation, and act on the answer.

## Size first

Every task has a size, stated in plain words on its row, so the director can overrule it. If it grows, stop, say so,
and step up a size. Judge by three facts: gaps in what the director asked for; anything irreversible or
outward-facing; how much it touches.

- **Small** (pointers, typos, board edits): the manager does it and says so. No brief, no review.
- **Content:** brief, builder, one independent review, the director's approval.
- **Design** (structure, a new approach): a written plan to the director first. Don't assign, queue or start the build
  until the director approves the plan.

## Your role

**Manager.** Only you edit the board.
- Write every task, decision and correction on the board first, commit and push, then message: "board updated, pull:
  task <id>". The message may add urgency (a deadline, a hold), never the correction itself (`board.one-source`).
- Live work first: a correction from live work goes ahead of improvement work (`team.live-first`).
- Keep about 3 agents active; add one only while the director keeps up with reviewing (`team.size`).
- Brief Content and Design tasks with `templates/BRIEF.md`, saved as `briefs/<id>.md`. Assign nothing whose Files
  overlap an open task. Builder and reviewer are never the same agent.
- When a review lands, route every finding before any fix (`review.assess`). After fixes, the reviewer re-checks.
- Two failed rounds on the same thing: stop and rewrite the brief (`review.restart`).
- Before asking for approval: merge the latest main into the branch in your own worktree and rerun the checks. Merge
  one task at a time, only after the director approves, then move the approved marker:
  `git branch -f approved main && git push origin approved` (`team.manager`).
- A decision for the director: one plain question with a recommendation, already checked (`decide.escalate`).
- A quiet worker is not a dead one: ask the director to wake it; never reassign its task (`team.unreachable`).

**Builder.**
- Do only the brief. Anything else you notice goes in your report as a proposal.
- Work in your own worktree on the task's branch: if your folder is shared, make it yourself and say where it is
  (`git worktree add ../<project>-<id> -b <branch>` for a new branch, without `-b` if the branch exists). Check the
  branch before every commit.
- Never edit or remove a test or check to make it pass.
- Done means the brief's checks were run and their output is in your report. Fill the Report block at the end of the
  brief; the status is one of four (done, done with concerns, needs info, blocked), and silence is not a status.
- Never review your own task, even if asked: its approval counts for nothing.

**Reviewer.** Start clean: read the brief and the work, not the builder's account of it. Write the review with
`templates/REVIEW.md` as `reviews/<id>.md`. Ask what is missing. Change nothing else and never move a branch.

**Everyone.** Workers write only their own files: the report in their brief, their review, their handoff. At the end
of each day's work, update and push your handoff (`templates/HANDOFF.md`). Stop and ask before
anything irreversible or outward-facing.

## Red flags

What agents said in the tests, and what to do instead:

| They said | Instead |
|---|---|
| "The message is what gets the work moving" | The board line takes a minute. Board first, then "board updated, pull". |
| "I'll change that one cell when I can edit again" | After never comes for the next session. Board first. |
| "Queue task 24 for win-claude when they're free" (a restructure, no plan yet) | Design waits for an approved plan. Nothing is assigned before it. |
| "A worker builds it rather than me, so my review stays independent" (a one-word fix) | Small: the manager does it and says so. |
| "Please assign me a separate worktree" | Make your own worktree and say where it is. |
| "If win-claude hasn't reported by 16:30, may I give T14 to mac-codex?" | A quiet worker is not a dead one. Ask the director to wake it. |
| "Dana's instruction takes precedence over the normal restart rule" | Say which rule it breaks, recommend, then act on the answer. |

## Cards

Read `RULES.md` when a step names one: `board.one-source`, `task.size`, `review.assess`, `review.restart`,
`decide.escalate`, `team.worktree`, `team.unreachable`, `team.live-first`, `team.manager`, `team.size`.
