# Controller Harness - Bootstrap v2

> Based on Anthropic's [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) patterns and [Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) research.
> Skills: `/session-start` `/phase-loop` `/fix-phase` `/pm-requirements` `/delegate-code` `/triage-router` `/harness-system` `/initializer` `/state-persistence` `/auto-codify`
> Subagents: `backend-engineer` `code-reviewer` `requirements-analyst` `project-director` `experience-consolidator`

## Architecture

Controller Harness uses two of Anthropic's five workflow patterns:

| Pattern | How We Use It |
|---------|--------------|
| **Orchestrator-Workers** | Controller decomposes tasks, delegates to subagents, synthesizes results |
| **Evaluator-Optimizer** | Review (evaluator) → Fix Phase (optimizer) → retry loop |

Plus OpenAI's **Triage** pattern for routing tasks by type marker.

## Session Boundaries

### Every Session Start → run `/session-start`
Recovers state after context reset: read PROJECT_CONTEXT.json → check git log → run tests → identify next task.

### Every Session End → clean-state discipline
Commit with descriptive message, update PROJECT_CONTEXT.json, leave code mergeable.

### State Files → JSON always
Anthropic found JSON resists agent corruption better than Markdown.
- `docs/harness/PROJECT_CONTEXT.json` — phase state, last session, next tasks
- `docs/harness/features.json` — feature list with `passes` boolean (agents only flip false→true after verified testing)
- `reports/harness/error_memory.jsonl` — append-only error log

## Core Rules

- **NEVER implement code directly** — delegate [CODE]/[TEST]/Unmarked to `backend-engineer`
- Max 3 retries per phase, Fix Phase (Evaluator-Optimizer) before each retry
- Commit only after: all steps pass + tests green
- Project initialization: use `/initializer` to scaffold new projects
