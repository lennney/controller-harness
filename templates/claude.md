# Controller Harness - Bootstrap

## Controller Harness System

This project uses a **Controller Harness** — an AI orchestration system based on Anthropic's [Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) and [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) patterns.

### Mode 1: Direct Development (Default)
Standard code changes, tests, and documentation.

### Mode 2: Controller Mode (Long-running phases)
For complex multi-step features. Enter by saying "start phase N" or "run controller harness."

**Controller Mode reads these files (in order):**
1. `docs/harness/PROJECT_CONTEXT.json` — Current phase and state (JSON format)
2. `docs/harness/features.json` — Feature list with verified `passes` boolean
3. `docs/harness/PHASE_LOOP.md` — 7-step workflow definition
4. `.claude/skills/` — Reusable skill entries

**Controller Mode rules:**
- Never implement code directly — always delegate [CODE]/[TEST] to `backend-engineer` subagent
- Use task type markers: [CODE]/[DOC]/[DATA]/[TEST]/[AUTO]; unmarked = assume [CODE]
- Commit after: subagent success + module tests green
- Max 3 retries per phase, Fix Phase (Evaluator-Optimizer) before retry
- **Session start**: run `/session-start` ritual — read state, check git log, run tests
- **Session end**: clean-state discipline — commit, update PROJECT_CONTEXT.json, leave mergeable

**Quick reference for Controller Mode:**
```
Skills:         /session-start  /phase-loop  /fix-phase  /pm-requirements
                /delegate-code  /triage-router  /initializer  /state-persistence
Subagents:      backend-engineer  code-reviewer  requirements-analyst
                project-director  experience-consolidator
State file:     docs/harness/PROJECT_CONTEXT.json
Error log:      reports/harness/error_memory.jsonl
Phase output:   subagent_results/
```

## 7-Step Phase Loop

| Step | Name | Subagent/Executor |
|------|------|-------------------|
| 1 | PLANNER | project-director subagent |
| 2 | REQUIREMENTS | requirements-analyst subagent |
| 3 | IMPLEMENTATION | backend-engineer subagent (NEVER Controller for [CODE]) |
| 4 | REVIEW | code-reviewer subagent |
| 5 | DOC REVIEW | Controller |
| 6 | EXPERIENCE | experience-consolidator subagent (Haiku) |
| 7 | COORDINATION | Controller — commit or enter Fix Phase |

**Fix Phase** (Evaluator-Optimizer): F1-Issue → F2-Root Cause → F3-Codify → F4-Plan → F5-Retry (max 3)

## Task Type Markers (Triage Routing)

| Marker | Executed By |
|--------|-------------|
| [CODE] | backend-engineer subagent |
| [DOC] | Controller (self) |
| [DATA] | Dispatch as needed |
| [TEST] | backend-engineer subagent |
| [AUTO] | Controller (self) |

Unmarked = assume [CODE] (safer: always delegate).
