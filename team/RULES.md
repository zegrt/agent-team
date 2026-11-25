# Team mode

## team.start

- Use one director, one manager and one `WORKBOARD.md`. Give each worker a separate session.
- Read your role, task, branch, handoff and any named director profile.
- Worker, before editing: read your board row and `briefs/<id>.md`. State the task id, branch, Files and agreed checks. If any is missing: `report in: <id>, needs info, <question>`. For files on another branch: use `git show origin/<branch>:<path>`.
- Check branch and local changes before `git pull --ff-only` in the skill folder and then your project worktree. If unable: tell the manager and use the available version.
- After a summary or resume: reread `SKILL.md` and these rules. Recover from the board, handoff and `git log`. Verify against the live work.
- Read each linked form at its step. `<skill>` is the skill folder.

## team.spec

- Follow live director instructions, then board records, the director's profile and this skill. Link the exact words and reference. If missing a link: save the original in a shared record and link it. Leave paraphrases out.
- If a director instruction conflicts with a rule: workers tell the manager. The manager records `pending: breaks <rule>, asked director` and tells the director the rule, effect and recommendation.
- A decision marked pending is not followed. Nobody acts on a pending line. The manager resolves it before dispatch.
- Before building: open the linked reference. For a live bug: replay the repro on the named version and target. Record the result. If blocked: ask for the missing view or steps.

## team.board

- Use [BOARD.md](templates/BOARD.md). Only the manager edits it or commits to main. Push only assigned branches except the manager's approved main and `approved` pushes. Pushing a private task branch within the team needs no separate approval.
- Record tasks and corrections before messaging. Record decisions as they arrive in `DECISIONS.md`, about 30 lines, with date, source, who decided and scope. Link decisions and corrections on the board.
- Before messaging workers: commit and push the record. Check correction links in the diff.
- Keep live rows and current corrections. Archive closed rows with outcome and commit. Archive superseded decisions. Flag the second occurrence of the same correction for the [inbox](../inbox/README.md).
- Link Noticed items to their source tasks. Act on them only after assignment and any required approval.

## task.size

- Size each row by intent gaps, reach and irreversible or outward-facing actions. Follow the director's sizing decision.
- The manager builds only Small tasks, such as typos, pointers and board edits. Use the direct landing path in `team.merge`.
- Content: on main, link [BRIEF.md](templates/BRIEF.md) as `briefs/<id>.md` from the row. Assign a builder. Apply `review.risk`.
- Design: get a written plan approved before queueing, assigning or building. Then use the Content steps.
- If work grows: stop, record and resize through `task.change`.
- Prioritize live corrections. Start with about three active agents. Add one only if no task is waiting for the director's approval.

## task.change

- The manager gives each task one state. Move it through open, building (builder named), built (report received), in review, reviewed, approved (date) and merged. Skip unassigned review. Use held for a hold, blocked or needs info when reported, and pending for a director decision.
- Assign disjoint tasks with testable handoffs. Reserve Files for the builder until closure. If tasks become coupled: hold them and replan.
- A building brief is frozen. Route changes from anyone to the manager. Follow the current brief until held.
- If a change makes current work wrong: record and push the hold, send it, rewrite the brief and start a fresh run.
- If a change only adds work: finish as briefed. Queue the approved addition separately or wait for the report.
- Take one task per worker run. Decline a second, route it through the manager and wait for assignment.

## team.worktree

- Use a separate worktree. From a shared folder: use `git worktree add ../<project>-<id> -b <branch>` for a new branch or omit `-b` for an existing branch. Tell the manager its path or if creation fails.
- Never switch branches in a shared folder. At startup and before each commit: check branch and changes. If unexpected: stop and ask.
- Before removing finished worktrees: preserve cited evidence, check local changes and verify needed commits on a retained ref.
- When a task merges or closes: remove your worktree for it with `git worktree remove <path>`, never `--force`.

## build.check

