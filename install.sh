#!/usr/bin/env bash
# Install job-skills (Agent Skills standard) into AI coding tools.
# Usage:
#   ./install.sh                    # all global targets (Claude Code, Codex, OpenCode)
#   ./install.sh --claude           # ~/.claude/skills
#   ./install.sh --codex            # ~/.codex/skills
#   ./install.sh --opencode         # ~/.config/opencode/skills
#   ./install.sh --opencode-commands # ~/.config/opencode/commands (/job-coverletter, /job-match)
#   ./install.sh --cursor-dir DIR   # DIR/.agents/skills (Cursor project skills)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$REPO/skills"
COMMANDS_SRC="$REPO/opencode-commands"

usage() {
  sed -n '2,11p' "$0"
}

install_dir() {
  local dest="$1"
  mkdir -p "$dest"
  cp -r "$SKILLS_SRC/." "$dest/"
  echo "skills -> $dest"
}

DO_ALL=false
DO_COMMANDS=false
CURSOR_DIR=""
ARGS=0

for arg in "$@"; do
  case "$arg" in
    --claude)   install_dir "$HOME/.claude/skills"; ARGS=1 ;;
    --codex)    install_dir "$HOME/.codex/skills"; ARGS=1 ;;
    --opencode) install_dir "$HOME/.config/opencode/skills"; ARGS=1 ;;
    --opencode-commands)
      mkdir -p "$HOME/.config/opencode/commands"
      cp "$COMMANDS_SRC/"*.md "$HOME/.config/opencode/commands/"
      echo "commands -> $HOME/.config/opencode/commands"; ARGS=1 ;;
    --cursor-dir) echo "missing DIR for --cursor-dir" >&2; exit 1 ;;
    --cursor-dir=*) CURSOR_DIR="${arg#*=}"; ARGS=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown flag: $arg" >&2; usage; exit 1 ;;
  esac
done

# Support: --cursor-dir <space-separated> DIR
for i in "$@"; do
  if [ "$i" = "--cursor-dir" ]; then
    echo "use --cursor-dir=DIR (equals form)" >&2; exit 1
  fi
done

if [ -n "$CURSOR_DIR" ]; then
  mkdir -p "$CURSOR_DIR/.agents/skills"
  cp -r "$SKILLS_SRC/." "$CURSOR_DIR/.agents/skills/"
  echo "skills -> $CURSOR_DIR/.agents/skills"
fi

if [ "$ARGS" -eq 0 ]; then
  install_dir "$HOME/.claude/skills"
  install_dir "$HOME/.codex/skills"
  install_dir "$HOME/.config/opencode/skills"
fi

echo "done."
