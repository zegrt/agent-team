# Team mode

## team.start

- Use one director, one manager and one `WORKBOARD.md` per team. Give each builder and reviewer a separate session.
- Read your role, task and branch on the board. Read the named director profile and your handoff if present. Read handoffs with `git show origin/worker-<name>:workers/<name>.md`.
- Check branch and local changes before pulling. Where authorized, run `git pull --ff-only` in the skill folder and then your project worktree. If a pull fails: tell the manager and use the available version.
- After a summary or resume: reread `SKILL.md` and these rules. Recover your role, task and branch from the board, handoff and `git log`. Check them against the live work.
- Read the linked template at its step. In commands, `<skill>` is this skill's folder.

## team.spec

- Take live instructions from the director first, then board records, the director's profile and this skill. Link each instruction and reference from its task or brief. Pass the links without paraphrasing the director's words or reference. If the original has no link: save the exact words and reference in a shared record and link to that.
- If the instruction conflicts with the team workflow: record `pending: breaks <rule>, asked director` on the board. Tell the director which rule would be bypassed, the concrete effect and what you recommend. Act on their answer.
- Before building: open the linked reference or reproduce the live bug on the version and target in the brief. Record what you saw. If blocked: report what you could access and ask for the missing view or repro.

## team.board

- Use [BOARD.md](templates/BOARD.md). Only the manager edits the board and commits to main. Push only to your assigned branches.
- Record each task and correction on the board before messaging. Record decisions as they arrive in `DECISIONS.md` on main, about 30 lines. Record the date, source link, who decided and scope. Link corrections and decisions from the board. File a direction as a project rule only with explicit standing scope.
- Before messaging a worker: commit and push the record. Check the correction appears by link in the board diff. Use [MESSAGES.md](templates/MESSAGES.md).
- Keep only live task rows and current corrections on the board. Move merged or closed rows to `TASKS-ARCHIVE.md` with their outcome and commit. Move superseded decisions to `DECISIONS-ARCHIVE.md`.
- Record out-of-task discoveries under Noticed with their source task. Act on one when the manager assigns it, subject to the director's approval for suggestions.

## task.size

- Size each task on its row by intent gaps, reach and irreversible or outward-facing actions. Follow the director's sizing decision.
- Small, such as a pointer, typo or board edit: the manager does it, checks it at the target and reports it. Keep any required approval. Skip the brief and review.
- Content: use [BRIEF.md](templates/BRIEF.md) at `briefs/<id>.md` on main. Link it from the row. Assign a builder. Get the director's approval before merging. Apply `review.risk` when deciding whether to assign a reviewer.
- Design, such as a structural change or new approach: get the director's approval on a written plan before queueing, assigning or building. Then use the Content steps.
- If work grows beyond its size: stop, record the change, and resize through `task.change`.
- Give corrections to live work priority over improvements. Start with about three active agents. Add one only while the director keeps up with approvals.

## task.change

- Give each task one state. The manager moves it through open, building (builder named), built (report received), in review and reviewed (if assigned), approved (date), and merged. Use held when the manager stops work, blocked or needs info when reported, and pending for a director decision.
- Assign only disjoint tasks with testable handoffs. Reserve each open task's Files for its builder. Change those files through that task or after it closes.
- A building brief is frozen. Send changes to the manager, including changes made in the builder's session.
- If a change makes current work wrong: record the hold on the board, publish it, send the hold, then rewrite the brief and start a fresh run.
- If the change only adds work: finish as briefed. Queue it separately when approved or leave it until the report.
- Take one task per worker run. If asked for a second task: decline, give the route through the manager and wait for assignment.

## team.worktree

- Use your own worktree. In a shared folder, create it with `git worktree add ../<project>-<id> -b <branch>` for a new branch or omit `-b` for an existing one. Report its path to the manager. Ask the manager if you cannot create it.
- Never switch branches in a shared folder. At startup and before each commit: check the branch and changes. If you find an unexpected branch or edits: stop and ask.
- Remove finished worktrees after preserving cited evidence. First check for local changes and confirm all needed commits are on a retained ref. Ask before deleting anyone else's work.

