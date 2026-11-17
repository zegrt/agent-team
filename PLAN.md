# Plan: the agent-team skill (17 Nov 2026)

For Cyril to approve before anything is built. Drawn from the motion playbook's WORKBOARD.md, HANDOFF.md,
inbox/README.md, workers/windows-claude.md, the 17 Nov house-scope plan and task 48 review, and profiles/cyril.md, read
at the director's machine (not edited).

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
  SKILL.md               when it applies; what to read first, by role (manager, builder, reviewer); the precedence
  RULES.md               the rule cards, with ids
  templates/BOARD.md     blank board: Roles, Project rules (only additions), Decisions, Tasks table
  templates/HANDOFF.md   a worker's handoff: Finished, Half-done, Next, To resume
  README.md              for people: what it is, how to install, how a rule is added
  PLAN.md                this file
```

Rule card, as the playbook's: **Rule**, **Why**, **Basis**, **Scope**; **Unless** and **Check** only when they add
something. Basis is Cyril's dated correction, a published source, or both.

## The rules

Board and sessions

1. `board.one-source`: every task, decision and correction is written on the board first; a message only says "board
   updated, pull", plus anything urgent. Why: messages between agents get lost or half-read; one written place survives
   restarts. Basis: Cyril, 9 Nov ("y'all are miscommunicating a lot"); Anthropic, long-running harnesses (a progress
   file plus git).
2. `board.session-start`: a session starts by pulling, then reading the board, its own handoff and the director's
   profile. A resumed or summarised session is a new one. Why: a summary of the rules is not the rules. Basis: Anthropic,
   long-running harnesses (each session reads the progress file); Cyril, 13 Nov (approved the resumed-session line).
3. `board.facts`: report a state change as facts: the commit and the exact files. Why: a loose summary hides what
   changed. Basis: Cyril, 9 Nov.

Tasks and briefs

4. `task.brief`: a brief has four parts: objective, output format, tools and sources, boundaries (the files it touches).
   Why: a builder knows only what the brief says. Basis: Anthropic, multi-agent research system.
5. `task.size`: size the process to the change. Pointers, typos, board edits: the manager does them and says so.
   Content: a builder, one independent review, the director's approval. Structure or design: a plan to the director
   first. Why: full process on a typo wastes the director's time; none on a design wastes everyone's. Basis: Cyril,
   17 Nov; Anthropic, multi-agent research (scale effort to the task).
6. `task.one-per-run`: one task per run; a builder stops after each, and is interrupted only for an urgent hold, also
   written on the board. Why: corrections reach it between tasks, not mid-edit. Basis: Cyril, 9 Nov; Anthropic,
   long-running harnesses (one feature at a time).
7. `task.one-writer`: each task names the files it touches; nobody edits a file another open task touches. Why:
   parallel writes collide. Basis: Cyril, 9 Nov; Cognition, "Don't build multi-agents" (writes stay single-threaded).
8. `task.done`: done means checked end to end against the brief, with the checks named, before it is handed on. Why:
   "done" that wasn't checked comes back as a correction. Basis: Anthropic, long-running harnesses; Cyril's board rule
   that everyone triple-checks (date to confirm from the archive at build).

Review

9. `review.fresh`: whoever builds a task never reviews it; the reviewer starts with a clean context. Why: a builder
   shares its own blind spots. Basis: Cyril, 17 Nov; Cognition, 2026; Claude Code best practices (review in a fresh
   agent).
10. `review.shape`: review against the brief and the director's decisions, not style. Design first, then edge cases
    ranked and grouped by cause, each with a fix size, in one pass. Why: "a reviewer that's asked to find problems will
    always find something". Basis: Cyril, 9 Nov ("review quicker and better"); Claude Code best practices.
11. `review.assess`: the manager assesses findings before assigning fixes: shared cause, design or scope; fix, cut or
    defer. Findings that go against the director's decisions are dropped. A design or scope change goes to the
    director as a plan. Why: fixing symptoms one by one grows the work. Basis: Cyril, 9 Nov ("plan and asses after
    reviews, not immidiatly push to fixes"); Cognition, 2026 (the writer filters review feedback).
12. `review.restart`: after two failed rounds of fixes on the same thing, stop and rewrite the brief or the design.
    Why: the cause is upstream. Basis: Claude Code best practices; Cyril, 9 Nov (approved rebuilding the kit smaller
    after two review rounds).

Approval and merge

13. `merge.approved`: only the manager merges, only after the director approves; a marker (a branch) holds the last
    approved state. Why: one gate, and a known good state to restore. Basis: Cyril, 9 Nov.
14. `merge.one-at-a-time`: merge one task at a time, then check the combined result. Why: two passing changes can fail
    together. Basis: practitioners on parallel agents (Willison and others).
15. `decide.one-question`: a decision reaches the director as one plain question with a recommendation, already
    checked. Why: his attention is the scarce part. Basis: Cyril, 17 Nov; Willison (human review is the bottleneck).

The team

16. `team.size`: about 3 or 4 active agents per human reviewer. Why: past that, review becomes the queue. Basis:
    Willison; practitioners' limit.
17. `team.manager`: the manager splits the work, briefs it and pulls the results together; it doesn't do the
    builders' work (beyond rule 5's small edits) or steer them mid-run. Why: a busy manager stops seeing the whole.
    Basis: Cognition, 2026.
18. `team.handoff`: at the end of each day, each worker updates its handoff (template) and pushes it, so it can be
    replaced at any time. Why: work resumes instead of restarting. Basis: Cyril, 17 Nov; Anthropic, multi-agent research
    (checkpoints, resumed rather than restarted).
19. `team.unreachable`: if a worker can't be reached, ask the director to wake it; don't reassign its task. Why:
    reassigning splits ownership of half-done work. Basis: Cyril, 17 Nov.
20. `team.worktree`: never switch branches in a folder someone else works in; branch work goes in its own worktree,
    removed when done. Why: another agent's next commit lands on your branch. Basis: Cyril, 17 Nov (Codex switched the
    shared folder; the manager's commit landed on `task-48`).
21. `team.live-first`: a correction from live work goes ahead of improvement work. Why: live work is what the rules are
    for. Basis: Cyril, 17 Nov.

Left out on purpose: plain writing, no em dashes, "step back" and "exercise abstract thinking" meaning think, not build.
Those are Cyril's, in his profile.

## What stays on each project's board

Who holds which role; threads, environments and machines; logins, git identity and push commands; paths; the project's
checks (lint, tests); who approves which layer; the reviewer's brief (the playbook's CODEX-REVIEW.md); the task table
and dated decisions; workers' handoff files in `workers/`.

## How it loads

- **Claude Code:** `~/.claude/skills/agent-team`, a link to the clone. SKILL.md's description triggers on running,
  briefing, reviewing or handing off work between agents, or a project with a board.
- **Codex:** `~/.codex/skills/agent-team`, the same link; Codex reads the same SKILL.md frontmatter.
- **Backstop:** each board's first line says "Team rules: the agent-team skill; read it first", and the project's
  CLAUDE.md or AGENTS.md points to the board, since a summarised session can drop a skill.
- SKILL.md says to `git pull --ff-only` in the skill folder at a session's start, as the playbook does.

## Where it lives

- Source: this folder, its own git repo (made now, with this plan as the first commit).
- Installed on Windows as junctions from both skill folders to it; on the Mac as symlinks to a clone.
- The Mac needs a remote: a private GitHub repo, created only on your go, at build time.

## Build, then the move (separate steps)

1. **Build** (after your approval): the files above; Basis dates checked against the playbook's archive. Then a fresh
   reviewer with no part in the build reviews it against this plan; I assess; you approve; installed.
2. **Move the playbook's team text** (later, a playbook task through its own flow): WORKBOARD.md Rules keep only
   project additions, with a pointer to the skill; HANDOFF.md "Who does what" and "How work flows" keep the project
   facts and point to the skill for the rest; CODEX-REVIEW.md's method points to `review.shape`; `workers/*.md` follow
   the template. `inbox/README.md` stays: it is the playbook's content flow for outside contributors, and public.
   Nothing in the skill depends on the playbook.
