# Inbox: corrections from projects

Every rule in this skill started as a director's correction on a real project. This folder is how new ones get in.

**What belongs here:** a correction about how the team works that would hold on any project, with any director.
Craft, taste and project-only rules belong elsewhere: the project's own docs, the director's profile, or the
project's board.

## From a project that uses the skill

1. The manager who hears the correction writes it on its own board first, as a dated decision. It takes effect there
   at once, because the board outranks the skill.
2. If it is general, that manager adds one new file here, named `<date>-<project>-<short-name>.md`, with:
   - the date and the director's words;
   - where it happened (project, task, what went wrong);
   - which card or template field it should change, or "new".

   New files only, so two managers never edit the same file.
3. Only the skill's own maintainer edits `SKILL.md`, `RULES.md` and the templates, after its director approves. It
   tests the change first (see the README's "Changing the rules"), then deletes the inbox file and tells the
   projects to pull.
4. Once the skill holds the rule, each project deletes its own board line, or keeps it as a tightening if it needs
   more.

A correction that is half team process and half something else is split, and each half filed where it belongs.

## From anyone else

Open a [GitHub issue](https://github.com/zegrt/agent-team/issues) with the same three things: what happened, what
the director said, and which rule it touches. A pull request is welcome too; a new rule needs a test scenario
showing agents get it wrong without it.
