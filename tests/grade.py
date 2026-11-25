import json, os, re, sys, subprocess, tempfile, glob, concurrent.futures as cf
E = os.path.dirname(os.path.abspath(__file__))
root = sys.argv[1]; scen_dirs = sys.argv[2:]
GRADERS = os.environ.get('GRADERS', 'claude codex').split()
def answer(path):
    if path.endswith('.json'):
        try: return json.load(open(path)).get('result','')
        except Exception as e: return ''
    return open(path).read()
def rubric(name):
    for d in scen_dirs:
        p = os.path.join(d, name + '.rubric.md')
        if os.path.exists(p): return open(p).read(), open(os.path.join(d, name + '.prompt.md')).read()
    return None, None
jobs = []
for arm_dir in sorted(glob.glob(os.path.join(root, '*'))):
    if not os.path.isdir(arm_dir): continue
    for f in sorted(glob.glob(os.path.join(arm_dir, '*.json')) + glob.glob(os.path.join(arm_dir, '*.txt'))):
        name = os.path.basename(f).rsplit('-', 1)[0]
        rb, pr = rubric(name)
        if rb: jobs += [(os.path.basename(arm_dir), name, f, rb, pr, gr) for gr in GRADERS]
CARDS = (
    r"`?\b(board\.one-source|task\.(size|change)|build\.check|review\.(risk|assess|restart)"
    r"|decide\.escalate|team\.(start|spec|board|worktree|unreachable|live-first|manager|size|merge|status))\b`?"
)
SKILL_PATHS = (
    r"(?<![\w/])(?:the )?(?:\.{1,2}/)*(?:/?(?:[~\w.<>-]+/)*agent-team/|<skill>/)?"
    r"(?:SKILL\.md|(?:team/)?RULES\.md|(?:team/)?templates(?:/[\w-]+\.md|/)?|scripts/team\.py|team/)"
    r"(?![\w/])"
)
def blind(ans):
    # Hide identifiers from both layouts before replacing the skill name.
    ans = re.sub(CARDS, "", ans)
    ans = re.sub(SKILL_PATHS, "the team rules", ans, flags=re.I)
    return re.sub(r"(?i)(the )?agent-team( skill)?|the skill('s)?", "the team rules", ans)
def ask(grader, prompt):
    if grader == 'claude':
        r = subprocess.run(['claude','-p',prompt,'--no-session-persistence','--output-format','json','--tools',''], capture_output=True, text=True, cwd='/tmp', stdin=subprocess.DEVNULL)
        return json.loads(r.stdout)['result']
    with tempfile.TemporaryDirectory() as d:
        out = os.path.join(d, 'o.txt')
        subprocess.run(['codex','exec','--ephemeral','--skip-git-repo-check','--sandbox','read-only','-C',d,'-o',out,prompt], capture_output=True, text=True, stdin=subprocess.DEVNULL)
        return open(out).read()
def grade(job):
    arm, name, f, rb, pr, grader = job
    ans = blind(answer(f))
    if not ans.strip(): return dict(arm=arm, scen=name, file=f, score=None, reason='empty answer')
    prompt = f"""You grade one agent's answer against a rubric. You don't know which setup produced it.
SCENARIO GIVEN TO THE AGENT:
{pr}
RUBRIC:
{rb}
AGENT'S ANSWER:
{ans}
Reply with only JSON: {{"score": 0|1|2, "reason": "<one sentence>", "quote": "<the agent's own words that most decided the score, max 40 words>"}}"""
    try:
        txt = ask(grader, prompt); txt = txt[txt.find('{'):txt.rfind('}')+1]; g = json.loads(txt)
    except Exception as e:
        g = dict(score=None, reason='grader error: %s' % e, quote='')
    g.update(arm=arm, scen=name, file=f, grader=grader); return g
with cf.ThreadPoolExecutor(8) as ex: res = list(ex.map(grade, jobs))
json.dump(res, open(os.path.join(root, 'grades.json'), 'w'), indent=1)
from collections import defaultdict
t = defaultdict(list)
for g in res: t[(g['scen'], g['arm'], g['grader'])].append(g['score'])
for k in sorted(t):
    v = [x for x in t[k] if x is not None]
    print(k[0].ljust(24), k[1].ljust(14), k[2].ljust(7), t[k], 'mean %.1f' % (sum(v)/len(v)) if v else '')
