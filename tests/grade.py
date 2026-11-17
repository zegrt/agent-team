import json, os, sys, subprocess, glob, random, concurrent.futures as cf
E = os.path.dirname(os.path.abspath(__file__))
root = sys.argv[1]; scen_dirs = sys.argv[2:]
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
        if rb: jobs.append((os.path.basename(arm_dir), name, f, rb, pr))
def grade(job):
    arm, name, f, rb, pr = job
    ans = answer(f)
    if not ans.strip(): return dict(arm=arm, scen=name, file=f, score=None, reason='empty answer')
    prompt = f"""You grade one agent's answer against a rubric. You don't know which setup produced it.
SCENARIO GIVEN TO THE AGENT:
{pr}
RUBRIC:
{rb}
AGENT'S ANSWER:
{ans}
Reply with only JSON: {{"score": 0|1|2, "reason": "<one sentence>", "quote": "<the agent's own words that most decided the score, max 40 words>"}}"""
    r = subprocess.run(['claude','-p',prompt,'--no-session-persistence','--output-format','json','--tools',''], capture_output=True, text=True, cwd='/tmp')
    try:
        txt = json.loads(r.stdout)['result']; txt = txt[txt.find('{'):txt.rfind('}')+1]; g = json.loads(txt)
    except Exception as e:
        g = dict(score=None, reason='grader error', quote=r.stdout[-200:])
    g.update(arm=arm, scen=name, file=f); return g
with cf.ThreadPoolExecutor(8) as ex: res = list(ex.map(grade, jobs))
json.dump(res, open(os.path.join(root, 'grades.json'), 'w'), indent=1)
from collections import defaultdict
t = defaultdict(list)
for g in res: t[(g['scen'], g['arm'])].append(g['score'])
for k in sorted(t): print(k[0].ljust(24), k[1].ljust(14), t[k])
