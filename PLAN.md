# Plan: the agent-team skill (17 Nov 2026, revised after research the same day)

For Cyril to approve before anything is built. Drawn from the motion playbook's WORKBOARD.md, HANDOFF.md,
inbox/README.md, workers/windows-claude.md, the 17 Nov house-scope plan and task 48 review, and profiles/cyril.md, read
at the director's machines (not edited). Published sources are listed at
the end, each with its URL and date.

## What it is

The general rules for one director running a team of AI agents on long work: a manager, builders and reviewers. Any
project, Claude or Codex. It holds no project details and no personal style. Three layers, narrowest wins:

1. the project's board: its dated decisions, roles, machines, threads, logins, checks;
2. the director's profile: taste and working style (Cyril's stays in his own profile);
3. this skill: the rules below.

A board can tighten or add a rule for its project, saying so on the board; it doesn't copy the skill's text.

## Files

```
agent-team/
  SKILL.md               when it applies; the rules that matter most, at the top; what to read first, by role
                         (manager, builder, reviewer); the precedence; "after a summary, re-read this file and RULES.md"
  RULES.md               the rule cards, with ids
  templates/BOARD.md     blank board: Roles, Project rules (only additions), Decisions, Tasks table
  templates/HANDOFF.md   a worker's handoff: Finished, Half-done, Next, To resume
  README.md              for people: what it is, how to install, how a rule is added
  PLAN.md                this file
```

Rule card, as the playbook's: **Rule**, **Why**, **Basis**, **Scope**; **Unless** and **Check** only when they add
something. Basis is Cyril's dated correction, a published source, or both. Where a rule is only Cyril's preference, the
Basis says so instead of borrowing a source that doesn't say it.

## The rules

Board and sessions

1. `board.one-source`: every task, decision and correction is written on the board first; a message only says "board
   updated, pull", plus anything urgent. Why: messages between agents get lost or half-read; one written place survives
   restarts. Basis: Cyril, 9 Nov ("y'all are miscommunicating a lot"); Anthropic, long-running harnesses (a
   progress file plus git); Anthropic, multi-agent research (subagents write to files to avoid "a game of telephone").
2. `board.session-start`: a session starts by pulling, then reading the board, its own handoff and the director's
   profile. A resumed or summarised session is a new one. Why: a summary of the rules is not the rules. Basis: Anthropic,
   long-running harnesses (each session reads the progress file); Cyril, 13 Nov (approved the resumed-session line);
   Claude Code skills docs (after a summary only the first 5,000 tokens of a skill come back, and older skills can be
   dropped); Codex documents nothing on this (see How it loads).
3. `board.facts`: report a state change as facts: the commit and the exact files. Check the work itself, not a status
   line. Why: a loose summary hides what changed, and status marks lag the work. Basis: Cyril, 9 Nov; Claude Code agent
   teams docs ("teammates sometimes fail to mark tasks as completed ... check whether the work is actually done").

Tasks and briefs

