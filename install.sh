#!/usr/bin/env bash
# install.sh — Universal skill installer for Claude Code, Antigravity (AGY), Codex, and custom projects
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect skill directories (inside skills/)
SKILL_DIRS=()
while IFS= read -r dir; do
  if [ -f "$SCRIPT_DIR/skills/$dir/SKILL.md" ]; then
    SKILL_DIRS+=("$dir")
  fi
done < <(find "$SCRIPT_DIR/skills" -maxdepth 1 -mindepth 1 -type d ! -name ".*" -exec basename {} \; | sort)

print_help() {
  cat <<EOF
Usage: ./install.sh [OPTIONS]

Install and configure skills for Claude Code, Antigravity (AGY), Codex, and project repositories.

Options:
  --all                 Install/link skills globally for all detected AI agents
  --agy                 Install/link skills to Antigravity global config (~/.gemini/config/skills)
  --claude              Install/link skills to Claude Code global config (~/.claude/skills)
  --project <DIR>       Install/link skills into a target project repository (.agents/skills & .claude/skills)
  --copy                Copy files instead of symlinking (default is symbolic links)
  -h, --help            Show this help message

Examples:
  ./install.sh --all                        # Set up globally for both AGY and Claude Code
  ./install.sh --agy                        # Set up globally for Antigravity only
  ./install.sh --claude                     # Set up globally for Claude Code only
  ./install.sh --project /path/to/my-repo   # Mount skills inside a specific project
EOF
}

MODE="link"
TARGET_PROJECT=""
INSTALL_AGY=false
INSTALL_CLAUDE=false

if [ $# -eq 0 ]; then
  print_help
  exit 0
fi

while [ $# -gt 0 ]; do
  case "$1" in
    --all)
      INSTALL_AGY=true
      INSTALL_CLAUDE=true
      shift
      ;;
    --agy)
      INSTALL_AGY=true
      shift
      ;;
    --claude)
      INSTALL_CLAUDE=true
      shift
      ;;
    --copy)
      MODE="copy"
      shift
      ;;
    --project)
      if [ -z "${2:-}" ]; then
        echo "Error: --project requires a directory path argument." >&2
        exit 1
      fi
      TARGET_PROJECT="$2"
      shift 2
      ;;
    -h|--help)
      print_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      print_help
      exit 1
      ;;
  esac
done

install_skills_to_dir() {
  local dest_dir="$1"
  local label="$2"

  echo "==> Installing ${#SKILL_DIRS[@]} skills to $label ($dest_dir)..."
  mkdir -p "$dest_dir"

  for skill in "${SKILL_DIRS[@]}"; do
    local src="$SCRIPT_DIR/skills/$skill"
    local dst="$dest_dir/$skill"

    if [ "$MODE" = "copy" ]; then
      rm -rf "$dst"
      cp -R "$src" "$dst"
    else
      # Symbolic link
      ln -sfn "$src" "$dst"
    fi
  done
  echo "    Done."
}

# 1. Antigravity Global
if [ "$INSTALL_AGY" = true ]; then
  install_skills_to_dir "$HOME/.gemini/config/skills" "Antigravity Global"
fi

# 2. Claude Code Global
if [ "$INSTALL_CLAUDE" = true ]; then
  install_skills_to_dir "$HOME/.claude/skills" "Claude Code Global"
fi

# 3. Target Project
if [ -n "$TARGET_PROJECT" ]; then
  if [ ! -d "$TARGET_PROJECT" ]; then
    echo "Error: Target directory '$TARGET_PROJECT' does not exist." >&2
    exit 1
  fi
  install_skills_to_dir "$TARGET_PROJECT/.agents/skills" "Project (Antigravity/AGY/Codex)"
  install_skills_to_dir "$TARGET_PROJECT/.claude/skills" "Project (Claude Code)"
fi

echo ""
echo "Installation completed successfully!"
EOF
