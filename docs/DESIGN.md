# Design

Why `agent-team` is shaped the way it is. The rules themselves are in [`SKILL.md`](../SKILL.md) and
[`RULES.md`](../RULES.md); this page explains the choices behind them.

## The gap it fills

Superpowers, BMAD, Spec Kit, Gas Town and Claude Code's own agent teams all organise AI agents. Most of them assume
one orchestrating session, work checked by automated tests, and a human at the start and the end. `agent-team` is the
thin layer they leave out:

- **separate sessions**, often on separate machines, with no shared memory between them;
- **Claude Code and Codex mixed** on one team;
- **judgment work** (writing, design, docs) as much as code, so "the tests pass" isn't the whole check;
- **a human director** who approves each merge and whose attention is the scarcest thing on the team.

It borrows the tested mechanisms of those projects where they fit, and credits each where it is used.

## Three layers, narrowest wins

1. **The project's board** (`WORKBOARD.md`): its decisions, roles, machines, logins and checks.
2. **The director's profile**, if there is one: taste and working style.
3. **This skill**: the general rules, true for any project and any director.

A live instruction from the director beats all three. If it breaks one of the skill's rules, the agent doesn't
silently obey or silently refuse: it puts it on the board as pending, says which rule it breaks and why the rule
exists, recommends, and acts on the answer. A board can tighten or add a rule for its own project; it never copies the
skill's text.

## Three shapes for three kinds of rule

Agents forget rules in a predictable way, so each kind of rule has the shape that survives best.

| Kind | Example | Shape | Where |
|---|---|---|---|
| **Judgment** | Route every review finding before fixing any | A short card: rule, why, basis, scope | [`RULES.md`](../RULES.md) |
| **Checkable** | A report gives each check's output | A field in a form, which can't be silently skipped | [`templates/`](../templates) |
| **Mechanical** | Merge, move the approved marker, delete the branches | A script, which runs the same way every time | [`scripts/team.py`](../scripts/team.py) |

When a rule doesn't stick, the first question is whether it is in the wrong shape, not how to say it louder. Two
fixes in this skill's history came from exactly that: a report's commit hash kept going missing until it became a
field, and two prose rules about changing tasks kept colliding until they became one state model.

## How work moves

**Sizes.** Each task is Small (the manager does it and says so), Content (brief, builder, one independent review,
the director's approval) or Design (a written plan, approved before anything is built). Process scales with risk.

**States.** A task is open, building, built, in review, reviewed, approved or merged; or held, blocked, needs info,
or pending a decision. Only the manager moves it, on the board.

**A running task doesn't move under its builder.** While a task is building, its brief is frozen and the files it
lists are its own. A change either holds the task and restarts it from a new brief (when the change makes the current
work wrong), or becomes a new task (when it only adds). This one rule covers new requirements from the director, a
review that fails twice, work that outgrows its size, and anyone else needing the same files.

**Everyone writes only their own branch.** The board and everything merged live on main, written only by the manager.
The work and the builder's report go on the task branch; the review on `review-<id>`; each agent's handoff on
`worker-<name>`. Git won't open one branch in two folders, and one writer per file means nothing collides.

**Merges are rehearsed and gated.** Before asking for approval, the manager merges the latest main into a throwaway
copy of the task branch and reruns the checks. After approval, it merges one task at a time and moves an `approved`
branch, so there is always a known good state to go back to.

## How it loads

- **Frontmatter:** only `name` (it must match the folder) and a `description` that says when to use the skill and
  nothing else. A description that summarises the workflow makes agents skip reading the steps.
- **What loads when:** at the start, both tools see only the name and description. `SKILL.md` loads when the skill is
  used; cards and templates only when a step points to them, so the cost in context stays small.
- **Where:** Claude Code reads `~/.claude/skills/`, Codex reads `~/.agents/skills/`. Both follow symlinks, so one
  clone serves both.
- **After a summary:** Claude Code keeps only the first part of a skill, and Codex documents nothing. So the session
  start sits at the top of `SKILL.md`, the board's first line points back to the skill, and an optional hook reminds
  the agent to re-read it.

## How it is tested, and its limits

Each rule is tested the way the Superpowers project tests skills: run the situation without the rule and watch it
fail, add the rule, and check it now passes. Scenarios are written by a separate agent that never sees the skill's
wording, on fictional projects; answers are graded blind by two different models against a rubric. A held-out
scenario is used once: after it shapes the wording, it only counts as tuning. The full method and every result,
gaps included, are in [`tests/README.md`](../tests/README.md).

Known limits:

- It was drawn from one real project and about ten days of one director's corrections. It assumes git, and one team
  with one manager per board.
- Lab scores are a stand-in. From here, the real test is the board's Corrections list: the same correction twice
  means a rule is failing.
- Windows and the Codex reminder hook are not tested yet.

## Sources

The full list, with URLs and dates, is at the end of [the original plan](history/PLAN-2026-11-17.md#sources). The
main ones:

- Anthropic: [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents),
  [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system),
  [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Superpowers](https://github.com/obra/superpowers), the [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD),
  [Spec Kit](https://github.com/github/spec-kit), [Gas Town](https://github.com/gastownhall/gastown) and
  [Beads](https://github.com/gastownhall/beads)
- Simon Willison, [Embracing the parallel coding agent lifestyle](https://simonwillison.net/2025/Oct/5/parallel-coding-agents/)
- Cemri et al., [Why Do Multi-Agent LLM Systems Fail?](https://arxiv.org/abs/2503.13657)
- The [Agent Skills specification](https://agentskills.io/specification)
