# Plan: the agent-team skill (17 Nov 2026, reworked after research, a step back and a look at prior art)

For Cyril to approve before anything is built. Drawn from the motion playbook's WORKBOARD.md, HANDOFF.md,
inbox/README.md, workers/windows-claude.md, the 17 Nov house-scope plan and task 48 review, and profiles/cyril.md, read
at the director's machines (not edited). Published sources and prior art
are listed at the end, each with its URL or path and date.

## What it is

The general rules for one director running a team of AI agents on long work: a manager, builders and reviewers. Any
project, Claude or Codex. It holds no project details and no personal style. Three layers, narrowest wins:

1. the project's board: its dated decisions, roles, machines, threads, logins, checks;
2. the director's profile: taste and working style (Cyril's stays in his own profile);
3. this skill.

A live instruction from the director beats all three; the manager writes it on the board straight away. If it goes
against a rule in the skill, the agent first tells the director which rule and why, with a recommendation, and acts on
the answer (added after the held-out test, 17 Nov: Codex read "live beats the skill" as licence for a third fix
round). A board can
tighten or add a rule for its project, saying so on the board; it doesn't copy the skill's text.

Assumes: the project is a git repo, and one team with one manager per board. This is v1, drawn from one project and nine days of
the director's corrections (9 to 17 Nov 2026). Each new correction goes in through README's "how a rule is added",
with its date.

## Why it exists, given what's out there

Superpowers, BMAD, Spec Kit, Gas Town and Claude Code's agent teams all cover agent teams. All of them assume one
orchestrating session, work checked by tests, and the human at the start and the end. This skill is the thin layer they
don't cover: separate sessions on two machines, Claude and Codex mixed, mostly judgment work, and the director
approving each merge. It borrows their tested mechanisms where they fit, each tied below to the correction it serves.

## The idea: forms carry the checks, cards carry the judgment