4. `task.brief`: a brief has five parts: objective, output format, tools and sources, boundaries (the files it touches),
   and what done looks like and how it will be checked, settled before work starts. Why: a builder knows only what the
   brief says; the lead's conversation doesn't carry over. Basis: Anthropic, multi-agent research ("without detailed
   task descriptions, agents duplicate work, leave gaps"); Claude Code agent teams docs ("The lead's conversation
   history does not carry over"); Anthropic, harness design (builder and evaluator agree "what done looked like ...
   before any code was written").
5. `task.size`: size the process to the change. Pointers, typos, board edits: the manager does them and says so.
   Content: a builder, one independent review, the director's approval. Structure or design: a plan to the director
   first. Why: full process on a typo wastes the director's time; none on a design wastes everyone's. Basis: Cyril,
   17 Nov; Anthropic, multi-agent research (scale effort to the task).
6. `task.one-per-run`: one task per run; a builder stops after each, and is interrupted only for an urgent hold, also
   written on the board. Why: corrections reach it between tasks, not mid-edit, and a run left alone too long drifts.
   Basis: Cyril, 9 Nov; Anthropic, long-running harnesses (one feature at a time); Claude Code agent teams docs ("Letting
   a team run unattended for too long increases the risk of wasted effort").
7. `task.one-writer`: each task names the files it touches; nobody edits a file another open task touches. Why:
   parallel writes collide, and overlapping tasks duplicate work. Basis: Cyril, 9 Nov; Cognition, "Don't build
   multi-agents" (writes stay single-threaded); Claude Code agent teams docs ("Two teammates editing the same file leads
   to overwrites"); MAST (step repetition is the most common failure mode, 15.7%).
8. `task.done`: done means checked end to end against the brief, with the checks named and their output shown, before it
   is handed on. A builder never edits or removes a test or check to make it pass; that goes to the manager. Why: agents
   mark work complete without testing it, and game tests when they can. Basis: Cyril, 9 Nov ("triple-check everything
   before bringing it to him", standing rule recorded in the playbook's HANDOFF.md, commit 77d8a40, 9 Nov; on the
   board since d403a70, 9 Nov); Anthropic, long-running harnesses ("Claude's tendency to mark a feature as complete
   without proper testing"; "It is unacceptable to remove or edit tests"); METR, reward hacking (models "modifying the
   tests or scoring code"); MAST (no or incomplete verification 8.2%, incorrect verification 9.1%).
9. `task.scope` (new): a builder does only its brief. Anything extra it notices (a fix, a cleanup, an idea) goes to the
   manager as a proposal. Why: models add files, abstractions and features nobody asked for, and the work grows. Basis:
   Cyril's profile, 9 Nov ("a fix that touches more than what was flagged" is plan first); Claude prompting best
   practices (a "tendency to overengineer by creating extra files, adding unnecessary abstractions"); MAST (disobey task
   specification 11.8%, task derailment 7.4%).

Review

10. `review.fresh`: whoever builds a task never reviews it; the reviewer starts with a clean context and is told to be
    sceptical. Why: a builder shares its own blind spots, and agents grade their own work too kindly. Basis: Cyril,
    17 Nov; Cognition, 2026; Claude Code best practices (review in a fresh agent); Anthropic, harness design ("agents
    reliably skew positive when grading their own work"; "tuning a standalone evaluator to be skeptical turns out to be
    far more tractable").
11. `review.shape`: review against the brief and the director's decisions, not style. Design first, then edge cases
    ranked and grouped by cause, each with a fix size, in one pass. Why: "a reviewer that's asked to find problems will
    always find something". Basis: Cyril, 9 Nov ("review quicker and better"); Claude Code best practices.
12. `review.assess`: the manager assesses findings before assigning fixes: shared cause, design or scope; fix, cut or
    defer. Findings that go against the director's decisions are dropped. A design or scope change goes to the
    director as a plan. Why: fixing symptoms one by one grows the work. Basis: Cyril, 9 Nov ("plan and asses after
    reviews, not immidiatly push to fixes"); Cognition, 2026 (the writer filters review feedback).
13. `review.restart`: after two failed rounds of fixes on the same thing, stop and rewrite the brief or the design.
    Why: the cause is upstream, and a builder and reviewer can otherwise loop. Basis: Claude Code best practices;
    Cyril, 9 Nov (approved rebuilding the kit smaller after two review rounds); Anthropic, "Building effective agents"
    ("stopping conditions (such as a maximum number of iterations)").

Approval and merge

14. `merge.approved`: only the manager merges, only after the director approves; a marker (a branch) holds the last
    approved state. Why: one gate, and a known good state to restore. Basis: Cyril, 9 Nov.
15. `merge.one-at-a-time`: merge one task at a time, then check the combined result. Why: two passing changes can fail
    together. Basis: Willison ("I can only focus on reviewing and landing one significant change at a time").
16. `decide.escalate` (was `decide.one-question`, narrowed): an agent stops and asks when it is blocked, after rule 13's
    two rounds, or before anything irreversible or outward-facing. Workers ask the manager; the manager asks the
    director. Why: pushing on past these points wastes work or does harm; not asking is itself a failure. Basis:
    Anthropic, "Building effective agents" ("pause for human feedback at checkpoints or when encountering blockers");
    OpenAI, practical guide to building agents (triggers: "Exceeding failure thresholds" and "High-risk actions");
    MAST (fail to ask for clarification, 6.8%). The form, one plain question with a recommendation, already checked, is
    Cyril's preference (17 Nov board; profile), not something the sources say.

The team

17. `team.size` (narrowed): start with about 3 active agents; add one only while the director keeps up with reviewing
    what lands. Review speed sets the limit, not a number. Why: past that, review becomes the queue, and each agent adds
    coordination. Basis: Willison ("the natural bottleneck on all of this is how fast I can review the results");
    Claude Code agent teams docs ("Start with 3-5 teammates for most workflows"; "Three focused teammates often
    outperform five scattered ones"; written for one lead's teammates, not per human). The old "3 or 4 per reviewer"
    figure has no primary source: Willison gives no number, and it appears only in secondary blogs.
18. `team.cost` (new): agents that are done are shut down; an agent is added only when the work is worth several times
    the tokens. Why: a team costs many times a single session, and an idle agent keeps spending. Basis: Anthropic,
    multi-agent research ("about 15× more tokens than chats"); Anthropic, harness design ("over 20x more expensive");
    Claude Code costs docs ("Each active teammate continues consuming tokens until it exits").
19. `team.manager`: the manager splits the work, briefs it and pulls the results together; it doesn't do the
    builders' work (beyond rule 5's small edits) or steer them mid-run, and it doesn't call the job finished while tasks
    are open. Why: a busy manager stops seeing the whole. Basis: Cognition, 2026; Claude Code agent teams docs
    ("Sometimes the lead starts implementing tasks itself"; "The lead can stop early too").
20. `team.handoff`: at the end of each day, each worker updates its handoff (template) and pushes it, so it can be
    replaced at any time. Why: work resumes instead of restarting. Basis: Cyril, 17 Nov; Anthropic, multi-agent research
    (checkpoints, resumed rather than restarted).
21. `team.unreachable`: if a worker can't be reached, ask the director to wake it; don't reassign its task. Why:
    reassigning splits ownership of half-done work. Basis: Cyril, 17 Nov.
22. `team.worktree`: never switch branches in a folder someone else works in; branch work goes in its own worktree,
    removed when done. Why: another agent's next commit lands on your branch. Basis: Cyril, 17 Nov (Codex switched the
    shared folder; the manager's commit landed on `task-48`).
23. `team.live-first`: a correction from live work goes ahead of improvement work. Why: live work is what the rules are
    for. Basis: Cyril, 17 Nov.

Left out on purpose: plain writing, no em dashes, "step back" and "exercise abstract thinking" meaning think, not build.
Those are Cyril's, in his profile.

## What stays on each project's board

Who holds which role; threads, environments and machines; logins, git identity and push commands; paths; the project's
checks (lint, tests); who approves which layer; the reviewer's brief (the playbook's CODEX-REVIEW.md); the task table
and dated decisions; workers' handoff files in `workers/`.

## How it loads (checked 17 Nov)

- **Frontmatter:** only `name: agent-team` (it must match the folder name) and a `description` under 1,024 characters,
  trigger words first. That passes the Agent Skills standard and both tools. Claude cuts the description at 1,536
  characters; Codex ignores fields it doesn't know. The description triggers on running, briefing, reviewing or handing
  off work between agents, or a project with a board.
- **What loads when:** at session start, both tools see only the name and description. The SKILL.md body loads when the
  skill is used. RULES.md and templates load only if SKILL.md says when to read them, so SKILL.md names them by role.
- **Claude Code:** `~/.claude/skills/agent-team`, a symlink to the clone. The docs say symlinked skill folders work, and
  the playbook already loads this way on this Mac (it is in this session's skill list).
- **Codex:** `~/.agents/skills/agent-team`, not `~/.codex/skills` as first planned. The docs name only
  `~/.agents/skills` and say symlinks are followed. Codex's source still reads `~/.codex/skills` but calls it
  deprecated, and a skill in both folders can show up twice, so use one. (The playbook's Codex link sits in the old
  folder and works today; moving it is a playbook task, not this one.)
- **Windows junctions:** neither tool documents them. The playbook runs on junctions on the Windows PC, but I found no recorded
  test of it. The build includes a cold test on Windows for both tools before the skill is called installed.
- **After a summary:** Claude re-attaches the first 5,000 tokens of the most recent use of each skill (25,000 shared,
  newest first), so the key rules go at the top of SKILL.md and SKILL.md stays short. Codex documents nothing; its source
  suggests a used skill's text is not kept, only what the summary says. So SKILL.md says to re-read itself and
  RULES.md after any summary, and the backstop stays: each board's first line says "Team rules: the agent-team skill;
  read it first", and the project's CLAUDE.md or AGENTS.md points to the board.
- SKILL.md says to `git pull --ff-only` in the skill folder at a session's start, as the playbook does.

## Where it lives

- Remote: github.com/zegrt/agent-team (private). Pushed with a command-scoped credential for the zegrt account; the
  active gh account is never switched.
- Clones: one on the director's Windows PC, one on the Mac.
- Installed as symlinks on the Mac and junctions on Windows, to each machine's clone.

## Build, then the move (separate steps)

1. **Build** (after your approval): the files above. Then a cold test like the playbook's of 6 Nov: fresh Claude and
   Codex sessions, on the Mac and on the Windows PC, given a team brief from an empty folder, must load the skill unprompted and
   cite rule ids. Then a fresh reviewer with no part in the build reviews it against this plan; I assess; you approve;
   installed.
2. **Move the playbook's team text** (later, a playbook task through its own flow): WORKBOARD.md Rules keep only
   project additions, with a pointer to the skill; HANDOFF.md "Who does what" and "How work flows" keep the project
   facts and point to the skill for the rest; CODEX-REVIEW.md's method points to `review.shape`; `workers/*.md` follow
   the template. `inbox/README.md` stays: it is the playbook's content flow for outside contributors, and public.
   Nothing in the skill depends on the playbook.

## Sources

Read on 17 Nov 2026. "No date" means a living docs page with no date on it.

- Anthropic, "Building effective agents", 19 Dec 2024. https://www.anthropic.com/engineering/building-effective-agents
- Anthropic, "How we built our multi-agent research system", 13 Jun 2025.
  https://www.anthropic.com/engineering/multi-agent-research-system
- Anthropic, "Effective harnesses for long-running agents", 26 Nov 2025.
  https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- Anthropic, "Harness design for long-running application development", 24 Mar 2026.
  https://www.anthropic.com/engineering/harness-design-long-running-apps
- Cognition, "Don't build multi-agents" and "Multi-agents: what's actually working" (2026), as in the first plan.
- Claude Code docs, no date: best practices; skills https://code.claude.com/docs/en/skills; agent teams
  https://code.claude.com/docs/en/agent-teams; costs https://code.claude.com/docs/en/costs
- Claude prompting best practices, no date.
  https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
- Codex skills docs, no date (developers.openai.com/codex/skills now redirects here).
  https://learn.chatgpt.com/docs/build-skills ; source: https://github.com/openai/codex (`codex-rs/ext/skills`,
  `codex-rs/skills/src/parser.rs`); symlink support PR #8801, 7 Jan 2026; `.agents/skills` PRs #10317 and #10437,
  1 and 3 Feb 2026.
- Agent Skills specification, last changed 4 Aug 2026. https://agentskills.io/specification
- OpenAI, "A practical guide to building agents", Apr 2025 (the PDF has no date; its metadata says 7 Apr 2025).
  https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf
- Cemri et al., "Why Do Multi-Agent LLM Systems Fail?" (MAST), arXiv 2503.13657, v3 26 Oct 2025 (percentages from
  v3). https://arxiv.org/abs/2503.13657
- METR, "Recent frontier models are reward hacking", 5 Jun 2025. https://metr.org/blog/2025-06-05-recent-reward-hacking/
- Simon Willison, "Embracing the parallel coding agent lifestyle", 5 Oct 2025.
  https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
