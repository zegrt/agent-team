#!/usr/bin/env python3
"""Agent-team Git commands. Run from the manager's main worktree.

  python3 <skill>/scripts/team.py status              task refs and board counts
  python3 <skill>/scripts/team.py rehearse <id> [-- <check command>]
                                                      test the task tip with latest main
  python3 <skill>/scripts/team.py merge <id>          land and clean up approved task and review commits
  python3 <skill>/scripts/team.py steps               show the manual steps

On Windows use python for python3. The manager edits WORKBOARD.md.
"""
from fnmatch import fnmatchcase
import os
import re
import subprocess
import sys
import tempfile

STEPS = """Merge steps (team.merge), one task at a time, only after the director approves:
1. Land Small tasks directly under team.merge.
2. On clean main: git pull --ff-only origin main
3. Rehearse the task tip in a detached worktree with latest main. Run the agreed checks.
   Preserve evidence before removing the worktree. Require target evidence before approval.
4. Compare both remote tips with the full approved hashes in the row. If a review is approved,
   check its Reviewed commit matches the task hash. If a tip moved: stop and get fresh approval.
5. Refuse protected task or review branches. Protect main, master, approved, the origin default,
   worker-* and every pattern set with git config --get-all agent-team.protectedBranch.
6. Merge the approved task hash and any approved review hash with git merge --no-ff.
   Push main. Run git branch -f approved main, then git push origin approved.
7. Delete only the merged task and review refs using a lease on each approved hash:
   git push --force-with-lease=refs/heads/<branch>:<hash> origin --delete refs/heads/<branch>
8. Mark the row merged with the date and merge commit."""

BOARD = "WORKBOARD.md"


def git(*args, check=True):
    r = subprocess.run(["git", *args], capture_output=True, text=True)
    if check and r.returncode != 0:
        sys.exit("git %s failed:\n%s" % (" ".join(args), r.stderr.strip()))
    return r


def board_rows(path=BOARD):
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


def line_count(path):
    try:
        with open(path, encoding="utf-8") as file:
            return sum(1 for _ in file)
    except FileNotFoundError:
        return 0


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
    rows = board_rows()
    merged = sum(bool(re.match(r"merged\b", clean(row.get("state", "")), re.I)) for row in rows)
    print(f"{BOARD}: {line_count(BOARD)} lines")
    print(f"DECISIONS.md: {line_count('DECISIONS.md')} lines")
    print(f"Merged rows still on the board: {merged}")
    if git("fetch", "-q", "--prune", "origin", check=False).returncode:
        print("Could not refresh origin. Ref status is local.", file=sys.stderr)
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
            ref = "origin/main" if remote_has("main") else "main"
            where = "main @ %s" % git("rev-parse", "--short", ref).stdout.strip()
        print("%s: %s · %s" % (tid, state, where))
    print("(scope done, e.g. \"3 of 6\", is yours to add from the report)")


def rehearse(task_id, check_cmd):
    branch = clean(find(task_id).get("branch", ""))
    git("fetch", "-q", "origin")
    task = remote_tip(branch)
    base = remote_tip("main")
    folder = tempfile.mkdtemp(prefix="agent-team-rehearse-")
    git("worktree", "add", "-q", "--detach", folder, task)
    print(f"Task commit: {task}. Main commit: {base}.", flush=True)
    before_check = task
    try:
        m = git("-C", folder, "merge", "--no-edit", base, check=False)
        if m.returncode != 0:
            print("Rehearsal FAILED: latest main does not merge cleanly into %s.\n%s" % (branch, m.stdout.strip()))
            git("-C", folder, "merge", "--abort", check=False)
            return 1
        before_check = git("-C", folder, "rev-parse", "HEAD").stdout.strip()
        if not check_cmd:
            print("Merged cleanly. No check given: rerun with -- <check command>.")
            return 0
        c = subprocess.run(check_cmd, cwd=folder, shell=True)
        print("Rehearsal %s: main merged into a copy of %s, check exit code %d." %
              ("passed" if c.returncode == 0 else "FAILED", branch, c.returncode))
        return c.returncode
    finally:
        changes = git("-C", folder, "status", "--porcelain", "--ignored").stdout
        head = git("-C", folder, "rev-parse", "HEAD").stdout.strip()
        if changes or head != before_check or git("worktree", "remove", folder, check=False).returncode:
            print(f"Rehearsal worktree kept at {folder}. Preserve any cited evidence before removing it.")


