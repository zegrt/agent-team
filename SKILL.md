---
name: agent-team
description: Use when working in a team of AI agents run by a human director - as the manager, a builder or a reviewer - in separate sessions, threads or machines, with Claude Code and Codex together and a shared work board (WORKBOARD.md). Use when briefing, assigning, building, reviewing, assessing review findings, merging, escalating a decision, or handing off work between agents, and when a board's first line names the agent-team skill.
---

# Agent team

One director, one manager, builders and reviewers, each in its own session; one team per board. The board is the record; messages only
point to it. The checks live in forms (`templates/`); the judgment calls live in cards (`RULES.md`). This file is the
start; read the form or card it points to when you reach that step. `<skill>` below is this skill's folder.

## Every session, first

1. `git pull --ff-only` in this skill's folder, then pull the project. If you can't (no network, a sandbox), say so
   to the manager and go on with what you have.
2. Read the board, your own handoff if you have one (`git show origin/worker-<you>:workers/<you>.md`) and the
   director's profile, if the board names one.
3. Check your folder is clean and on the branch your task names. If the folder is shared and your task has its own
   branch, make your own worktree for it (see Builder); if you can't, ask the manager. If it is dirty or on a branch
   you can't explain, stop and ask the manager. Never switch branches in a folder someone else works in (`team.worktree`).
4. After a summary or a resume you are a new session: trust the board and `git log` over your memory, and re-read this
   file.

Precedence: a live instruction from the director, then the board, then the director's profile, then this skill. The
manager writes any live instruction onto the board straight away. If a live instruction goes against a rule here (for
example "one more quick fix" after two failed rounds), don't follow it yet: put it on the board as "pending: breaks
<rule>, asked director", tell the director plainly which rule it breaks and why the rule exists, give your
recommendation, and act on the answer. Nobody acts on a pending line.

## Size first

Every task has a size, stated in plain words on its row, so the director can overrule it. If it grows, stop, say so,
and step up a size. Judge by three facts: gaps in what the director asked for; anything irreversible or
outward-facing; how much it touches.

- **Small** (pointers, typos, board edits): the manager does it and says so. No brief and no independent review, but
  any approval the board requires still applies.
- **Content:** brief, builder, one independent review, the director's approval.
- **Design** (structure, a new approach): a written plan to the director first. Don't assign, queue or start the build
  until the director approves the plan; then build it as Content.

## Your role

**Manager.** Only you edit the board.
- Write every task, decision and correction on the board first, commit and push, then message in a shape from
  `templates/MESSAGES.md`, never with the correction in it (`board.one-source`).
- A building task's brief is frozen: a change holds and restarts it, or becomes a new task; a hold is the only
  message a building task gets. Files an open task lists are its own: change them through it or after it
  (`task.change`).
- Live work first: a correction from live work goes ahead of improvement work (`team.live-first`).
- Keep about 3 agents active; add one only while the director keeps up with reviewing (`team.size`).
- Brief Content and Design tasks with `templates/BRIEF.md`, saved as `briefs/<id>.md`. Assign nothing whose Files
  overlap an open task. Builder and reviewer are never the same agent.
- When a review lands, route every finding before any fix (`review.assess`). After fixes, the reviewer re-checks.
- Two failed rounds on the same thing: stop and rewrite the brief (`review.restart`).
- Before asking for approval: `python3 <skill>/scripts/team.py rehearse <id> -- <check command>` (latest main merged
  into a throwaway copy, never the builder's branch). After the director approves, one task at a time:
  `team.py merge <id>` (merges the task and its review, moves `approved`, deletes both branches), then set the row
  to merged. If the script can't run, `team.py steps` lists the same steps by hand (`team.manager`).
- Status and questions to the director use the forms in `templates/MESSAGES.md`; `team.py status` gives each task's
  state and hash (`decide.escalate`).
- A quiet worker is not a dead one: ask the director to wake it; never reassign its task (`team.unreachable`).

**Builder.**
- One task per run. Do only the brief; anything else you notice goes in your report under Noticed. When it is done,
  report, push, send the manager `report in` and end the run. A second task, even "while you're at it", waits until the manager puts it on the
  board for you: decline it plainly and say how it can still get done (`task.change`).
- Work in your own worktree on the task's branch: if your folder is shared, make it yourself and say where it is
  (`git worktree add ../<project>-<id> -b <branch>` for a new branch, without `-b` if the branch exists). Check the
  branch before every commit.
- Never edit or remove a test or check to make it pass.
- Done means the brief's checks were run and their output is in your report. Write it with `templates/REPORT.md` as
  `reports/<id>.md` on the task branch; the status is one of four (done, done with concerns, needs info, blocked), and
  silence is not a status.
- Check your own work before reporting, always: run the brief's checks and look at the result. That check is not the
  review. The independent review is never yours, even if asked: a builder's own review counts for nothing.

**Reviewer.** Start clean: read the brief and the work, not the builder's report (`reports/<id>.md`). Write the review
with `templates/REVIEW.md` as `reviews/<id>.md`, and commit it only to your own branch, `review-<id>`, made from main
so it holds nothing but your review. Read the work with `git diff origin/main...origin/<branch>`; to run checks, use a
detached worktree (`git worktree add --detach ../<project>-check-<id> origin/<branch>`). Ask what is missing. Change
nothing else; never commit to the task branch or main.

**Everyone.** Push only to your own branches, as the board's "Where files go" table says; only the manager commits to
main. A builder's or reviewer's run ends with one line to the manager, `report in: <id>, <status>, <where the report
is>` (`templates/MESSAGES.md`). Reports go to the manager, never to the director, even when the director asks in your
session; tell the director it went to the manager. No one reads your own thread: a question goes to the manager as
`report in` with status needs info, and the run's last message is that line, not a summary. Update and push your handoff (`templates/HANDOFF.md`) at the end of each day's work. Stop and ask before anything irreversible or outward-facing (seen outside the
team: publishing, sending, deleting others' work; pushing your own branch is neither).

## Red flags

What agents said in the tests, and what to do instead:

| They said | Instead |
|---|---|
| "The message is what gets the work moving" | The board line takes a minute. Board first, then "board updated, pull". |
| "I've added the new requirements to the brief; builder, pull" (task building) | A building brief is frozen: finish then a new task, or hold and restart. |
| "I'll change that one cell when I can edit again" | After never comes for the next session. Board first. |
| "Queue task 24 for win-claude when they're free" (a restructure, no plan yet) | Design waits for an approved plan. Nothing is assigned before it. |
| "A worker builds it rather than me, so my review stays independent" (a one-word fix) | Small: the manager does it and says so. |
| "Please assign me a separate worktree" | Make your own worktree and say where it is. |
| "If win-claude hasn't reported by 16:30, may I give T14 to mac-codex?" | A quiet worker is not a dead one. Ask the director to wake it. |
| "Dana's instruction takes precedence over the normal restart rule" | Say which rule it breaks, recommend, then act on the answer. |

## Cards

Read `RULES.md` when a step names one: `board.one-source`, `task.size`, `task.change`, `review.assess`, `review.restart`,
`decide.escalate`, `team.worktree`, `team.unreachable`, `team.live-first`, `team.manager`, `team.size`.