- Keep to the brief. Put out-of-scope discoveries under Noticed.
- Run agreed checks and inspect the real editor, phone or app the director will use. Record version, steps, outputs and measured timing. If the target is unavailable: report the missing check and request it.
- Use `done` only if every agreed check passed. Silence is not a status.
- A builder never reviews their own work, even if asked. A self-check counts for nothing as review.
- Commit [REPORT.md](templates/REPORT.md) at `reports/<id>.md` on the task branch and push it.
- End the run with `report in: <id>, <status>, <where>` to the manager. For questions use `report in: <id>, needs info, <question>`. It is your last message. No one reads your thread. Write no summary. See [MESSAGES.md](templates/MESSAGES.md).

## review.risk

- Assign a separate reviewer for a named risk and test. Keep agreed reviews. Route waivers through `team.spec`.
- Read the brief and exact change, skipping the builder report. Use `git diff origin/main...<commit> -- . ':(exclude)reports/'` and a detached worktree at the named commit.
- Reproduce each failure before filing it. If it does not reproduce: report the attempt and limits.
- Commit only [REVIEW.md](templates/REVIEW.md) at `reviews/<id>.md` on `review-<id>` from main. Push it.
- The review goes to the manager, never to the director, even if the director asks for it.
- End the run with `report in: <id>, <status>, <where>` to the manager. For questions use `report in: <id>, needs info, <question>`. It is your last message. No one reads your thread. Write no summary. See [MESSAGES.md](templates/MESSAGES.md).

## review.assess

- The manager assesses first. Before fixing: record one route and reason per finding.
- Fix small, clear issues inside Files. Re-brief upstream causes or doubtful fixes.
- Ask the director about unclear intent, design or rule changes.
- List pre-existing issues under Noticed. Resolve issues this task caused before approval.
- For findings against a director decision: record and tell the director `dropped: against decision <id>`.
- Drop nothing silently. The director's summary lists every finding with its route, one line each.
- Have the reviewer recheck fixes on the new commit in a detached worktree, then commit the update to `reviews/<id>.md` on the existing `review-<id>` branch with `Reviewed commit:` set to the new full task hash.

## review.restart

- After two failed rounds on the same issue: hold and stop fixes. Reopen the live reference. If it leaves behavior unspecified: ask the director.
- Record the cause and what to keep. Rewrite the brief before restarting. Get approval for design changes.

## team.merge

- Small: check on the target in the manager's main worktree. Get any required approval. Commit directly to main, push with permission and record the landed hash. Skip brief, review and task merge.
- Content and Design: pin the task tip after the report. Rehearse with `python3 <skill>/scripts/team.py rehearse <id> -- <check command>`. Preserve cited evidence before cleanup. Never check out or move the builder's branch.
- Withhold approval without target evidence and passing checks. Match any review to the tested commit. Record the approved task and review hashes with the date.
- Merge one approved task at a time with `python3 <skill>/scripts/team.py merge <id>`. Record the merge hash. Use `team.py steps` or its `STEPS` text if needed.
- Move `approved` on approved landings. If main breaks: restore from `approved` with the director. Close the job after all live tasks reach agreed outcomes.

## team.status

- Verify status against threads, reports and worktrees. Use `python3 <skill>/scripts/team.py status` for hashes and board size.
- A quiet worker is not a dead one. Record missing status and ask the director to wake it. Reassign only with their say and after checking unpushed work.
- Use report-ins and session events. Start no watchers or polling loops.
- When the tool warns of a context limit or compacts the manager thread: commit [HANDOFF.md](templates/HANDOFF.md) as `handoffs/manager.md` on main. Start a fresh thread or ask the director to open one if the tool cannot. Publish the new manager contact before the successor dispatches. The previous manager stops dispatching.
- If the manager stops: workers finish the run, report in and wait. The manager or named stop contact sends one pause line.
- Push worker handoffs each workday. Keep `worker-<name>` branches.

## decide.escalate

- If blocked: stop and ask. Workers ask the manager. The manager asks the director. Log small calls in Rulings.
- Use [MESSAGES.md](templates/MESSAGES.md) for all team messages and director reports or questions.
- Choose a cheaper model for routine work. Start at low effort for lookups and checks, medium for coding. Escalate if a check keeps failing or the cause remains unknown.
