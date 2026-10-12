---
name: job-coverletter
description: Write a tailored cover letter PDF (strictly 1 page A4) from a pasted job ad, using the candidate's CV as the only source of facts.
---

# Job Cover Letter

Turn a pasted job ad into a tailored cover letter, saved as Markdown + PDF in `./CoverLetters/`.

## 1. Get the CV (first step, never skip)

- If the CV was already provided in this conversation, use it.
- Else look for `./CV.pdf`, `./cv.pdf`, `./CV.md`, or `./cv.md` in the working directory.
- Else STOP and ask the user for the CV (file path or pasted text). Never proceed without it.
- The CV is the only source of facts. Never claim tools, years, or domains not in it. Adjacent experience is phrased as a fast ramp-up from proven experience, never as mastery.

## 2. Parse the job ad

Extract: company, role title, must-haves, nice-to-haves, domain, seniority, location/remote setup, ad language. Quote short ad phrases when mapping; never soften requirements.

## 3. Setup

- Company slug: ASCII, no spaces (e.g. `Acme-Corp`). Fallback: `General`.
- Header/footer facts (name, city, email, profile links) come from the CV.
- Letter language matches the ad (German ad → German letter, English ad → English letter). Keep sentences short and simple.
- Filenames: `./CoverLetters/<First>-<Last>-CoverLetter-<Company>.md` and `.pdf` (`mkdir -p` first). Name parts come from the CV.

## 4. Draft (~250–330 words)

- Hook: responsibility + real impact, no empty phrases.
- 4–5 bullets mapping CV evidence to ad requirements.
- One paragraph: why this company (only facts stated in the ad).
- One paragraph: terms (CV city as base; remote/onsite per the ad).
- Language-availability line only with user-confirmed levels; if unknown, ask one question instead of guessing.

## 5. Generate the PDF

Python + reportlab (`pip install reportlab` if missing). A4; margins 22/22/16/15 mm; Helvetica throughout: name title 20pt bold `#1E3A5F`, one-line profile 7.8pt bold `#2A6496`, contact line 7.6pt gray, 1.8pt navy rule, right-aligned date 9pt gray, subject 10.5pt bold navy + reference line 9pt gray, body 9.8pt/14.2 justified `#222222`, `•` bullets, closing + bold navy signature, centered 7.2pt gray footer (name • city • email • main profile link). Set PDF title/author metadata.

## 6. Verify

`pdfinfo` must report exactly 1 page. If 2: cut ~15–20% of text and/or drop body to 9.3pt/12.8, then regenerate. Spot-check special characters with `pdftotext`.

## 7. Report (short)

Paths, page count, detected company/role/language, and 3 bullets on how the letter maps to the ad.
