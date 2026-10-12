---
name: job-match
description: Score a pasted job ad against the candidate's CV out of 100, with evidence per requirement, gaps, and an honest apply-or-skip verdict.
---

# Job Match

Score the match between a pasted job ad and the candidate's CV. Be honest — a weak match must say so, even if the user seems keen.

## 1. Get the CV (first step, never skip)

- If the CV was already provided in this conversation, use it.
- Else look for `./CV.pdf`, `./cv.pdf`, `./CV.md`, or `./cv.md` in the working directory.
- Else STOP and ask the user for the CV (file path or pasted text). Never proceed without it.
- Gaps are marked `GAP`, never filled by invention.

## 2. Parse the ad

Extract: role, company, must-haves, nice-to-haves, domain, seniority, location/remote, language needs. Quote short ad phrases; never paraphrase requirements into easier versions.

## 3. Score (sum = 100)

One line of CV evidence or `GAP` per item:

- Core must-have stack/skills: /30
- Adjacent technical breadth: /15
- Ways of working (ownership, agile, cross-functional, enablement): /15
- Quality & governance mindset: /10
- Domain fit: /10
- Seniority fit: /10
- Location & language: /10

## 4. Output (short and scannable, no extra prose)

- One line: `Match: <total>/100 — <STRONG|SOLID|STRETCH|WEAK> — <Company>, <Role>`
- Table: `| Requirement (ad) | CV evidence or GAP |` — max 8 rows, ~12 words per cell. Merge minor nice-to-haves into one row.
- `Gaps:` max 3 bullets, one line each (gap + fix on the same line).
- `Verdict:` 1–2 sentences: apply or skip + the single strongest cover-letter angle.

Bands: 80+ STRONG (apply now), 60–79 SOLID (apply, address gaps), 40–59 STRETCH (apply only if motivated), below 40 WEAK (skip unless strategic).
