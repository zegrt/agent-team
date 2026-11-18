# agent-team

A skill for one human director running a team of AI agents on long work: a manager, builders and reviewers, in
separate sessions or on separate machines, with Claude Code and Codex together. It holds the general rules; each
project's board holds its own facts (who, where, logins, checks), and the director's profile holds personal style.

Assumes one team, with one manager, per board. v1, drawn from one project (the motion playbook) and the director's corrections of 9 to 17 Nov 2026. Why it is shaped
this way, and every source, is in [PLAN.md](PLAN.md).

## What's here

- `SKILL.md`: the session start, the sizes, and each role's steps.
- `RULES.md`: the judgment cards, each with Why and Basis.
- `templates/`: the board, a brief, the builder's report, a review (with the re-review), a handoff, and the
  message forms (status and questions to the director). The checkable rules are fields here.
- `scripts/team.py`: the mechanical chores, so they run the same way every time: `status` (each task's state and
  commit hash), `rehearse` (latest main merged into a throwaway copy, checks run), `merge` (only when the board says
  approved), `steps` (the same by hand). Standard Python; on Windows run it with `python`.
- `hooks/`: optional; re-inject the session start after a summary.

## Install

One clone per machine, linked into each tool's skill folder.

Mac:
```sh
clone=~/agent-team          # wherever you keep it
git clone https://github.com/zegrt/agent-team.git "$clone"
mkdir -p ~/.claude/skills ~/.agents/skills
ln -s "$clone" ~/.claude/skills/agent-team   # Claude Code
ln -s "$clone" ~/.agents/skills/agent-team   # Codex
```

Windows (PowerShell). Not yet tested; the load test on Windows confirms it:
```powershell
$clone = "C:\path\to\agent-team"
git clone https://github.com/zegrt/agent-team.git $clone
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills", "$HOME\.agents\skills" | Out-Null
New-Item -ItemType Junction -Path "$HOME\.claude\skills\agent-team" -Target $clone
New-Item -ItemType Junction -Path "$HOME\.agents\skills\agent-team" -Target $clone
```
A junction needs a local drive. If the clone is on a mapped network share, use `-ItemType SymbolicLink` instead (needs
Developer Mode or an admin shell).

Use `~/.agents/skills` for Codex, not `~/.codex/skills`: Codex documents only the first, and a skill in both can show
up twice.

Then, in each project: copy `templates/BOARD.md` to the project as `WORKBOARD.md` (its first line points agents to
this skill), and add a line to the project's `CLAUDE.md` or `AGENTS.md`: "Read WORKBOARD.md first."

### Optional: bring the rules back after a summary

Claude Code keeps only the first part of a skill after a summary, and Codex documents nothing. The hook reminds the
agent to re-read the skill and trust the board. Mac only for now: on Windows it needs Git Bash and is untested.

- Claude Code (tested 17 Nov 2026, including a manual `/compact`): merge `hooks/claude-settings.json` into
  `~/.claude/settings.json`.
- Codex (untested; the setup follows Beads' Codex docs, for Codex 0.129 or later): merge `hooks/codex-hooks.json`
  into `~/.codex/hooks.json`, and set `[features] hooks = true` in `~/.codex/config.toml`. Check it fires before
  relying on it.

## Adding a rule or a field

A new rule starts as a correction from the director, with its date. From another project, it arrives as a file in
`inbox/` (see `inbox/README.md`); only the skill's own manager edits the skill.

1. If it is checkable (something an agent can leave out), add it as a field in a template, with a one-line comment
   giving why and basis.
2. If it needs judgment, add a card to `RULES.md`: Rule, Why, Basis (the dated correction first), Scope.
3. Add a scenario for it to the test set, and check that agents with the skill now get it right and agents without it
   don't. A rule that changes nothing is cut.
