# Controller Harness — GitHub Copilot Instructions

> These instructions encode the Controller Harness patterns for GitHub Copilot.
> Keep this file under 200 lines — Copilot has context limits.

## Core Rules

### [CODE] Delegation
**NEVER implement code directly for tasks marked [CODE] or unmarked tasks.**
- [CODE] tasks: delegate implementation to a separate Copilot Chat thread with this prompt: "You are a backend engineer. Implement the following: ..."
- Unmarked tasks: assume [CODE] (safety default)
- [DOC], [AUTO]: you may handle directly

### Task Type Markers
| Marker | Executor | Behavior |
|--------|----------|----------|
| [CODE] | Delegate | Start new chat with engineer context |
| [DOC] | Self | Write/edit documentation directly |
| [TEST] | Delegate | Start new chat with test context |
| [DATA] | Self | Edit data files directly |
| [AUTO] | Self | Automated checks |

### State Management
- Read `docs/harness/PROJECT_CONTEXT.json` at the start of each task session to recover state
- Update it at the end of each task session
- Use `docs/harness/features.json` with `passes: true/false` — only flip false→true after verified testing
- JSON > Markdown for state files (resists corruption)

### 7-Step Loop (Condensed)
1. **PLANNER** — Decompose task into steps with acceptance criteria
2. **REQUIREMENTS** — Convert steps to specific requirements
3. **IMPLEMENTATION** — Execute (delegate [CODE] to separate chat)
4. **REVIEW** — Verify implementation against requirements
5. **DOC REVIEW** — Check documentation is accurate
6. **EXPERIENCE** — Extract learnings, document reusable patterns
7. **COORDINATION** — Commit OR enter fix phase

### Fix Phase (Evaluator-Optimizer)
When review fails:
1. Document the issue
2. Analyze root cause
3. Codify as a pattern (save to `docs/harness/skills/`)
4. Create a fix plan
5. Retry (max 3, then escalate)

### Session Boundaries
- **Start**: Read PROJECT_CONTEXT.json → check git log → identify next task
- **End**: Commit clean code → update PROJECT_CONTEXT.json → leave mergeable state

### JSON State File Format
```json
// docs/harness/PROJECT_CONTEXT.json
{
  "current_phase": "1",
  "phase_name": "Feature setup",
  "status": "in_progress",
  "last_session": "2026-05-19T10:00:00Z",
  "next_tasks": ["1.1 [CODE] Initialize module", "1.2 [DOC] Update README"],
  "completed_tasks": [],
  "error_count": 0,
  "retry_count": 0
}
```

## When NOT to Use These Patterns
- Single-file fixes (just do it)
- Exploratory/prototype work (flexibility > structure)
- Pure Q&A (no code to write)
