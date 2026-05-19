# Controller Harness for OpenAI Codex

Codex uses **rules files** and **custom instructions** to guide AI behavior. This adapter translates Controller Harness patterns into Codex-native formats.

## Setup

```bash
cp -r platforms/codex/.codex your-project/
```

## File Structure

```
your-project/
└── .codex/
    ├── rules/
    │   ├── controller-harness.md    # Core harness rules (always loaded)
    │   ├── delegate-code.md         # [CODE] delegation rule
    │   ├── fix-phase.md             # Evaluator-Optimizer pattern
    │   └── triage-router.md         # Task type routing
    └── instructions.md              # Custom instructions (always loaded)
```

## Pattern Mapping

| Controller Harness | Codex Equivalent |
|--------------------|------------------|
| `.claude/skills/` | `.codex/rules/` |
| `.claude/CLAUDE.md` | `.codex/instructions.md` |
| Subagents | Separate Codex sessions with role prompts |
| Hooks | Not available (use rules for guardrails) |
| JSON state | Same — `docs/harness/PROJECT_CONTEXT.json` |

## Key Differences

1. **No subagent system** — Codex doesn't have native subagents. Use separate sessions with role-specific custom instructions.
2. **No hooks** — Use rules as guardrails. State checks must be manual.
3. **Rules are flat** — Unlike Claude Code's directory-based skills, Codex rules are flat markdown files.
4. **Rules are always loaded** — They contribute to the system prompt for every request.

## Manual Subagent Simulation

To simulate subagent delegation in Codex:

1. Start a new session
2. Set custom instructions to the agent role (e.g., "You are a backend engineer...")
3. Give it the task
4. Review output in the main session

This matches the Orchestrator-Workers pattern: main session = Controller, sub-sessions = Workers.