What agents forget is the checkable part: name the files, say how done is checked, show the output, don't review your
own work. A rule in prose gets lost after a summary; a field in a form doesn't. So the checkable rules become fields in
the templates. Only calls that need judgment stay as rule cards, each led by the director's dated correction that caused
it. Superpowers reached the same split independently ("Omits a required element ... REQUIRED field or slot in the
template"), and BMAD measured that a reviewer persona changed nothing while a concrete method did.

The risk is ceremony, and the director pays for it: Scott Logic timed Spec Kit at 3.5 hours of human review against
about 25 minutes (review and testing) without it. So forms are short (a brief under about a page), and each field says which size of task needs
it. A typo needs no form.

## Files

```
agent-team/
  SKILL.md               triggers only in the description; the session start; each role's steps (manager, builder,
                         reviewer), each pointing to the form or card behind it; "after a summary, trust the board
                         and git log over memory, and re-read this file"
  RULES.md               the judgment cards, with ids
  templates/BOARD.md     blank board: Roles, Project rules (additions only), Decisions, Tasks table, Noticed
  templates/BRIEF.md     a task brief, with the builder's Report at the end
  templates/REVIEW.md    a review, with the re-review at the end
  templates/HANDOFF.md   a worker's handoff
  hooks/                 optional: re-inject the session start after a summary (Claude Code and Codex)
  inbox/                 team corrections from other projects, one new file each; only the skill's manager edits
                         the skill (agreed with the playbook's manager, 17 Nov)
  README.md              for people: what it is, how to install, how a rule or field is added
  PLAN.md                this file
```

Every field has a one-line comment: why it is there, and its Basis.

## Sizes

The manager states the size in the task row, in plain words, so the director can overrule it. If the work grows, it
stops, says so and steps up a size. Size is set by three facts, not by the type of work: are there gaps in what the
director asked for, is anything irreversible or outward-facing, and how much does it touch.

- **Small** (pointers, typos, board edits): the manager does it and says so. No brief, no review.
- **Content:** a brief, a builder, one independent review, the director's approval.
- **Design:** a plan to the director first, then as Content.

Basis: Cyril, 17 Nov; Superpowers brainstorming ("pick a size and say it in plain words. They can override it ... If it
grows mid-task, stop, say so, and step up a size"); BMAD build-a-change (route by intent gaps, irreversibility and
footprint).

## The forms

**BOARD.md, Tasks table.** One row per task:

| Column | Why | Basis |
|---|---|---|
| Id, Task | one task per run, with a stable id used in commits and branch names | Cyril, 9 Nov; Anthropic, long-running harnesses |
| Size | stated, so the director can overrule it | see Sizes |
| Files | the manager assigns nothing whose files overlap an open task | Cyril, 9 Nov; Cognition; Claude Code agent teams docs |
| Branch | where the work goes; checked before every commit | Cyril, 17 Nov (commit landed on `task-48`) |
| Builder, Reviewer | must differ; a builder's own review counts for nothing | Cyril, 17 Nov; Superpowers implementer prompt |
| Rounds | review rounds so far; at 2, card `review.restart` | Cyril, 9 Nov; BMAD ("a third pass ... something is wrong upstream") |
| State | open, built, blocked, reviewed, approved (date), merged; checked against the work, not trusted | Cyril, 9 Nov; Gas Town #4505 (blocked work marked done) |

Only the manager edits the board. Workers write only their own files: the report in their brief, and their handoff.
The manager copies what matters onto the board. Basis: the one-writer rule applied to the team's own files; Cyril,
9 Nov.

Above the table: the board's first line ("Team rules: the agent-team skill; read it first") and the branch holding the
last approved state (Cyril, 9 Nov). Below it, **Noticed**: anything a worker noticed outside its task, with the task
it came from. Nobody acts on one until the manager makes it a task. (Named "Noticed", not "Proposals", so it doesn't
clash with a project's own proposals flow, like the playbook's `inbox/`.) Basis: BMAD deferred-work; Beads
`discovered-from`.

**BRIEF.md** (Content and Design). Filled in as `briefs/<id>.md` in the project, linked from the task row, since a
message only says "pull". Objective; output; tools and sources; Files (only these); Branch; Done when (the
checks, settled before work starts); Out of scope (anything else goes to Noticed; tests and checks are never edited to
pass); Board commit (the board version the brief was cut from). Basis: Anthropic, multi-agent research; Anthropic,
harness design (agree what done is "before any code was written"); Anthropic, long-running harnesses ("unacceptable to
remove or edit tests"); Superpowers (record the base commit before dispatch).

**Report** (end of the brief, filled by the builder):
- Status, one word: done, done with concerns, needs info, or blocked. Silence is never read as any of them.
- Board commit, repeated from the brief: proof of which board it read.
- Commit, files changed, and any file changed outside Files, with why.
- Checks run, with their output.
- Rulings: small calls made alone, each with why and what it costs if wrong. The director reads the list instead of
  being asked each one.
- Branch pushed, folder clean, nothing unpushed.

Basis: Cyril, 9 Nov (facts with the commit and exact files; triple-check before handing on, recorded in HANDOFF.md,
commit 77d8a40, and on the board since d403a70); Superpowers implementer prompt (the four statuses) and ledger
(`Ruling: what, why, cost if wrong`); BMAD #2563 (declare files changed beyond the task); Gas Town Witness (check for
unpushed work); Anthropic, long-running harnesses (features marked complete without testing).

**REVIEW.md** (Content and Design):
- Against the brief and the director's decisions, not style. Design first: does it hold, is anything there no one needs.
- Then: what is missing? Then findings, ranked, grouped by cause, each with a fix size. One pass.
- For written rules: is each rule clear (no unquantified "smooth" or "punchy"), consistent with the others and the
  director's decisions, and complete on exceptions?
- Re-review, after fixes: each finding marked fixed or not fixed. "Tried" is not fixed. Nothing new is added here.

Basis: Cyril, 9 Nov ("review quicker and better"); BMAD #2675 (asking what is missing helped, a persona didn't);
Spec Kit checklists (clarity, consistency, completeness); Superpowers re-review ("'Attempted' is not addressed").

**HANDOFF.md.** Finished (commits); half-done and where; next; the session or thread id to resume; what a new session
needs, on another thread or machine. Updated and pushed at the end of each day's work. Basis: Cyril, 17 Nov; Anthropic,
multi-agent research (resume rather than restart).

## The cards (RULES.md)

Each led by the correction that caused it.

1. `board.one-source`: every task, decision and correction is written on the board first; a message only says "board
   updated, pull", plus anything urgent. After a summary, trust the board and git log over memory. Why: messages between
   agents get lost; a summary is not the record. Basis: Cyril, 9 Nov ("y'all are miscommunicating a lot"); Anthropic,
   long-running harnesses; Superpowers (lost place after a summary was "the single most expensive failure observed");
   BMAD #2539 (team members miss messages not addressed to them).
2. `task.size`: see Sizes. Why: full process on a typo wastes the director's time; none on a design wastes everyone's.
   Basis: Cyril, 17 Nov.
3. `review.assess`: before any fix, the manager gives every finding a route and a reason: fix (small and clear),
   rewrite the brief (the cause is upstream; when torn, choose this), ask the director (his intent is unclear, or it
   changes the team's rules), or later (it was there before this task). A problem this task caused is never put off.
   A finding against the director's decisions is dropped but listed for him as "dropped: against decision X". Nothing
   is dropped silently. Why: fixing symptoms one by one grows the work, and a silent drop hides a real problem. Basis:
   Cyril, 9 Nov ("plan and asses after reviews, not immidiatly push to fixes"); BMAD review triage ("recorded reason,
   never silently"; "a problem this change caused is never deferred"); Cognition, 2026.
4. `review.restart`: after two failed rounds on the same thing, the manager stops and rewrites the brief, writing down
   what to keep. If the rewrite changes the design, it goes to the director first (card 5). Why: the cause is upstream. Basis: Cyril, 9 Nov (rebuilt the kit smaller after two rounds); BMAD; Claude
   Code best practices.
5. `decide.escalate`: stop and ask when blocked, when a rewrite after two failed rounds changes the design, or before
   anything irreversible or outward-facing. Workers ask the manager; the manager asks the director, as one plain question with a recommendation,
   already checked. Anything smaller is a Ruling in the report. Why: his attention is the scarce part. Basis: Cyril,
   17 Nov (the form); Anthropic, "Building effective agents"; OpenAI's practical guide.
6. `team.worktree`: never switch branches in a folder someone else works in; branch work goes in its own worktree. At
   session start and before every commit, check the folder is clean and on the task's branch; if not, stop and ask.
   Before removing a worktree, check nothing is unpushed. Why: another agent's commit lands on your branch, and the
   check catches it before it does. Basis: Cyril, 17 Nov (Codex switched the shared folder; the manager's commit landed
   on `task-48`); BMAD ("Is the working tree clean? Does the current branch make sense"); Gas Town Witness.
7. `team.unreachable`: a quiet worker is not a dead one. If it hasn't reported a status, ask the director to wake it;
   don't reassign its task. Why: reassigning splits ownership of half-done work. Basis: Cyril, 17 Nov; Gas Town's design
   doc (false alarms on stuck workers "are worse than slow detection").
8. `team.live-first`: a correction from live work goes ahead of improvement work. Basis: Cyril, 17 Nov.
9. `team.manager`: the manager sizes, splits, briefs, assesses and merges, one task at a time, after the director
   approves. Before asking for approval it merges the latest main into the branch and reruns the checks, in its own worktree,
   so he approves what will land. It doesn't build (beyond Small tasks), steer a builder mid-run, or call the job finished while rows
   are open. Why: one gate and a known good state; a busy manager stops seeing the whole. Basis: Cyril, 9 Nov (only the
   manager merges, after approval); Gas Town Refinery (merge rehearsal before merge); Willison ("one significant change
   at a time"); Cognition, 2026.
10. `team.size`: start with about 3 active agents; add one only while the director keeps up with reviewing. Basis: no
    correction of Cyril's yet; Willison ("the natural bottleneck ... is how fast I can review the results"); Yegge,
    "Introducing Beads" (a dozen agents "only sustainable for about 2 weeks", back to 1 to 3). The "3 or 4 per reviewer" figure in the
    first plan had no primary source.

Left out on purpose: personas and role rosters (BMAD measured no gain and dropped them); phase gates on every change
(Spec Kit's cost); Beads (its Dolt store takes the board out of git diffs and allows one writer by default); watchdog
agents (Gas Town's killed working agents); "don't pause" autonomy (Superpowers; clashes with approval at each merge);
"at least ten findings" (helps code, makes noise on judgment work); a separate constitution file (a fourth authority);
long skills and all-caps wording. `team.cost` is dropped: no correction of Cyril's, and cost hasn't been his limit.
Plain writing, no em dashes and "step back" are Cyril's, in his profile.

## What stays on each project's board

Who holds which role; threads, environments and machines; logins, git identity and push commands; paths; the project's
checks (lint, tests); who approves which layer; the reviewer's brief (the playbook's CODEX-REVIEW.md); the task table,
the Noticed list and dated decisions; filled briefs in `briefs/`; workers' handoff files in `workers/`.

## How it loads (checked 17 Nov)

- **Frontmatter:** only `name: agent-team` (it must match the folder) and a `description` under 1,024 characters that
  lists when to use it and nothing else. Superpowers tested that a description summarising the workflow made agents
  skip steps.
- **What loads when:** at start, both tools see only the name and description; SKILL.md's body loads when the skill is
  used; RULES.md and templates only when SKILL.md says to read them.
- **Claude Code:** `~/.claude/skills/agent-team`, a symlink to the clone. Documented, and the playbook loads this way
  on this Mac today.
- **Codex:** `~/.agents/skills/agent-team`. The docs name only that folder and say symlinks are followed;
  `~/.codex/skills` still loads but is deprecated, and a skill in both can show twice.
- **Windows junctions:** neither tool documents them, and I found no recorded test. Tested at build.
- **After a summary:** Claude brings back the first 5,000 tokens of a skill in use; Codex documents nothing. So SKILL.md
  stays short with the session start at the top, and an optional hook re-injects it after a summary: Claude Code's
  `SessionStart` with the `compact` matcher (documented); Codex's compaction hooks (documented by Beads for Codex
  0.129+, not yet confirmed in Codex's own docs; this Mac has 0.169). The board's first line stays as the backstop.
- SKILL.md says to `git pull --ff-only` in the skill folder at a session's start.

## Where it lives

- Remote: github.com/zegrt/agent-team (private), pushed with a command-scoped credential; the active gh account is
  never switched.
- Clones: one on the director's Windows PC, one on the Mac. Symlinks on the Mac,
  junctions on Windows.

## Build, test, then the move (separate steps)

1. **Build** (after your approval): the files above.
2. **Load test:** fresh Claude and Codex sessions, on the Mac and on the Windows PC, given a team brief in a scratch folder,
   must load the skill unprompted; then a forced summary, to see the hook bring it back. Before you approve the
   install, the skill sits in the scratch folder's own skill folders (`.claude/skills`, `.agents/skills`), so nothing
   in your user folders changes.
3. **Correction replay:** your dated corrections become scenarios, given to fresh agents with and without the skill,
   at least 5 runs each, scored blind, under pressure (time, sunk cost, an instruction that pulls the wrong way). The
   rules were written from these corrections, so a pass on them proves little: the wording is tuned on four or five,
   and two are kept aside, unseen while writing, as the real test, with one or two failures from the research that
   didn't come from you (work marked done with no proof; a finding dropped silently). The scenarios:
   - a correction sent only in a message, not on the board (9 Nov);
   - review findings in, fixes pushed straight away (9 Nov);
   - a third fix round on the same finding (9 Nov);
   - a builder about to review its own task (17 Nov);
   - full process proposed for a typo, and a design change started without a plan (17 Nov);
   - a worker silent, the task about to be reassigned (17 Nov);
   - a branch switch needed in a shared folder (17 Nov).
   Pass: the agent with the skill takes the corrected action and cites the card or field. When it fails, ask it how the
   skill should have been written, and fix the wording. What agents said in the runs becomes a short "they said /
   instead" list in SKILL.md, where it loads first. A scenario where the skill makes no difference is dropped.
4. **Review:** a fresh reviewer with no part in the build reviews it against this plan; I assess; you approve;
   installed.
5. **Move the playbook's team text** (later, a playbook task through its own flow): WORKBOARD.md keeps only project
   additions, with a pointer to the skill, and adopts the task table's columns and Noticed; HANDOFF.md keeps the
   project facts; CODEX-REVIEW.md's method points to REVIEW.md; `workers/*.md` follow the handoff template; the
   playbook's Codex link moves to `~/.agents/skills`. `inbox/README.md` stays. Nothing in the skill depends on the
   playbook.

## Sources

Read on 17 Nov 2026. "No date" means a living docs page with no date on it.

Published:
- Anthropic, "Building effective agents", 19 Dec 2024. https://www.anthropic.com/engineering/building-effective-agents
- Anthropic, "How we built our multi-agent research system", 13 Jun 2025.
  https://www.anthropic.com/engineering/multi-agent-research-system
- Anthropic, "Effective harnesses for long-running agents", 26 Nov 2025.
  https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- Anthropic, "Harness design for long-running application development", 24 Mar 2026.
  https://www.anthropic.com/engineering/harness-design-long-running-apps
- Cognition, "Don't build multi-agents" and "Multi-agents: what's actually working" (2026), as in the first plan.
- Claude Code docs, no date: best practices; skills https://code.claude.com/docs/en/skills; agent teams
  https://code.claude.com/docs/en/agent-teams; hooks https://code.claude.com/docs/en/hooks
- Codex skills docs, no date (developers.openai.com/codex/skills now redirects here).
  https://learn.chatgpt.com/docs/build-skills ; source https://github.com/openai/codex (`codex-rs/ext/skills`,
  `codex-rs/skills/src/parser.rs`); symlinks since PR #8801, 7 Jan 2026; `.agents/skills` since PRs #10317 and
  #10437, 1 and 3 Feb 2026.
- Agent Skills specification, last changed 4 Aug 2026. https://agentskills.io/specification
- OpenAI, "A practical guide to building agents", Apr 2025 (PDF undated; metadata 7 Apr 2025).
  https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf
- Cemri et al., "Why Do Multi-Agent LLM Systems Fail?" (MAST), arXiv 2503.13657, v3 26 Oct 2025.
  https://arxiv.org/abs/2503.13657
- METR, "Recent frontier models are reward hacking", 5 Jun 2025. https://metr.org/blog/2025-06-05-recent-reward-hacking/
- Simon Willison, "Embracing the parallel coding agent lifestyle", 5 Oct 2025.
  https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- Colin Eberhardt, "Putting Spec Kit through its paces", Scott Logic, 26 Nov 2025.
  https://blog.scottlogic.com/2025/11/26/putting-spec-kit-through-its-paces-radical-idea-or-reinvented-waterfall.html

Prior art (read at the source):
- Superpowers 7.0.0 (Claude Code plugin, installed on the Mac): `subagent-driven-development` (SKILL.md, implementer,
  task-reviewer and re-review prompts), `brainstorming`, `writing-skills` (incl. testing-skills-with-subagents.md),
  `verification-before-completion`, `using-git-worktrees`.
- BMAD Method, https://github.com/bmad-code-org/BMAD-METHOD, main at e435a22 (12 Nov 2026), v6.12.4 (14 Oct 2026):
  CHANGELOG (#2539, #2563, #2675), docs/build/build-a-change.md and review-a-change.md, bmad-build step-01.
- GitHub Spec Kit, https://github.com/github/spec-kit, 617d9fb (17 Nov 2026); launch post 2 Sep 2025.
- Gas Town, https://github.com/gastownhall/gastown, 94cc8228 (12 Nov 2026): docs/design/polecat-lifecycle-patrol.md,
  mol-refinery-patrol formula; issues #4505, #4535, #4949. Beads, https://github.com/gastownhall/beads, 126b30aad
  (17 Nov 2026): docs/integrations/codex.md. Steve Yegge, "Welcome to Gas Town", 1 Jan 2026, and "Introducing
  Beads", 13 Oct 2025, https://steve-yegge.medium.com/
