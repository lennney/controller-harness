---
description: Route incoming tasks to the correct execution path based on task type markers. [CODE] → backend-engineer, [DOC] → Controller, [TEST] → backend-engineer, [DATA] → dispatch, [AUTO] → Controller. Unmarked → assume [CODE]. Based on OpenAI's triage agent pattern.
---

# Triage Router — Task Type Classification

Based on OpenAI's [triage pattern](https://openai.github.io/openai-agents-python/handoffs/) where a central agent routes to specialists based on input classification.

## Routing Table

| Task Type | Route To | Reason |
|-----------|----------|--------|
| `[CODE]` | `backend-engineer` subagent | Code must be delegated, never Controller |
| `[DOC]` | Controller (self) | Documentation changes only |
| `[TEST]` | `backend-engineer` subagent | Tests change code, must be delegated |
| `[DATA]` | Dispatch as needed | Data files may need code or direct edits |
| `[AUTO]` | Controller (self) | Automated verification, no implementation |
| *Unmarked* | `backend-engineer` subagent | Safer: err on delegation side |

## Triage Decision Flow

```
Task arrives → Check marker →
  [CODE]/[TEST]/Unmarked → Spawn backend-engineer subagent
  [DOC]/[AUTO]           → Controller executes directly
  [DATA]                 → Evaluate: code changes needed? → route accordingly
```

## Subagent Dispatch Protocol

When routing to a subagent, provide a **self-contained prompt** with:
1. Link to requirements spec: `subagent_results/{task_id}_requirements.md`
2. Explicit output path: `subagent_results/{task_id}_result.md`
3. Acceptance criteria from the requirements
4. The subagent type name (e.g., `backend-engineer`)

Do NOT include the full conversation history — the subagent doesn't need it and it wastes context.
