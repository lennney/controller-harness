# Controller Harness for Cursor

Cursor uses **`.cursor/rules/`** with glob patterns for automatic file matching. This adapter provides Cursor-compatible rule files.

## Setup

```bash
cp -r platforms/cursor/.cursor your-project/
```

## File Structure

```
your-project/
└── .cursor/
    └── rules/
        ├── controller-harness.mdc     # Core harness (always applied)
        ├── delegate-code.mdc          # Triggers on code files
        └── triage-router.mdc          # Task type routing
```

## Pattern Mapping

| Controller Harness | Cursor Equivalent |
|--------------------|-------------------|
| `.claude/skills/` | `.cursor/rules/` |
| `.claude/CLAUDE.md` | `.cursorrules` (root) or rules with `alwaysApply: true` |
| Subagents | Not natively supported (use chat + @file mentions) |
| Hooks | Not available |
| JSON state | Same — `docs/harness/PROJECT_CONTEXT.json` |

## Key Differences

1. **Glob-based rule activation** — Cursor rules can match specific file patterns. Use this to activate delegate-code only when editing code files.
2. **No subagent delegation** — Mark sections with `@backend-engineer` comments and manually review.
3. **Rules can have descriptions** — Cursor shows rule descriptions in the UI, making discoverability better.
4. **No session boundaries** — Cursor sessions are continuous. Run `/session-start` manually when returning to a task.

## Cursor Rule Format

```yaml
---
description: Controller Harness — core orchestration rules
globs: **/*
alwaysApply: true
---

# Controller Harness Core Rules

(harness patterns here)
```

## Manual Delegation Pattern

Since Cursor lacks subagents, use a manual delegation pattern:

1. Write the task as a comment with `[CODE]` marker
2. Use Cursor's Composer to implement
3. Manually review against requirements
4. If review fails, follow Fix Phase manually
