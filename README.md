# agent-team

A skill for director-led work in Claude Code and Codex. Use one agent by default. Use a team when the job has independent parts and each handoff has a test.

## Use it

For solo work, invoke the skill and point the agent at the exact file or reference. For team work, copy [BOARD.md](team/templates/BOARD.md) to the project as `WORKBOARD.md` and add `Read WORKBOARD.md first.` to the project's `CLAUDE.md` or `AGENTS.md`. Give the director, manager and workers separate contact addresses on the board.

In Claude Code, invoke it with `/agent-team`. In Codex, say “use the agent-team skill.”

| Path | Contents |
|---|---|
| [SKILL.md](SKILL.md) | Mode selection and the solo workflow |
| [team/RULES.md](team/RULES.md) | Team workflow, from assignments to verified handoffs and merges |
| [team/templates/](team/templates/) | Board, brief, report, review, handoff and message forms |
| [scripts/team.py](scripts/team.py) | Git status, merge rehearsal and approved merges |
| [tests/](tests/README.md) | Fictional scenarios, runner and prior results |
| [docs/DESIGN.md](docs/DESIGN.md) | Design choices and sources |
| [docs/RULE-MAP.md](docs/RULE-MAP.md) | Where each previous rule went |

## Install

Clone once per machine. On macOS or Linux, link the clone into the tool you use.

```sh
git clone https://github.com/zegrt/agent-team.git ~/agent-team
mkdir -p ~/.claude/skills ~/.agents/skills
ln -s ~/agent-team ~/.claude/skills/agent-team   # Claude Code
ln -s ~/agent-team ~/.agents/skills/agent-team   # Codex
```

On Windows, use PowerShell. The junction target must be on a local drive.

```powershell
$clone = "C:\path\to\agent-team"
git clone https://github.com/zegrt/agent-team.git $clone
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills", "$HOME\.agents\skills" | Out-Null
New-Item -ItemType Junction -Path "$HOME\.claude\skills\agent-team" -Target $clone
New-Item -ItemType Junction -Path "$HOME\.agents\skills\agent-team" -Target $clone
```

The optional reminder tells agents to reread the instructions for their mode after a summary. Merge [Claude's hook settings](hooks/claude-settings.json) into `~/.claude/settings.json`, or [the Codex hook settings](hooks/codex-hooks.json) into `~/.codex/hooks.json` and enable `[features] hooks = true` in `~/.codex/config.toml`. Check that the hook fires in your tool. On Windows it needs Git Bash.

## Git commands for the manager

Run from the project's main worktree. Use `python` on Windows.

```sh
python3 ~/agent-team/scripts/team.py status
python3 ~/agent-team/scripts/team.py rehearse 12 -- npm test
python3 ~/agent-team/scripts/team.py merge 12
python3 ~/agent-team/scripts/team.py steps
```

The script leaves board edits to the manager. `merge` requires an approved row with the full tested task hash
and any approved review hash. Land Small tasks directly. Add project-specific protected branch patterns in the
manager's checkout with `git config --add agent-team.protectedBranch 'release/*'`.

## Changing the skill

File reusable process corrections in the [inbox](inbox/README.md). Put agent instructions in the skill or team rules and checkable fields in the forms. Keep the background in the [design notes](docs/DESIGN.md) and add a [scenario](tests/README.md) for changed behavior.

[MIT](LICENSE) · XERO WORKS PRIVATE LIMITED
