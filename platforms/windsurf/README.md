# Controller Harness for Windsurf

Windsurf uses **`.windsurf/rules/`** for AI behavior guidelines. This adapter translates Controller Harness patterns.

## Setup

```bash
cp -r platforms/windsurf/.windsurf your-project/
```

## File Structure

```
your-project/
└── .windsurf/
    └── rules/
        ├── controller-harness.md     # Core harness rules
        ├── delegate-code.md          # [CODE] delegation
        └── triage-router.md          # Task type routing
```

## Pattern Mapping

| Controller Harness | Windsurf Equivalent |
|--------------------|---------------------|
| `.claude/skills/` | `.windsurf/rules/` |
| `.claude/CLAUDE.md` | `.windsurfrules` (root file) |
| Subagents | Cascade mode with role context |
| Hooks | Not available |
| JSON state | Same — `docs/harness/PROJECT_CONTEXT.json` |

## Key Differences

1. **Cascade mode** — Windsurf's Cascade can be given role-specific context, similar to subagents. Start a new Cascade with the agent's system prompt.
2. **Flat rules** — Like Codex, rules are flat files.
3. **No session tracking** — Maintain state manually via `docs/harness/PROJECT_CONTEXT.json`.

## Cascade-as-Subagent Pattern

To simulate subagent delegation:

1. Start a new Cascade
2. Set context: "You are a backend engineer. Implement the following..."
3. Paste the task
4. Review output in the main session
