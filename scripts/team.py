#!/usr/bin/env python3
"""agent-team chores, so they run the same way every time. Standard library only; Mac and Windows.

Run from the project's main folder (the manager's, on main), with the board at WORKBOARD.md:

  python3 <skill>/scripts/team.py status              every task: state, branch @ hash, report, review
  python3 <skill>/scripts/team.py rehearse <id> [-- <check command>]
                                                      merge latest main into a throwaway copy of the
                                                      task branch, run the check, clean up
  python3 <skill>/scripts/team.py merge <id>          only when the board row says approved: merge the
                                                      task and any review-<id> into main, push, move
                                                      `approved`, delete the merged branches
  python3 <skill>/scripts/team.py steps               print the merge steps, to do by hand if this
                                                      script can't run

On Windows use `python` for `python3`. Nothing here edits the board: the manager does, after.
"""
import os
import re
import subprocess
import sys
import tempfile

STEPS = """Merge steps (team.merge), one task at a time, only after the director approves:
1. In the main folder, on main and clean: git pull --ff-only
2. Rehearse: git worktree add -b rehearse-<id> ../<project>-rehearse-<id> origin/<branch>
   then in it: git merge origin/main, run the brief's checks; then git worktree remove that folder and
   git branch -D rehearse-<id>. Never check out or move the builder's branch.
3. git merge --no-ff origin/<branch>. If the review branch exists: git merge --no-ff origin/review-<id>
4. git push origin main; git branch -f approved main; git push origin approved
5. git push origin --delete <branch>. If the review branch exists: git push origin --delete review-<id>.
   Never delete a worker-<name> branch.
6. On the board: the row's State to merged (date), with the merge commit."""


def git(*args, check=True):
    r = subprocess.run(["git", *args], capture_output=True, text=True)
    if check and r.returncode != 0:
        sys.exit("git %s failed:\n%s" % (" ".join(args), r.stderr.strip()))
    return r


def board_rows(path="WORKBOARD.md"):
    if not os.path.exists(path):
        sys.exit("No WORKBOARD.md here. Run from the project's main folder.")
    rows, header, in_tasks = [], None, False
    for line in open(path, encoding="utf-8"):
        if line.startswith("## "):
            in_tasks = line.strip().lower() == "## tasks"
            header = None
            continue
        if not in_tasks or not line.strip().startswith("|"):
            continue
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        if header is None:
            header = [c.lower() for c in cells]
        elif not set("".join(cells)) <= set("-: "):
            rows.append(dict(zip(header, cells)))
    return rows


def clean(cell):
    return cell.strip().strip("`").strip()


def remote_has(ref):
    return git("rev-parse", "--verify", "--quiet", "origin/" + ref, check=False).returncode == 0


def file_on(ref, path):
    return git("cat-file", "-e", "origin/%s:%s" % (ref, path), check=False).returncode == 0


def find(task_id):
    for r in board_rows():
        if r.get("id", "").lower() == task_id.lower():
            return r
    sys.exit("No task %s on the board." % task_id)


def status():
    git("fetch", "-q", "--prune", "origin")
    rows = board_rows()
    if not rows:
        print("No tasks on the board.")
    for r in rows:
        tid, branch, state = r.get("id", "?"), clean(r.get("branch", "")), r.get("state", "?")
        where = "no branch"
        if branch and branch not in ("-", "main"):
            if remote_has(branch):
                where = "%s @ %s" % (branch, git("rev-parse", "--short", "origin/" + branch).stdout.strip())
                where += " · report: %s" % ("yes" if file_on(branch, "reports/%s.md" % tid) else "no")
            else:
                where = "%s (not on origin)" % branch
            review = "review-" + tid
            where += " · review: %s" % ("yes" if remote_has(review) else "no")
        elif branch == "main":
            where = "main @ %s" % git("rev-parse", "--short", "origin/main").stdout.strip()
        print("%s: %s · %s" % (tid, state, where))
    print("(scope done, e.g. \"3 of 6\", is yours to add from the report)")


def rehearse(task_id, check_cmd):
    branch = clean(find(task_id).get("branch", ""))
    git("fetch", "-q", "origin")
    if not remote_has(branch):
        sys.exit("origin/%s not found." % branch)
    name = "rehearse-" + task_id
    folder = os.path.join(tempfile.gettempdir(), "%s-%s" % (os.path.basename(os.getcwd()), name))
    git("worktree", "add", "-q", "-b", name, folder, "origin/" + branch)
    try:
        m = subprocess.run(["git", "-C", folder, "merge", "--no-edit", "origin/main"], capture_output=True, text=True)
        if m.returncode != 0:
            print("Rehearsal FAILED: latest main does not merge cleanly into %s.\n%s" % (branch, m.stdout.strip()))
            subprocess.run(["git", "-C", folder, "merge", "--abort"], capture_output=True)
            return 1
        if not check_cmd:
            print("Merged cleanly. No check given: rerun with -- <check command>.")
            return 0
        c = subprocess.run(check_cmd, cwd=folder, shell=True)
        print("Rehearsal %s: main merged into a copy of %s, check exit code %d." %
              ("passed" if c.returncode == 0 else "FAILED", branch, c.returncode))
        return c.returncode
    finally:
        git("worktree", "remove", "--force", folder, check=False)
        git("branch", "-D", name, check=False)


def merge(task_id):
    row = find(task_id)
    branch, state = clean(row.get("branch", "")), row.get("state", "").lower()
    if not state.startswith("approved"):
        sys.exit("Task %s is '%s' on the board, not approved. Only the director's approval opens a merge." % (task_id, state))
    if git("branch", "--show-current").stdout.strip() != "main":
        sys.exit("Run this from the main folder, on main.")
    if git("status", "--porcelain").stdout.strip():
        sys.exit("The folder isn't clean. Stop and look before merging.")
    git("pull", "-q", "--ff-only")
    if not remote_has(branch):
        sys.exit("origin/%s not found." % branch)
    git("merge", "-q", "--no-ff", "--no-edit", "origin/" + branch)
    review = "review-" + task_id
    if remote_has(review):
        git("merge", "-q", "--no-ff", "--no-edit", "origin/" + review)
    git("push", "-q", "origin", "main")
    git("branch", "-f", "approved", "main")
    git("push", "-q", "origin", "approved")
    gone = [b for b in (branch, review) if remote_has(b)]
    if gone:
        git("push", "-q", "origin", "--delete", *gone)
    head = git("rev-parse", "--short", "main").stdout.strip()
    print("Merged %s at %s; approved moved; deleted %s." % (task_id, head, ", ".join(gone) or "nothing"))
    print("Now on the board: %s State -> merged (date), commit %s." % (task_id, head))
    return 0


def main(argv):
    if not argv or argv[0] in ("-h", "--help"):
        print(__doc__)
        return 0
    cmd = argv[0]
    if cmd == "status":
        return status() or 0
    if cmd == "steps":
        print(STEPS)
        return 0
    if cmd in ("rehearse", "merge") and len(argv) >= 2:
        if cmd == "merge":
            return merge(argv[1])
        rest = argv[2:]
        check_cmd = " ".join(rest[1:]) if rest[:1] == ["--"] else ""
        return rehearse(argv[1], check_cmd)
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
