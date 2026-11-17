# Rules: the judgment cards

Each card: **Rule**, **Why**, **Basis** (the director's dated correction first, then published support), **Scope**;
**Unless** and **Check** only where they add something. The checkable rules are fields in `templates/`, each with its
own why and basis. Sources are listed in full at the end of `PLAN.md`.

## board.one-source

**Rule:** Every task, decision and correction is written on the board first. A message only says "board updated,
pull", plus any urgency (a deadline, a hold). The correction itself is never in the message. After a summary, trust the board and `git log` over your memory.
**Why:** Messages between agents get lost or half-read, and a summary is not the record.
**Basis:** Cyril, 9 Nov 2026 ("y'all are miscommunicating a lot"). Anthropic, long-running harnesses (a progress file
plus git). Superpowers (losing place after a summary was "the single most expensive failure observed"). BMAD #2539
(team members miss messages not addressed to them).
**Scope:** manager; everyone reading.
**Check:** the correction is in the board's diff before the message is sent.

## task.size

**Rule:** State each task's size in plain words: Small, Content or Design (see SKILL.md). The director can overrule
it. If the work grows, stop, say so and step up a size.
**Why:** Full process on a typo wastes the director's time; none on a design wastes everyone's.
**Basis:** Cyril, 17 Nov 2026. Superpowers brainstorming ("pick a size and say it in plain words"). BMAD build-a-change
(route by intent gaps, irreversibility and footprint).
**Scope:** manager.

## review.assess

**Rule:** Before any fix, give every finding a route and a reason:
- **fix:** small and clear, inside the task's Files;
- **rewrite the brief:** the cause is upstream (when torn between this and fix, choose this);
- **ask the director:** the director's intent is unclear, it changes structure or design, or it changes the team's rules;
- **later:** it was there before this task (goes to the board's Noticed list).

A problem this task caused is never put off. A finding against the director's decisions is dropped, but listed for
the director as "dropped: against decision X". Nothing is dropped silently.
**Why:** Fixing symptoms one by one grows the work, and a silent drop hides a real problem.
**Basis:** Cyril, 9 Nov 2026 ("plan and asses after reviews, not immidiatly push to fixes"). BMAD review triage
("recorded reason, never silently"; "a problem this change caused is never deferred"). Cognition, 2026.
**Scope:** manager.
**Check:** every finding number appears once in the routing, with a reason.

## review.restart

**Rule:** After two failed review rounds on the same thing, stop fixing. Rewrite the brief, writing down what to keep.
If the rewrite changes the design, it goes to the director first (`decide.escalate`).
**Why:** By the third round the cause is upstream, and builder and reviewer otherwise loop.
**Basis:** Cyril, 9 Nov 2026 (the kit was rebuilt smaller after two review rounds). BMAD ("a third pass ... something
is wrong upstream"). Claude Code best practices.
**Scope:** manager.

## decide.escalate

**Rule:** Stop and ask when blocked, when a rewrite after two failed rounds changes the design, or before anything
irreversible or outward-facing. Workers ask the manager; the manager asks the director, as one plain question with a
recommendation, already checked. Anything smaller is a Ruling in the report, not a question.
**Why:** The director's attention is the scarce part; pushing on past these points wastes work or does harm.
**Basis:** Cyril, 17 Nov 2026 (the form). Anthropic, "Building effective agents" ("pause for human feedback at
checkpoints or when encountering blockers"). OpenAI, practical guide (failure thresholds, high-risk actions).
**Scope:** everyone.

## team.worktree

**Rule:** Never switch branches in a folder someone else works in. Branch work goes in its own worktree
(`git worktree add ../<project>-<id> -b <branch>`, or without `-b` if the branch exists). At session start and before every commit, check the folder is
clean and on the task's branch; if not, stop and ask. Before removing a worktree, check nothing is unpushed.
**Why:** Another agent's next commit lands on your branch; the check catches it before it does.
**Basis:** Cyril, 17 Nov 2026 (Codex switched the shared folder; the manager's commit landed on `task-48`). BMAD
("Is the working tree clean? Does the current branch make sense"). Gas Town Witness (unpushed work before removal).
**Scope:** everyone.

## team.unreachable

**Rule:** A quiet worker is not a dead one. If it hasn't reported a status, ask the director to wake it. Don't
reassign its task, and don't let another worker pick it up.
**Why:** Reassigning splits ownership of half-done work, often unpushed.
**Basis:** Cyril, 17 Nov 2026. Gas Town design doc (false alarms on stuck workers "are worse than slow detection").
**Scope:** manager.
**Unless:** the director says to reassign; then first check the quiet worker's branch for unpushed work.

## team.live-first

**Rule:** A correction from live work goes ahead of improvement work.
**Why:** Live work is what the rules are for.
**Basis:** Cyril, 17 Nov 2026.
**Scope:** manager.

## team.manager

**Rule:** The manager sizes, splits, briefs, assesses and merges, one task at a time, after the director approves.
Before asking for approval it merges the latest main into the branch, in its own worktree, and reruns the checks. It
doesn't build beyond Small tasks, steer a builder mid-run, or call the job finished while rows are open.
**Why:** One gate keeps a known good state, and the director approves what will actually land. A manager busy
building stops seeing the whole.
**Basis:** Cyril, 9 Nov 2026 (only the manager merges, after approval; a branch holds the last approved state). Gas
Town Refinery (merge rehearsal). Willison ("one significant change at a time"). Cognition, 2026.
**Scope:** manager.

## team.size

**Rule:** Start with about 3 active agents. Add one only while the director keeps up with reviewing what lands.
**Why:** Review is the queue; agents past that wait on it.
**Basis:** No correction of Cyril's yet. Willison ("the natural bottleneck ... is how fast I can review the
results"). Yegge, "Introducing Beads" (a dozen agents "only sustainable for about 2 weeks", back to 1 to 3).
**Scope:** director and manager.
