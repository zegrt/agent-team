# Design

[SKILL.md](../SKILL.md) starts in solo mode. [Team rules](../team/RULES.md) apply when the director assigns roles or orders a team. An agent may suggest a team when the job divides into independent parts and each handoff can be tested, and switches only on the director's yes. Separate sessions and worktrees support mixed tools and machines. Shared state, one evolving design or one shared timeline favor a single editor. Benchmarks show that the advantage of delegation varies with how the task splits. [Agent scaling benchmarks](https://arxiv.org/abs/2512.08296)

## Reference and acceptance

In field use, a brief that retold the director's note changed what the builder thought they had asked for. Other edits started before anyone opened the live bug. Linking the exact note, target and version keeps those inputs available to each agent. A local correction applies to that work. Standing rules and added requirements need their own approval.

Early work in the real file lets the director judge one piece before the same choice is repeated. Checks on an export can catch regressions in that export. An editor, phone or live app can expose different behavior. Measured timing gives the director something they can compare. Full-speed playback leaves judgments about feel with them. [Motion perception study](https://aclanthology.org/2026.findings-acl.629/), [Runtime feature support](https://rive.app/docs/feature-support)

## What the earlier rules addressed

- **Board and task size.** Team messages got lost and summaries omitted corrections. A board record precedes a message. Small fixes stay with the manager. A design needs an approved plan before a build. The decision register stays short because old notes otherwise crowd out the decisions still in force. [Long-running agent harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents), [BMAD](https://github.com/bmad-code-org/BMAD-METHOD)
- **Ownership.** Changing a brief mid-run sent builders toward different targets. Switching a shared checkout put a commit on another task's branch. One writer per file, a hold before an incompatible change and a worktree per branch address those cases. A quiet thread can still have unpushed work. [Gas Town](https://github.com/gastownhall/gastown), [Beads](https://github.com/gastownhall/beads)
- **Briefs and reports.** Explicit output, file boundaries and checks keep work testable. Version fields and check output make a builder's result auditable. A short decision request made questions easier to answer. Workers' questions went unseen in their own threads, and reviews sent straight to the director bypassed assessment. The report-in goes to the manager. [Multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system), [Superpowers](https://github.com/obra/superpowers)
- **Reviews.** Seeing a builder's account first biased the review. Fixing each finding as it arrived expanded the work and sometimes let a finding disappear. The manager records each route. Two failed rounds warrant looking at the source again. A review now starts with a named risk and a reproducible check. Clarity, consistency and exceptions still matter when reviewing a written rule. [Superpowers](https://github.com/obra/superpowers), [Spec Kit](https://github.com/github/spec-kit)
- **Recovery and merge.** Rehearsal runs checks against current main and the task tip. The board pins the task and review commits so a new push cannot take the place of the reviewed work. The approved branch marks the last accepted landing. A new manager needs the active threads and unresolved decisions in a durable handoff. [Agent harness design](https://www.anthropic.com/research/harness-design-long-running-apps)
- **Cost and status.** In field use, watcher runs added work and still left stale status when a manager stopped. Report-ins and session events tell the manager when to reconcile the board with threads and worktrees. Routine work can start on a cheaper model. [Claude Code cost guidance](https://code.claude.com/docs/en/costs)

[The original plan](history/PLAN-2026-11-17.md#sources) preserves the first version's source list. The [rule map](RULE-MAP.md) records which instructions carried forward. Load the agent instructions for the chosen mode. This page is background.

## Testing

The [test notes](../tests/README.md) document blind grading and previous results. Those scores cover earlier wording. The v7 scenarios cover the new instructions and are authored against this revision, so they count as tuning scenarios.
