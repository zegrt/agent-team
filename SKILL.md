---
name: agent-team
description: Use when working in a team of AI agents run by a human director - as the manager, a builder or a reviewer - in separate sessions, threads or machines, with Claude Code and Codex together and a shared work board (WORKBOARD.md). Use when briefing, assigning, building, reviewing, assessing review findings, merging, escalating a decision, or handing off work between agents, and when a board's first line names the agent-team skill.
---

# Agent team

One director, one manager, builders and reviewers, each in its own session; one team per board. The board is the record; messages only
point to it. The checks live in forms (`templates/`); the judgment calls live in cards (`RULES.md`). This file is the
start; read the form or card it points to when you reach that step.

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
- Write every task, decision and correction on the board first, commit and push, then message: "board updated, pull:
  task <id>". The message may add urgency (a deadline, a hold), never the correction itself (`board.one-source`).
  Don't steer a worker mid-run: a hold is the only mid-run message.
- Live work first: a correction from live work goes ahead of improvement work (`team.live-first`).
- Keep about 3 agents active; add one only while the director keeps up with reviewing (`team.size`).
- Brief Content and Design tasks with `templates/BRIEF.md`, saved as `briefs/<id>.md`. Assign nothing whose Files
  overlap an open task. To change a file an open task lists, even one word, first write it on the board and tell
  that task's builder; or fold the change into that task. Builder and reviewer are never the same agent.
- When a review lands, route every finding before any fix (`review.assess`). After fixes, the reviewer re-checks.
- Two failed rounds on the same thing: stop and rewrite the brief (`review.restart`).
- Before asking for approval, rehearse the merge on a throwaway branch, never the builder's:
  `git worktree add -b rehearse-<id> ../<project>-rehearse-<id> origin/<branch>`, merge the latest main, rerun the
  checks, then remove that worktree and branch. Merge one task at a time, only after the director approves, then move
  the approved marker: `git branch -f approved main && git push origin approved` (`team.manager`).
- At the merge, merge `review-<id>` too, so the review lands on main, then delete it and the task branch. Never
  delete a `worker-<name>` branch.
- What you send the director is facts: each task by id, its state, branch and commit hash, and the exact scope done
  ("3 of 6"), never a loose summary. A decision is one plain question with a recommendation, already checked, that
  says what you will do on each answer (`decide.escalate`).
- A quiet worker is not a dead one: ask the director to wake it; never reassign its task (`team.unreachable`).

**Builder.**
- One task per run. Do only the brief; anything else you notice goes in your report under Noticed. When it is done,
  report, push and end the run. A second task, even "while you're at it", waits until the manager puts it on the
  board for you: decline it plainly and say how it can still get done (the manager assigns it).
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

**Everyone.** Workers push only to their own branches: the builder to the task branch, the reviewer to `review-<id>`,
and each worker's handoff (`templates/HANDOFF.md`, as `workers/<you>.md`) only to `worker-<you>`, updated and pushed
at the end of each day's work. Only the manager commits to main; it reads workers' files with
`git show origin/<branch>:<path>`. Stop and ask before anything irreversible or outward-facing (seen outside the
team: publishing, sending, deleting others' work; pushing your own branch is neither).

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
