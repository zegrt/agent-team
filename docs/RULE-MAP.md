# Rule map

Source lines in the first table refer to `44d472e`. Each row groups equivalent instructions and names their new home or the reason for cutting them. The [design notes](DESIGN.md) hold the background.

| ID | Previous rule | Source lines | Current home or cut | Change |
|---|---|---|---|---|
| K01 | Name the skill `agent-team`. Use it for a director-led team in separate sessions and when a board names it. | SKILL.md:2-3 | [SKILL.md](../SKILL.md) | Solo is now the default. The mode gate decides when to load team rules. |
| K02 | One director, one manager, builders and reviewers in separate sessions, one team per board. | SKILL.md:8 | [`team.start`](../team/RULES.md#teamstart) |  |
| K03 | The board is the record. Messages only point to it. | SKILL.md:8-9; templates/MESSAGES.md:3-4 | [`team.board`](../team/RULES.md#teamboard), [`decide.escalate`](../team/RULES.md#decideescalate), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| K04 | Read the relevant card or form when you reach its step. `<skill>` means this skill's folder. | SKILL.md:9-10,108-109; RULES.md:3-5 | [SKILL.md](../SKILL.md), [`team.start`](../team/RULES.md#teamstart) |  |
| K05 | Pull the skill with `git pull --ff-only`, then pull the project. If unable, tell the manager and carry on. | SKILL.md:14-15 | [`team.start`](../team/RULES.md#teamstart) | Pull within existing authorization. Check the folder first. |
| K06 | Read the board, your handoff if any, and the director's profile if named. Use `git show` for the handoff. | SKILL.md:16-17; templates/HANDOFF.md:3-4 | [`team.start`](../team/RULES.md#teamstart) |  |
| K07 | After a summary or resume, start fresh, reread the skill and trust the board and `git log` over memory. | SKILL.md:21-22; RULES.md:11 | [`team.start`](../team/RULES.md#teamstart) | Recover from live state. A long manager thread transfers to a fresh thread. |
| K08 | Precedence is a live instruction from the director, the board, the director's profile, then the skill. | SKILL.md:24 | [`team.spec`](../team/RULES.md#teamspec) |  |
| K09 | The manager records live instructions on the board straight away as decisions. | SKILL.md:24-25; templates/BOARD.md:44-45 | [`team.board`](../team/RULES.md#teamboard) | Board links to the decision. The decision lives in DECISIONS.md. |
| K10 | Don't follow a live instruction that breaks a rule yet. Put it on the board as `pending: breaks <rule>, asked director`. | SKILL.md:25-27; templates/BOARD.md:44-45 | [`team.spec`](../team/RULES.md#teamspec) |  |
| K11 | Explain which rule the instruction breaks and why it exists, recommend and act on the director's answer. | SKILL.md:27-28 | [`team.spec`](../team/RULES.md#teamspec) | Give the concrete effect and recommendation. |
| K12 | Nobody acts on a pending line. | SKILL.md:28 | [`team.spec`](../team/RULES.md#teamspec) |  |
| K13 | Judge size by gaps in intent, irreversibility or outward visibility, and how much the work touches. | SKILL.md:32-34 | [`task.size`](../team/RULES.md#tasksize) |  |
| K14 | State each size in plain words on the task row. The director can overrule it. | SKILL.md:32; RULES.md:21-22; templates/BRIEF.md:8; templates/BOARD.md:49 | [`task.size`](../team/RULES.md#tasksize) |  |
| K15 | If work grows, stop, say so and step up a size through `task.change`. | SKILL.md:32-33; RULES.md:22,38 | [`task.size`](../team/RULES.md#tasksize), [`task.change`](../team/RULES.md#taskchange) |  |
| K16 | Small pointers, typos and board edits are done by the manager, who says so. No brief or independent review. Keep any board approval requirement. | SKILL.md:36-37; RULES.md:117-118 | [`task.size`](../team/RULES.md#tasksize), [`team.merge`](../team/RULES.md#teammerge) |  |
| K17 | Content needs a brief, a builder, one independent review and the director's approval. | SKILL.md:38 | [`task.size`](../team/RULES.md#tasksize), [`team.merge`](../team/RULES.md#teammerge), [`review.risk`](../team/RULES.md#reviewrisk) | Change: assign review for a named, testable risk. |
| K18 | Design needs a written plan first. Approval comes before assignment, queueing or starting. Then treat it as Content. | SKILL.md:39-40 | [`task.size`](../team/RULES.md#tasksize) |  |
| K19 | Only the manager commits to main. Push only your own branches as the board's file table says. | SKILL.md:84-85; templates/BOARD.md:9-14 | [`team.board`](../team/RULES.md#teamboard), [BOARD.md](../team/templates/BOARD.md) |  |
| K20 | Never edit or remove a test or check to make it pass. | SKILL.md:71; templates/BRIEF.md:37 | [SKILL.md](../SKILL.md) |  |
| K21 | Builders and reviewers end every run with `report in: <id>, <status>, <where the report is>` to the manager. | SKILL.md:65-67,85-88; RULES.md:39-40; templates/BRIEF.md:14-16; templates/MESSAGES.md:17,21-22; templates/REVIEW.md:7 | [`build.check`](../team/RULES.md#buildcheck), [`review.risk`](../team/RULES.md#reviewrisk), [BRIEF.md](../team/templates/BRIEF.md), [MESSAGES.md](../team/templates/MESSAGES.md) | The new literal placeholder is <where>. Give the branch, commit and path or a link. |
| K22 | Reports go to the manager, even if the director asks. Tell the director it went to the manager. | SKILL.md:86-87; templates/MESSAGES.md:19-20; templates/REVIEW.md:7-8 | [MESSAGES.md](../team/templates/MESSAGES.md), [`review.risk`](../team/RULES.md#reviewrisk) |  |
| K23 | Send a question to the manager as `report in` with `needs info`, the question, options and recommendation. | SKILL.md:87-88; templates/BRIEF.md:14-16; templates/MESSAGES.md:20-21 | [`build.check`](../team/RULES.md#buildcheck), [`review.risk`](../team/RULES.md#reviewrisk), [BRIEF.md](../team/templates/BRIEF.md), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| K24 | No one reads the worker's own thread. Send messages to their intended recipient. No summary after the final `report in` line. | SKILL.md:87-88; templates/BRIEF.md:14-16; templates/MESSAGES.md:21-22 | [`build.check`](../team/RULES.md#buildcheck), [`review.risk`](../team/RULES.md#reviewrisk), [BRIEF.md](../team/templates/BRIEF.md), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| K25 | Update and push your handoff at the end of each day's work. | SKILL.md:88; templates/HANDOFF.md:5 | [`team.status`](../team/RULES.md#teamstatus) |  |
| K26 | Stop and ask before irreversible or outward-facing work, such as publishing, sending outside the team, or deleting others' work. Pushing your own branch is exempt. | SKILL.md:88-89; RULES.md:75-76 | [SKILL.md](../SKILL.md), [`team.board`](../team/RULES.md#teamboard), [`decide.escalate`](../team/RULES.md#decideescalate) | Apply the safety rules in both modes. The private branch exception applies within the team. |
| W01 | Use your own worktree on the task branch. Never switch branches in a folder someone else works in. | SKILL.md:18-20,68; RULES.md:86-88; templates/BRIEF.md:11 | [`team.worktree`](../team/RULES.md#teamworktree) |  |
| W02 | If your folder is shared and the task has its own branch, make your own worktree and say where it is. Use `-b` for a new branch. Ask the manager if you can't make it. | SKILL.md:19-20,68-69; RULES.md:86-88 | [`team.worktree`](../team/RULES.md#teamworktree) |  |
| W03 | Check folder and branch at startup and before each commit. Stop and ask if dirty or on an unexplained branch. | SKILL.md:18-20,70; RULES.md:88-89; templates/BOARD.md:51; templates/BRIEF.md:11 | [`team.worktree`](../team/RULES.md#teamworktree), [`team.start`](../team/RULES.md#teamstart) |  |
| W04 | Check for unpushed work before removing a worktree. | RULES.md:89 | [`team.worktree`](../team/RULES.md#teamworktree) |  |
| O01 | Only the manager edits the board. | SKILL.md:44; RULES.md:30; templates/BOARD.md:5,55 | [`team.board`](../team/RULES.md#teamboard) |  |
| O02 | Write every task, decision and correction on the board first. Commit and push before messaging. Check the correction is in the board diff. | SKILL.md:45-46; RULES.md:9-11,17 | [`team.board`](../team/RULES.md#teamboard) |  |
| O03 | Use the message forms for every inter-agent message or report or question to the director. Never put the correction or new requirement in a worker message. | SKILL.md:45-46; RULES.md:9-11; templates/MESSAGES.md:3-4,12-13 | [`team.board`](../team/RULES.md#teamboard), [`decide.escalate`](../team/RULES.md#decideescalate), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| C01 | Each task has one state. Only the manager moves it. | RULES.md:30; templates/BOARD.md:54-55 | [`task.change`](../team/RULES.md#taskchange) |  |
| C02 | Main sequence is open, building with builder named, built after report in, in review, reviewed, approved with date, merged. | RULES.md:31; templates/BOARD.md:54 | [`task.change`](../team/RULES.md#taskchange) |  |
| C03 | Other states are held by the manager, blocked or needs info from the builder, and pending for the director. | RULES.md:32; templates/BOARD.md:54-55 | [`task.change`](../team/RULES.md#taskchange) |  |
| C04 | Files listed by an open task belong to it. Change those files through the task or after it. | SKILL.md:47-49; RULES.md:33,38-39 | [`task.change`](../team/RULES.md#taskchange) |  |
| C05 | A building brief is frozen. The builder routes changes from anyone, including the director, to the manager and keeps building to the current brief until held. | SKILL.md:47; RULES.md:33-36 | [`task.change`](../team/RULES.md#taskchange) |  |
| C06 | If a change makes current work wrong, hold it on the board first, send the hold, rewrite the brief and start a new builder run from it. | SKILL.md:47-48; RULES.md:35-36 | [`task.change`](../team/RULES.md#taskchange), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| C07 | If a change only adds, finish as briefed. The addition is a new task or waits for the report. | SKILL.md:47-48; RULES.md:37 | [`task.change`](../team/RULES.md#taskchange) |  |
| C08 | Apply the same change routes after two failed reviews or when work outgrows its size. | RULES.md:38-39 | [`task.size`](../team/RULES.md#tasksize), [`review.restart`](../team/RULES.md#reviewrestart) | The restart includes a return to the reference or a question to the director. |
| C09 | A hold is the only message a building task gets. Send `board updated, pull: task <id>` only between tasks or with a restart. | SKILL.md:48; RULES.md:39-40; templates/MESSAGES.md:10-12 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| C10 | The hold message reads `hold: task <id>, see board`. Urgency may be added to a worker message. | RULES.md:35; templates/MESSAGES.md:11-13 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| B01 | A worker has one task per run. A builder does only the brief and puts other observations under Noticed. | SKILL.md:64-66; RULES.md:39-40; templates/BRIEF.md:37 | [`task.change`](../team/RULES.md#taskchange), [`build.check`](../team/RULES.md#buildcheck) |  |
| B02 | Decline a second task plainly, say how it can still get done and wait for the manager to put it on the board for you. | SKILL.md:66-67 | [`task.change`](../team/RULES.md#taskchange) |  |
| B03 | Always run the brief's checks and look at the results before reporting. Done needs check output in the report. | SKILL.md:72,75-76; templates/REPORT.md:11-13 | [`build.check`](../team/RULES.md#buildcheck), [REPORT.md](../team/templates/REPORT.md) |  |
| B04 | Self-check is separate from review. A builder never does the independent review, even if asked. | SKILL.md:75-76; templates/BOARD.md:52 | [`build.check`](../team/RULES.md#buildcheck), [`review.risk`](../team/RULES.md#reviewrisk) |  |
| B05 | Write the report with the report form and commit it as `reports/<id>.md` on the task branch. | SKILL.md:72-74; templates/BOARD.md:12; templates/BRIEF.md:40-41; templates/REPORT.md:3 | [`build.check`](../team/RULES.md#buildcheck) |  |
| B06 | Use one of four statuses: done, done with concerns, needs info, blocked. Silence is not a status. | SKILL.md:73-74; templates/REPORT.md:6-7; templates/MESSAGES.md:18 | [`build.check`](../team/RULES.md#buildcheck), [REPORT.md](../team/templates/REPORT.md) |  |
| B07 | Push the report, then send `report in` and end the run. | SKILL.md:65-67; templates/MESSAGES.md:17 | [`build.check`](../team/RULES.md#buildcheck), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| B08 | The brief's Manager line tells you where to send your messages. | templates/BRIEF.md:13-18; templates/MESSAGES.md:22 | [BRIEF.md](../team/templates/BRIEF.md), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| V01 | Start clean. Read the brief and the work. Skip the builder's report. | SKILL.md:78; templates/REVIEW.md:4-5; templates/REPORT.md:3 | [`review.risk`](../team/RULES.md#reviewrisk) |  |
| V02 | Use `reviews/<id>.md` and the review form. Commit only that review to `review-<id>` made from main. Never commit to the task branch or main. | SKILL.md:79-82; templates/BOARD.md:13; templates/REVIEW.md:3,5 | [`review.risk`](../team/RULES.md#reviewrisk), [BOARD.md](../team/templates/BOARD.md) |  |
| V03 | Use the task diff without reports and a detached worktree for checks. | SKILL.md:80-81 | [`review.risk`](../team/RULES.md#reviewrisk) |  |
| V04 | Ask what is missing. Find everything in one go. Change nothing else. | SKILL.md:81-82; templates/REVIEW.md:5-6,15 | [`review.risk`](../team/RULES.md#reviewrisk), [REVIEW.md](../team/templates/REVIEW.md) | Change: cover what is missing or unnecessary for the named risk. Keep other files untouched. |
| V05 | Push `review-<id>`, then send the manager `report in`. | templates/REVIEW.md:7; SKILL.md:85-88 | [`review.risk`](../team/RULES.md#reviewrisk), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| V06 | The review goes to the manager, never to the director, even if the director asks for it. | templates/REVIEW.md:7-8 | [`review.risk`](../team/RULES.md#reviewrisk) |  |
| A01 | Before any fix, route every finding number exactly once and give a reason. | SKILL.md:54; RULES.md:50,62 | [`review.assess`](../team/RULES.md#reviewassess) |  |
| A02 | Fix small, clear findings within the task's Files. | RULES.md:51 | [`review.assess`](../team/RULES.md#reviewassess) |  |
| A03 | Rewrite the brief for an upstream cause. When torn between a fix and a rewrite, rewrite. | RULES.md:52 | [`review.assess`](../team/RULES.md#reviewassess) |  |
| A04 | Ask the director if intent is unclear, structure or design changes, or team rules change. | RULES.md:53 | [`review.assess`](../team/RULES.md#reviewassess) |  |
| A05 | Put pre-existing findings in Noticed for later. Never put off a problem this task caused. | RULES.md:54,56 | [`review.assess`](../team/RULES.md#reviewassess) |  |
| A06 | Drop findings against the director's decisions, list them for the director as `dropped: against decision X`, and never drop silently. | RULES.md:56-57 | [`review.assess`](../team/RULES.md#reviewassess) |  |
| A07 | The reviewer re-checks after fixes. | SKILL.md:54 | [`review.assess`](../team/RULES.md#reviewassess), [REVIEW.md](../team/templates/REVIEW.md) |  |
| R01 | After two failed rounds on the same thing, stop fixing. Passing rounds don't count. | SKILL.md:55; RULES.md:66; templates/BOARD.md:53 | [`review.restart`](../team/RULES.md#reviewrestart) |  |
| R02 | Rewrite the brief, record what to keep and restart via `task.change`. If the rewrite changes design, ask the director first. | SKILL.md:55; RULES.md:66-67,75 | [`review.restart`](../team/RULES.md#reviewrestart) | Reopen the reference first. Ask if it leaves behavior unspecified. |
| E01 | Stop and ask when blocked. Workers ask the manager. The manager asks the director with the question form. | RULES.md:75-77; SKILL.md:60-61 | [`decide.escalate`](../team/RULES.md#decideescalate), [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| E02 | Ask one plain question with recommendation and reason, what happens on each answer, and what was checked. | RULES.md:77; templates/MESSAGES.md:37-42 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| E03 | Status to the director uses the form: facts with commit hashes and exact scope, never a loose summary. | SKILL.md:60-61; RULES.md:77-78; templates/MESSAGES.md:28-33 | [MESSAGES.md](../team/templates/MESSAGES.md), [`team.status`](../team/RULES.md#teamstatus) |  |
| E04 | Anything smaller is a Ruling in the report. | RULES.md:78; templates/MESSAGES.md:42 | [`decide.escalate`](../team/RULES.md#decideescalate), [REPORT.md](../team/templates/REPORT.md) |  |
| U01 | A quiet worker is not a dead one. If no status, ask the director to wake it. | SKILL.md:62; RULES.md:97 | [`team.status`](../team/RULES.md#teamstatus) |  |
| U02 | Don't reassign or let another worker pick it up unless the director says to. First check for unpushed work on the quiet worker's branch. | SKILL.md:62; RULES.md:97-98,102 | [`team.status`](../team/RULES.md#teamstatus) |  |
| L01 | A correction from live work goes ahead of improvement work. | SKILL.md:50; RULES.md:106 | [`task.size`](../team/RULES.md#tasksize) |  |
| M01 | The manager sizes, splits, briefs, assesses and merges. Merge one task at a time after the director approves. | SKILL.md:57-59; RULES.md:113 | [`task.size`](../team/RULES.md#tasksize), [`review.assess`](../team/RULES.md#reviewassess), [`team.merge`](../team/RULES.md#teammerge) |  |
| M02 | Brief Content and Design tasks with the brief form as `briefs/<id>.md`. Link it from the task row. | SKILL.md:52; templates/BRIEF.md:3 | [`task.size`](../team/RULES.md#tasksize) |  |
| M03 | Assign nothing whose Files overlap an open task. | SKILL.md:52-53; templates/BOARD.md:50 | [`task.change`](../team/RULES.md#taskchange) |  |
| M04 | Builder and reviewer must differ. | SKILL.md:53; templates/BOARD.md:52; templates/REVIEW.md:3 | [`review.risk`](../team/RULES.md#reviewrisk) |  |
| M05 | Before approval, rehearse by merging latest main into a throwaway copy and rerunning checks. | SKILL.md:56-57; RULES.md:114-115 | [`team.merge`](../team/RULES.md#teammerge) |  |
| M06 | Merge with `team.py merge <id>` only when the board says approved. Merge task and review, move `approved`, delete those branches, then set the row to merged. | SKILL.md:57-59; RULES.md:113,115-116 | [`team.merge`](../team/RULES.md#teammerge), [team.py](../scripts/team.py) |  |
| M07 | If the script can't run, use `team.py steps` or its `STEPS` text for the manual steps. | SKILL.md:59; RULES.md:116-117 | [`team.merge`](../team/RULES.md#teammerge) |  |
| M08 | The manager never checks out or moves a builder's branch. | RULES.md:117 | [`team.merge`](../team/RULES.md#teammerge) |  |
| M09 | The manager only builds Small tasks and leaves the job open while task rows are open. | RULES.md:117-118; SKILL.md:36 | [`task.size`](../team/RULES.md#tasksize), [`team.merge`](../team/RULES.md#teammerge) |  |
| M10 | Use `team.py status` for each task's state and hash. | SKILL.md:60-61; templates/BOARD.md:56; templates/MESSAGES.md:28 | [`team.status`](../team/RULES.md#teamstatus) |  |
| Z01 | Start with about three active agents. Add one only while the director keeps up with review. | SKILL.md:51; RULES.md:128 | [`task.size`](../team/RULES.md#tasksize) |  |
| F01 | Board-first warning about messages getting work moving. | SKILL.md:97 | Cut: duplicate of O02 |  |
| F02 | Frozen-brief warning about adding requirements mid-run. | SKILL.md:98 | Cut: duplicate of C05–C07 |  |
| F03 | Board-first warning about deferring a cell edit. | SKILL.md:99 | Cut: duplicate of O02 |  |
| F04 | Design approval warning about queueing a restructure. | SKILL.md:100 | Cut: duplicate of K18 |  |
| F05 | Small-task warning about handing off a one-word fix. | SKILL.md:101 | Cut: duplicate of K16 |  |
| F06 | Worktree warning about asking for a worktree assignment. | SKILL.md:102 | Cut: duplicate of W02 |  |
| F07 | Quiet-worker warning about a timed reassignment. | SKILL.md:103 | Cut: duplicate of U01–U02 |  |
| F08 | Pending-rule warning about a live instruction overriding restart. | SKILL.md:104 | Cut: duplicate of K10–K12 |  |
| T01 | The board opens by telling readers to read the skill first. | templates/BOARD.md:1 | [BOARD.md](../team/templates/BOARD.md) |  |
| T02 | Manager writes board, briefs and merged work on main. Builder writes work and report on task branch. Reviewer writes review on its main-based review branch. Worker alone writes its handoff on its worker branch, which is never deleted. | templates/BOARD.md:9-14 | [BOARD.md](../team/templates/BOARD.md), [`team.status`](../team/RULES.md#teamstatus) |  |
| T03 | Manager reads worker files with `git show origin/<branch>:<path>`. | templates/BOARD.md:16-17 | [`team.start`](../team/RULES.md#teamstart) | Use the command for reports, reviews and handoffs stored on another branch. |
| T04 | `approved` marks the last director-approved state. Restore from it if main breaks. Move and push it after each approved merge. | templates/BOARD.md:19-20 | [BOARD.md](../team/templates/BOARD.md), [`team.merge`](../team/RULES.md#teammerge) |  |
| T05 | List roles, identities and locations, and name the director's profile or say none. | templates/BOARD.md:22-30 | [BOARD.md](../team/templates/BOARD.md), [`team.start`](../team/RULES.md#teamstart) |  |
| T06 | Project rules are dated additions or tightenings. Don't copy the skill. | templates/BOARD.md:34 | [BOARD.md](../team/templates/BOARD.md), [`team.board`](../team/RULES.md#teamboard) |  |
| T07 | Record every director correction in their words, dated, against a rule or `new`. Send repeated corrections to the inbox. | templates/BOARD.md:38-40 | [BOARD.md](../team/templates/BOARD.md), [`team.spec`](../team/RULES.md#teamspec), [Inbox guidance](../inbox/README.md) | Link the original. Flag the second occurrence for the inbox and follow its privacy and approval guidance. |
| T08 | Record decisions dated, newest last, with who decided. | templates/BOARD.md:44 | [`team.board`](../team/RULES.md#teamboard) | Cut: newest-last ordering. Keep the dated record, decision maker and scope. |
| T09 | List task Files and branch, roles, number of failed review rounds, state and brief in the task row. Check state against the work. | templates/BOARD.md:49-59 | [BOARD.md](../team/templates/BOARD.md), [`task.change`](../team/RULES.md#taskchange), [`team.status`](../team/RULES.md#teamstatus) |  |
| T10 | Record Noticed items with their source task. Nobody acts until the manager makes it a task. | templates/BOARD.md:63-64 | [`team.board`](../team/RULES.md#teamboard), [BOARD.md](../team/templates/BOARD.md) |  |
| P01 | Keep briefs under about a page. | templates/BRIEF.md:3 | [BRIEF.md](../team/templates/BRIEF.md) |  |
| P02 | Brief has size, board commit, branch and the manager's address. Builder repeats the board commit in the report. | templates/BRIEF.md:8-13; templates/REPORT.md:8 | [BRIEF.md](../team/templates/BRIEF.md), [REPORT.md](../team/templates/REPORT.md) |  |
| P03 | State the objective in one or two lines. | templates/BRIEF.md:21 | [BRIEF.md](../team/templates/BRIEF.md) | Cut: paraphrased objective and line count. The director's exact instruction supplies the objective. |
| P04 | Name the output and its form. | templates/BRIEF.md:24 | [BRIEF.md](../team/templates/BRIEF.md) |  |
| P05 | Name the tools and sources to use and read. | templates/BRIEF.md:27 | [BRIEF.md](../team/templates/BRIEF.md) |  |
| P06 | Work only in listed Files. In the report, name anything changed outside the list and explain why. | templates/BRIEF.md:30-31; templates/REPORT.md:10 | [`build.check`](../team/RULES.md#buildcheck), [REPORT.md](../team/templates/REPORT.md) |  |
| P07 | Agree on Done when checks before starting. | templates/BRIEF.md:34 | [BRIEF.md](../team/templates/BRIEF.md), [`build.check`](../team/RULES.md#buildcheck) |  |
| H01 | Handoff is `workers/<worker>.md`, only on `worker-<worker>`. | templates/HANDOFF.md:3 | [BOARD.md](../team/templates/BOARD.md) |  |
| H02 | Record updated date and commit. Finished work is facts with commits. | templates/HANDOFF.md:8-11 | [HANDOFF.md](../team/templates/HANDOFF.md) |  |
| H03 | Record half-done work with branch, worktree path and what's left, plus what is next. | templates/HANDOFF.md:13-16 | [HANDOFF.md](../team/templates/HANDOFF.md) |  |
| H04 | For resuming, record session or thread ID, machine and what the board doesn't say. | templates/HANDOFF.md:18-20 | [HANDOFF.md](../team/templates/HANDOFF.md) |  |
| G01 | Report pointers name branch, hash and file, or link for work outside git. The line never carries the report. Manager assesses first. | templates/MESSAGES.md:18-20 | [MESSAGES.md](../team/templates/MESSAGES.md), [`review.assess`](../team/RULES.md#reviewassess) | Report-in points to the report. Assessment starts with the manager. |
| G02 | If you can't message the manager, end with the full addressed line for the director to pass on. | templates/MESSAGES.md:22-23 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| G03 | Give one status line per open task, with task, state, branch, hash, exact scope and what's next or what it waits on. | templates/MESSAGES.md:28-30 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| G04 | Add only decisions the director must make, using the question form for each. | templates/MESSAGES.md:32 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| G05 | Nothing is called done, ready or live unless the board says merged. | templates/MESSAGES.md:33 | [MESSAGES.md](../team/templates/MESSAGES.md) |  |
| Y01 | Report records board commit, work commit, files changed and check output. | templates/REPORT.md:8-13 | [REPORT.md](../team/templates/REPORT.md) |  |
| Y02 | Rulings say what, why and the cost if wrong, or `none`. | templates/REPORT.md:14 | [REPORT.md](../team/templates/REPORT.md) |  |
| Y03 | Put out-of-task items in Noticed, or `none`. | templates/REPORT.md:15 | [REPORT.md](../team/templates/REPORT.md) |  |
| Y04 | Say whether the branch is pushed, folder clean, and nothing unpushed. | templates/REPORT.md:16 | [REPORT.md](../team/templates/REPORT.md) |  |
| J01 | Name the brief and reviewed commit. | templates/REVIEW.md:10 | [REVIEW.md](../team/templates/REVIEW.md) |  |
| J02 | Review the approach and ask if anything is unnecessary. | templates/REVIEW.md:12-13 | [REVIEW.md](../team/templates/REVIEW.md) | Change: assess the approach within the named risk. |
| J03 | Judge findings against the brief and director's decisions, not style. | templates/REVIEW.md:19 | [REVIEW.md](../team/templates/REVIEW.md) | Judge against the brief and director decisions, within the risk, which excludes unrelated style changes. |
| J04 | Rank findings, group by cause, and give each a small, medium or large fix size. | templates/REVIEW.md:19-24 | [REVIEW.md](../team/templates/REVIEW.md) |  |
| J05 | For written rules, check clarity, quantified adjectives, consistency and complete exceptions. | templates/REVIEW.md:20-21 | [REVIEW.md](../team/templates/REVIEW.md) |  |
| J06 | Re-review only prior findings. Mark each fixed or not fixed with evidence. Trying doesn't count. Add nothing new. | templates/REVIEW.md:28-32 | [REVIEW.md](../team/templates/REVIEW.md) |  |
| X01 | Card introductions, Why, Basis and role Scope labels | RULES.md:3-5,12-16,23-26,41-46,58-61,68-71,79-82,90-93,99-101,107-109,119-124,129-132 | Historical rationale in DESIGN.md. Role scope is part of the instruction. | |
| X02 | Template rationale, dated attributions and citations | templates/BOARD.md:5,16-20,38-40,49-56,63-64; templates/BRIEF.md:3-12,14-18,26-41; templates/HANDOFF.md:3-6,11,19-20; templates/MESSAGES.md:3-6,23-24; templates/REPORT.md:3-16; templates/REVIEW.md:3-8,10,15-21,29-30 | Historical rationale in DESIGN.md. Operative portions are mapped above. | |
| X03 | Red flags heading, introduction and examples | SKILL.md:91-104 | Cut: duplicate instructions. See F01–F08. | |
| X04 | The manager pushes main and advances the approved branch after landing. | scripts/team.py:29-31 | [`team.board`](../team/RULES.md#teamboard), [`team.merge`](../team/RULES.md#teammerge), [team.py](../scripts/team.py) | Keep this exception to assigned-branch pushes. |

## Added rules and checks

| ID | Rule or check | Current home |
|---|---|---|
| N01 | Open the exact reference. In solo mode, show one piece in the real file before repeating it. | [SKILL.md](../SKILL.md) |
| N02 | Record numerical timing and measure on the actual target. Give the director full-speed playback. | [SKILL.md](../SKILL.md) |
| N03 | Keep lasting decisions beside the work and archive superseded entries. Use a fresh thread and three-line handoff for unrelated work or repeated misses. | [SKILL.md](../SKILL.md) |
| N04 | Invite a second agent for one testable question only when its answer changes the next move. | [SKILL.md](../SKILL.md) |
| N05 | Default to solo. Use team mode for an assigned role, a director order or an independent, testable initial split. Wait for a yes before expanding ongoing solo work into team mode, then carry decisions and handoff over. | [SKILL.md](../SKILL.md) |
| N06 | Link the original direction and reference. Keep directions scoped. Record unapproved additions as suggestions and leave them unbuilt. | [SKILL.md](../SKILL.md), [`team.spec`](../team/RULES.md#teamspec), [BRIEF.md](../team/templates/BRIEF.md), [REPORT.md](../team/templates/REPORT.md) |
| N07 | Resolve pending instructions before dispatch and hold assignments that become coupled. | [`team.spec`](../team/RULES.md#teamspec), [`task.change`](../team/RULES.md#taskchange) |
| N08 | Replay a linked live bug and record version and evidence before building. | [`team.spec`](../team/RULES.md#teamspec), [REPORT.md](../team/templates/REPORT.md) |
| N09 | Claim done only after all checks pass. Withhold approval without passing checks and target evidence. | [`build.check`](../team/RULES.md#buildcheck), [`team.merge`](../team/RULES.md#teammerge), [REPORT.md](../team/templates/REPORT.md) |
| N10 | Land Small tasks directly on main with applicable approval. Reserve the task merge helper for separate branches. | [`team.merge`](../team/RULES.md#teammerge), [team.py](../scripts/team.py) |
| N11 | Keep only live rows and current corrections. Name both archives and print board size, decisions size and remaining merged rows. | [`team.board`](../team/RULES.md#teamboard), [BOARD.md](../team/templates/BOARD.md), [`team.status`](../team/RULES.md#teamstatus), [team.py](../scripts/team.py) |
| N12 | Verify status using live threads, reports and worktrees. Use events and report-ins and start no watchers. | [`team.status`](../team/RULES.md#teamstatus) |
| N13 | Preserve cited evidence and needed commits before worktree removal. Retain rehearsal worktrees with changes. | [`team.worktree`](../team/RULES.md#teamworktree), [`team.merge`](../team/RULES.md#teammerge), [team.py](../scripts/team.py) |
| N14 | Review a named testable risk. File reproduced failures and report unverified attempts as such. | [`review.risk`](../team/RULES.md#reviewrisk), [REVIEW.md](../team/templates/REVIEW.md) |
| N15 | Require pinned task and review hashes and verify the review covers the tested task. Refuse protected branch cleanup and use deletion leases. | [`team.merge`](../team/RULES.md#teammerge), [BOARD.md](../team/templates/BOARD.md), [team.py](../scripts/team.py) |
| N16 | Save the manager handoff on main and transfer dispatch authority via the board. If the manager stops, workers finish and wait. The stop contact sends one pause line if needed. | [`team.status`](../team/RULES.md#teamstatus), [HANDOFF.md](../team/templates/HANDOFF.md), [BOARD.md](../team/templates/BOARD.md) |
| N17 | Set cheaper model and effort for routine work and raise them when checks keep failing or the cause remains unknown. | [`decide.escalate`](../team/RULES.md#decideescalate), [BRIEF.md](../team/templates/BRIEF.md) |
| N18 | Give both test arms the same prompt and board header. Load either skill layout and mask relative layout paths before grading. | [run.sh](../tests/run.sh), [grade.py](../tests/grade.py) |
