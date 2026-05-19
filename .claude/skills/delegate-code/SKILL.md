---
description: Rules for delegating code tasks to subagents. Controller never implements code directly — always dispatch [CODE] tasks to backend-engineer subagent. Use when executing implementation steps or deciding task delegation strategy.
paths: "**/*.py,**/*.ts,**/*.js,**/*.rs,**/*.go,**/*.java"
---

# Subagent Delegation for Code Tasks

## Core Rule

**CONTROLLER NEVER IMPLEMENTS CODE DIRECTLY.**

For [CODE] tasks: ALWAYS dispatch to `backend-engineer` subagent.
Controller role = Orchestrate + Review + Approve.
Controller NEVER = Implement + Write code.

## Delegation Matrix

| Task Type | Executor | Controller Role |
|-----------|----------|-----------------|
| [CODE] | backend-engineer subagent | Orchestrate + review |
| [DOC] | Controller (self) | Execute directly |
| [TEST] | backend-engineer subagent | Orchestrate + verify |
| [DATA] | Dispatch appropriately | Orchestrate or execute |
| [AUTO] | Controller (self) | Execute + report |

## Subagent Dispatch

For [CODE] tasks, create a self-contained prompt with:
- Reference to subagent_results/{task_id}_requirements.md
- Explicit output path: subagent_results/{task_id}_result.md
- Acceptance criteria from requirements

## Verification
- subagent_results/{task_id}_result.md must exist after delegation
- Controller reviews output, never writes implementation code
- If subagent result is incomplete, return for revision (not self-edit)