## build.check

- Work only within the brief's Files and scope. Put unrelated discoveries in Noticed in your report. Never edit or remove a test or check to make it pass.
- Before reporting: run the agreed checks, inspect the results and check the result where the director will see it. Use the real editor, device or app when that is the target. Record the version, steps, outputs and measured timing where applicable. If the target is unavailable: report which checks are missing and request a check there.
- Use status `done` only when every agreed check has passed.
- Commit your [REPORT.md](templates/REPORT.md) as `reports/<id>.md` on the task branch. Push before reporting in. Keep self-checks separate from independent review.

## review.risk

- Assign a separate reviewer only for a named risk with a test on a specific version. Name the person or agent in the row. The builder cannot fill that role.
- Keep a review already agreed for the task. Route requests to waive it through `team.spec`.
- As reviewer: read the brief and inspect the exact change without reading the builder's report. Use `git diff origin/main...<commit> -- . ':(exclude)reports/'` and `git worktree add --detach ../<project>-check-<id> <commit>`.
- Test the named risk. Reproduce a failure before filing it. If you cannot reproduce it: report the attempt and what remains unverified.
- Write [REVIEW.md](templates/REVIEW.md) as `reviews/<id>.md`. Commit only the review, on `review-<id>` from main. Push it before reporting in.
- The review goes to the manager, never to the director, even if the director asks for it.

## review.assess

- Before any fix: record one route and reason for each finding number.
- For a clear fix inside Files: fix it.
- For an upstream cause or a doubtful quick fix: rewrite the brief.
- For unclear intent, a design change or a rule change: ask the director.
- For a pre-existing issue: list it under Noticed for later. Resolve issues this task caused before approval.
- For a finding against a director decision: tell the director `dropped: against decision <id>`.
- After fixes: have the reviewer recheck the findings on the new commit.

## review.restart

- After two failed rounds on the same issue: stop fixes and hold the task. Count failed rounds only.
- Return to the live reference or ask the director if it leaves intent unclear. Record the cause and what to keep. Rewrite the brief before restarting. Get approval first if the rewrite changes design.

## team.merge

- Before seeking approval: run `python3 <skill>/scripts/team.py rehearse <id> -- <check command>` against latest main in a throwaway worktree. Never check out or move the builder's branch.
- After the director approves: mark the row approved with the date. Merge one at a time with `python3 <skill>/scripts/team.py merge <id>`. Mark merged with the commit. The script merges the review if present, moves `approved` and deletes the task and review branches.
- If the script cannot run: use `team.py steps` or its `STEPS` text. Keep `approved` at the last approved merge. Restore from it with the director if main breaks.
- Close the job after every live task reaches an agreed outcome.

## team.status

- Check real threads, reports and worktrees before changing status or reporting it. Use `python3 <skill>/scripts/team.py status` for Git refs and hashes. Distinguish a missing report from a failed run.
- A quiet worker is not a dead one. Record the missing status and ask the director to wake it. Reassign only if the director says to and you have checked for unpushed work.
- Use report-ins and session events. Start no watchers or polling loops.
- When the manager thread grows long: write a [HANDOFF.md](templates/HANDOFF.md) and start a fresh manager thread. If the director must open it: give them the handoff. Update the manager contact on the board before dispatching work.
- If the manager stops: finish the current run, report in and wait. The manager, or the named stop contact if the manager cannot send, gives the director one pause line from [MESSAGES.md](templates/MESSAGES.md).
- Update and push your handoff at the end of each workday. Keep `worker-<name>` branches.

## decide.escalate

- If blocked or facing an irreversible or outward-facing action: stop and ask. Pushing your own branch stays within the team workflow. Use the authorized scope for other pushes and sends.
- Workers ask the manager. The manager asks the director using [MESSAGES.md](templates/MESSAGES.md). Record small calls in Rulings in the report.
- For routine lookups and mechanical checks: choose a cheaper available model at low effort. For routine coding: start at medium effort. Raise effort or use a stronger model for hard work.
