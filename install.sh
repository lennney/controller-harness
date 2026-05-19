#!/bin/bash
# Controller Harness Installer
# Installs skills, agents, and hooks into a Claude Code project.
#
# Usage:
#   ./install.sh                    Install to current directory
#   ./install.sh /path/to/project   Install to specified project
#   ./install.sh --global           Install to global Claude Code config

set -e

TARGET="${1:-.}"

if [[ "$TARGET" == "--global" ]]; then
    TARGET="$HOME"
    echo "Installing Controller Harness globally to $TARGET/.claude/"
fi

# Resolve to absolute path
TARGET="$(cd "$TARGET" 2>/dev/null && pwd || echo "$TARGET")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Controller Harness v2.0.0 Installer"
echo "==================================="
echo "Source : $SCRIPT_DIR"
echo "Target : $TARGET"
echo ""

# Create .claude directories
mkdir -p "$TARGET/.claude/skills"
mkdir -p "$TARGET/.claude/agents"

# --- Install Skills ---
echo "Installing skills..."
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    skill_name="$(basename "$skill_dir")"
    if [[ -f "$skill_dir/SKILL.md" ]]; then
        rm -rf "$TARGET/.claude/skills/$skill_name"
        cp -r "$skill_dir" "$TARGET/.claude/skills/$skill_name"
        echo "  [OK] $skill_name"
    fi
done

# --- Install Main Skill ---
if [[ -f "$SCRIPT_DIR/SKILL.md" ]]; then
    rm -rf "$TARGET/.claude/skills/controller-harness"
    mkdir -p "$TARGET/.claude/skills/controller-harness"
    cp "$SCRIPT_DIR/SKILL.md" "$TARGET/.claude/skills/controller-harness/SKILL.md"
    echo "  [OK] controller-harness (main)"
fi

# --- Install Agents ---
echo "Installing agents..."
for agent_file in "$SCRIPT_DIR/agents"/*.md; do
    agent_name="$(basename "$agent_file")"
    cp "$agent_file" "$TARGET/.claude/agents/$agent_name"
    echo "  [OK] $agent_name"
done

# --- Install Hooks ---
echo ""
if [[ -f "$SCRIPT_DIR/hooks/settings.json" ]]; then
    echo "Hook configuration available at: $SCRIPT_DIR/hooks/settings.json"
    echo "To enable hooks, merge the content into your .claude/settings.json"
    echo "See README.md for hook configuration details."
fi

# --- Install Templates ---
if [[ -d "$SCRIPT_DIR/templates" ]]; then
    mkdir -p "$TARGET/.claude"
    if [[ ! -f "$TARGET/.claude/CLAUDE.md" ]]; then
        cp "$SCRIPT_DIR/templates/claude.md" "$TARGET/.claude/CLAUDE.md"
        echo "  [OK] CLAUDE.md template (no existing file)"
    else
        echo "  [~]  Skipped CLAUDE.md (already exists)"
    fi
fi

echo ""
echo "Done! Controller Harness installed."
echo ""
echo "Installed skills:"
ls "$TARGET/.claude/skills/" 2>/dev/null || echo "  (none)"
echo ""
echo "Installed agents:"
ls "$TARGET/.claude/agents/" 2>/dev/null || echo "  (none)"
echo ""
echo "To verify, start a new Claude Code session and run: /session-start"