def remote_tip(branch):
    return git("rev-parse", "--verify", f"refs/remotes/origin/{branch}^{{commit}}").stdout.strip()


def verify_cleanup_branches(branches):
    remote_head = git("ls-remote", "--symref", "origin", "HEAD").stdout
    default = re.search(r"^ref: (refs/heads/\S+)\s+HEAD$", remote_head, re.M)
    configured = git("config", "--get-all", "agent-team.protectedBranch", check=False).stdout.splitlines()
    protected = ["main", "master", "approved", "HEAD", "worker-*", *configured]
    for branch in branches:
        if ((default and f"refs/heads/{branch}" == default[1])
                or any(fnmatchcase(branch, pattern) for pattern in protected)):
            sys.exit(f"Refusing to delete protected branch {branch}.")
        git("check-ref-format", f"refs/heads/{branch}")


def approved_tip(branch, expected):
    if not expected:
        sys.exit(f"Record the full approved commit for {branch}.")
    tip = remote_tip(branch)
    if tip != expected.lower():
        sys.exit(f"origin/{branch} does not match its approved commit. Check the tip and get fresh approval.")
    return tip


def merge(task_id):
    if git("branch", "--show-current").stdout.strip() != "main":
        sys.exit("Run this from the main folder, on main.")
    if git("status", "--porcelain").stdout.strip():
        sys.exit("The folder isn't clean. Stop and look before merging.")
    git("pull", "-q", "--ff-only", "origin", "main")
    git("fetch", "-q", "origin")
    row = find(task_id)
    task_id = clean(row["id"])
    branch = clean(row.get("branch", ""))
    state = clean(row.get("state", "")).lower()
    if clean(row.get("size", "")).lower() == "small":
        sys.exit(f"Land Small task {task_id} directly on main. See team.merge.")
    if not re.match(r"approved\b", state):
        sys.exit(f"Task {task_id} is '{state}' on the board. Only the director's approval opens a merge.")
    review = "review-" + task_id
    reviewed = clean(row.get("review commit", ""))
    review_required = clean(row.get("reviewer", "")).lower() not in ("", "-", "none")
    if reviewed in ("", "-") and review_required:
        sys.exit(f"Record the full review commit or approved waiver for {task_id}.")
    includes_review = reviewed.lower() not in ("", "-", "waived")
    if includes_review and branch == review:
        sys.exit("The task and review need separate branches.")
    verify_cleanup_branches([branch, review] if includes_review else [branch])
    approved = {branch: approved_tip(branch, clean(row.get("tested commit", "")))}
    if includes_review:
        review_tip = approved_tip(review, reviewed)
        review_path = f"reviews/{task_id}.md"
        changes = git("diff", "--name-only", f"main...{review_tip}").stdout.splitlines()
        if any(path != review_path for path in changes):
            sys.exit(f"Review {review} changes files outside {review_path}.")
        report = git("show", f"{review_tip}:{review_path}").stdout
        match = re.search(r"^Reviewed commit:[ \t]*`?([\da-f]+)`?[ \t]*$", report, re.I | re.M)
        if not match or match[1].lower() != approved[branch]:
            sys.exit(f"Review {review} does not cover the approved task commit.")
        approved[review] = review_tip
    git("merge", "-q", "--no-ff", "--no-edit", *approved.values())
    git("push", "-q", "origin", "main")
    git("branch", "-f", "approved", "main")
    git("push", "-q", "origin", "approved")
    refs = {f"refs/heads/{name}": tip for name, tip in approved.items()}
    leases = [f"--force-with-lease={ref}:{tip}" for ref, tip in refs.items()]
    cleanup = git("push", "-q", *leases, "origin", "--delete", *refs, check=False)
    head = git("rev-parse", "--short", "main").stdout.strip()
    print(f"Merged {task_id} at {head}. Mark the row merged with the date and commit.")
    if cleanup.returncode:
        print(f"Branch cleanup incomplete. Check the refs before retrying deletion.\n{cleanup.stderr.strip()}")
    return cleanup.returncode


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
