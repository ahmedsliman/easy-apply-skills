# easy-apply-skills

Two portable [Agent Skills](https://agentskills.io) (open `SKILL.md` standard, no personal data inside):

- `job-coverletter` — turn a pasted job ad into a tailored cover letter, saved as Markdown + PDF (strictly 1 page A4) in `./CoverLetters/`, using your CV as the only source of facts.
- `job-match` — score a pasted job ad against your CV out of 100, with evidence, gaps, and an honest apply-or-skip verdict.

Both skills ask for your CV on first use if they can't find one (`./CV.pdf`, `./cv.pdf`, `./CV.md`, `./cv.md`, or pasted). Nothing is ever invented.

## Install

One command (needs [Node](https://nodejs.org), works on Windows, macOS, Linux):

```sh
npx github:ahmedsliman/easy-apply-skills
```

Options — same for the Node installer, `./install.sh`, and `node bin/install.js`:

| Flag | Installs to |
|---|---|
| *(none)* | all three tools below |
| `--claude` | `~/.claude/skills` |
| `--codex` | `~/.codex/skills` |
| `--opencode` | `~/.config/opencode/skills` |
| `--opencode-commands` | `~/.config/opencode/commands` (`/job-coverletter`, `/job-match`) |
| `--cursor-dir=PATH` | `PATH/.agents/skills` (Cursor project skills) |

From a clone: `./install.sh [flags]` (macOS/Linux; Windows: Git Bash) or `node bin/install.js [flags]` (any OS).

Manual install: copy `skills/job-coverletter` and `skills/job-match` into the tool's skills folder:

| Tool | Skills folder |
|---|---|
| Claude Code | `~/.claude/skills/` (personal) or `.claude/skills/` (project) |
| Codex CLI | `~/.codex/skills/` (personal) or `.codex/skills/` (project) |
| OpenCode | `~/.config/opencode/skills/` (global) or `.opencode/skills/` (project) |
| Cursor | `<project>/.agents/skills/` |

## Use

- Claude Code / Codex / Cursor: ask e.g. *"use the job-match skill for this ad: <paste>"* — or let the agent pick it up automatically.
- OpenCode: same via the skill, or `/job-coverletter <paste ad>` / `/job-match <paste ad>` if you installed `--opencode-commands`.

## Uninstall

Delete the `job-coverletter` / `job-match` folders from the skills folder above (and the two `.md` files from `~/.config/opencode/commands/` if installed).
