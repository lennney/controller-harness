---
description: Controller Harness — AI orchestration system with 7-step phase loop, subagent delegation, and autonomous skill creation. Use for complex multi-step features or when the user says "start phase", "run controller harness", or delegates work to backend-engineer/code-reviewer subagents.
context: fork
---

# Controller Harness v2

Orchestration system based on proven patterns from Anthropic, OpenAI, and Hermes Agent.

## Architecture

| Pattern | Source | How We Use It |
|---------|--------|---------------|
| **Orchestrator-Workers** | Anthropic | Controller decomposes tasks, delegates to subagents |
| **Evaluator-Optimizer** | Anthropic | Review → Fix Phase → retry loop (max 3) |
| **Triage Router** | OpenAI | Task type markers route to correct subagent |
| **Closed Learning Loop** | Hermes Agent | Auto-detect patterns → create/refine skills |

## Core Rules

- **NEVER implement code directly** — delegate [CODE]/[TEST]/Unmarked to `backend-engineer` subagent
- Max 3 retries per phase, Fix Phase before each retry
- Commit only after: all steps pass + tests green
- Session start → run `/session-start` ritual
- Session end → clean-state discipline (commit, update state, leave mergeable)

## Task Type Markers

| Marker | Executed By | Behavior |
|--------|-------------|----------|
| `[CODE]` | backend-engineer subagent | Code implementation |
| `[DOC]` | Controller (self) | Documentation |
| `[TEST]` | backend-engineer subagent | Test code |
| `[DATA]` | Dispatched as needed | Data files |
| `[AUTO]` | Controller (self) | Automated checks |
| Unmarked | backend-engineer subagent | Assume [CODE] |

## 7-Step Phase Loop

```
[1] PLANNER      → project-director subagent → plan + acceptance criteria
[2] REQUIREMENTS → requirements-analyst subagent → spec
[3] IMPLEMENTATION → backend-engineer subagent (NEVER Controller for [CODE])
[4] REVIEW       → code-reviewer subagent → pass/fail
[5] DOC REVIEW   → Controller → doc accuracy check
[6] EXPERIENCE   → experience-consolidator subagent → learnings + auto-codify
[7] COORDINATION → Controller → commit or enter Fix Phase
```

## Fix Phase (Evaluator-Optimizer)

```
Review fails → F1: Issue → F2: Root Cause → F3: Codify → F4: Plan → F5: Retry (max 3)
```

## Subagents

| Agent | Model | Role |
|-------|-------|------|
| backend-engineer | sonnet | Code implementation (ALL [CODE] tasks) |
| code-reviewer | sonnet | Review against requirements |
| requirements-analyst | sonnet | Convert plans to specs |
| project-director | sonnet | Create step-by-step plans |
| experience-consolidator | haiku | Extract learnings, auto-create skills |

## State Files

- `docs/harness/PROJECT_CONTEXT.json` — Phase state, session log, task queue
- `docs/harness/features.json` — Feature list with `passes` boolean
- `reports/harness/error_memory.jsonl` — Append-only error log

JSON over Markdown for state — Anthropic found it resists agent corruption.

## Skills Reference

This package includes 9 skills. See `skills/` directory for full details:

| Skill | Purpose |
|-------|---------|
| `/session-start` | State recovery at session start |
| `/initializer` | Project scaffolding + JSON feature list |
| `/phase-loop` | 7-step execution with quality gates |
| `/fix-phase` | Systematic failure recovery (F1-F5) |
| `/delegate-code` | Enforce [CODE] delegation |
| `/triage-router` | Task type → correct subagent |
| `/pm-requirements` | PM-style requirements template |
| `/state-persistence` | JSON state patterns, clean-state |
| `/auto-codify` | Autonomous skill creation (Hermes loop) |
| `/controller-harness` | System overview (this skill — installed from SKILL.md) |

See each skill's SKILL.md in `skills/<name>/` for full documentation.
