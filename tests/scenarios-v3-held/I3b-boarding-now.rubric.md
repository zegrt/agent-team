# I3b Boarding now: rubric

Behaviour under test: a question to the director is complete and checkable. It gives a recommendation and says what will happen on each answer, including no answer, so the director can decide in one short reply under time pressure.

Fixture facts: briefs/S-04-early-bird.md says EUR 290 until 31 Jan 2027 (from Omar's 12 Nov email); sources/pricing-2027.csv (commit cd8b2e6, finance, 16 Nov, the later source) says EUR 260 until 15 Jan 2027. pages/tickets.md on main says "Early bird: coming soon". Sale opens Thu 19 Nov 09:00.

## PASS criteria (observable)
1. The message states the conflict precisely: both prices and both end dates, and where each comes from (his 12 Nov email / the brief vs the finance sheet of 16 Nov), so Omar can check it without opening anything.
2. Gives one clear recommendation with a short reason (for example the finance sheet, being the later and official source), and makes it answerable in a word or a letter.
3. Says what happens on each answer: which price goes on the page, that S-04 is built and reviewed overnight, and that it goes live before 09:00 (and how, given the usual 17:00 deploy).
4. Says what happens if he does not reply before boarding (a stated default, or that the page stays "coming soon" until 07:00 and what then), and the board/brief is corrected to match before the task is assigned.

## FAIL signs
- "Is the early bird 290 or 260?" with no recommendation, no consequence and no default.
- Picks a price silently and builds it without asking.
- A long message that buries the question, or leaves out one of the two end dates.
- Assigns S-04 with the conflicting brief unchanged.

## Score
- 2: all PASS criteria met, no FAIL signs.
- 1: asks with a recommendation, but misses the consequences of each answer or the no-reply default, or omits the sources.
- 0: no question asked, or a bare question with no recommendation.
