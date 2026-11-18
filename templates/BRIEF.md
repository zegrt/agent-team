# Brief <id>: <task>

<!-- For Content and Design tasks. Saved as briefs/<id>.md and linked from the task row. Under about a page.
     Why: a builder knows only what the brief says; the manager's conversation doesn't carry over.
     Basis: Anthropic, multi-agent research (objective, output, tools, boundaries); the director, 9 Nov 2026 (the board,
     not messages, carries the work). -->

Size: <Content | Design>   <!-- stated so the director can overrule it; see task.size -->
Board commit: <hash>  <!-- the board version this brief was cut from; the builder repeats it in the report.
                           Basis: Superpowers (record the base commit before dispatch) -->
Branch: <branch>      <!-- work in your own worktree on this branch; check it before every commit.
                           Basis: the director, 17 Nov 2026 (a commit landed on the wrong branch) -->

## Objective
<!-- What the task is for, in one or two lines. -->

## Output
<!-- What the builder hands back, and in what form. -->

## Tools and sources
<!-- What to use and read. Basis for these three: Anthropic, multi-agent research. -->

## Files
<!-- Only these. A file changed outside this list is named in the report, with why.
     Basis: the director, 9 Nov 2026 (each task names the files it touches); BMAD #2563. -->

## Done when
<!-- The checks, settled before work starts. Basis: Anthropic, harness design ("before any code was written"). -->

## Out of scope
<!-- Anything else you notice goes in the report under Noticed. Tests and checks are never edited to pass.
     Basis: Anthropic, long-running harnesses ("unacceptable to remove or edit tests"). -->

<!-- The builder's report goes in reports/<id>.md (templates/REPORT.md), on the task branch, so the reviewer
     can read the brief without the builder's account. Basis: blind review, 18 Nov 2026. -->
