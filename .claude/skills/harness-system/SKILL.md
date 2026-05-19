---
description: Controller Harness system overview — architecture, subagent mapping, file layout, and core patterns (Orchestrator-Workers + Evaluator-Optimizer + Triage). Use for understanding the harness or as session context reference.
---

# Controller Harness System v2

## Architecture: Three Anthropic Patterns + One OpenAI Pattern + One Hermes Pattern

| Pattern | Source | Implementation |
|---------|--------|---------------|
| **Orchestrator-Workers** | [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) | Controller dynamically decomposes tasks, delegates to subagents |
| **Evaluator-Optimizer** | [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) | Review → Fix Phase → retry loop |
| **Triage Router** | [OpenAI](https://openai.github.io/openai-agents-python/handoffs/) | Task type markers route to correct subagent |
| **Closed Learning Loop** | [Hermes Agent](https://github.com/NousResearch/hermes-agent) | Auto-detect patterns → create/refine skills from experience |

## Key Design Principle: Freedom + Constraints

Give the model agentic freedom within hard constraints:
- **Freedom**: agents choose HOW to implement, decompose tasks, use tools
- **Constraints**: JSON state files resist corruption, `passes` boolean prevents premature done, session boundaries enforce clean state, [CODE] delegation is non-negotiable

## Session Lifecycle (from Anthropic's Effective Harnesses)

```
SESSION START              SESSION BODY              SESSION END
     │                          │                         │
/initializer (first)      /phase-loop             git commit
     │                    /triage-router          update JSON state
/session-start            /fix-phase              leave clean state
(every session)           /pm-requirements
                          delegate to subagents
```

Key findings from Anthropic's harness research:
- **JSON > Markdown** for state files (agents corrupt Markdown more easily)
- **Feature list with `passes` boolean** prevents premature "done" declarations
- **Run tests at session start** catches broken state from previous session
- **Clean-state discipline**: every session ends with mergeable code

## Subagent Mapping

| Phase Step | Subagent | Model |
|-----------|----------|-------|
| 1 - Planner | project-director | sonnet |
| 2 - Requirements | requirements-analyst | sonnet |
| 3 - Implementation | backend-engineer | sonnet |
| 4 - Review | code-reviewer | sonnet |
| 5 - Doc Review | Controller (self) | — |
| 6 - Experience | experience-consolidator | haiku |
| 6a - Auto-Codify | experience-consolidator (automatic) | haiku |
| Fix Phase | Controller (self) | — |

## Key Skills

| Skill | Source Pattern | Purpose |
|-------|---------------|---------|
| `/session-start` | Anthropic Harness | State recovery + verification at session start |
| `/initializer` | Anthropic Two-Agent | Project scaffolding with JSON feature list |
| `/phase-loop` | Anthropic Orchestrator+Evaluator | 7-step execution with quality gates |
| `/fix-phase` | Anthropic Evaluator-Optimizer | Systematic failure recovery |
| `/delegate-code` | Anthropic Subagent | [CODE] must be delegated |
| `/triage-router` | OpenAI Triage | Task type → correct subagent |
| `/auto-codify` | Hermes Learning Loop | Autonomous skill creation from experience |
| `/state-persistence` | Anthropic Harness | JSON state, clean-state discipline |

## Key Files

| File | Format | Purpose |
|------|--------|---------|
| `docs/harness/PROJECT_CONTEXT.json` | JSON | Phase state, session log, task queue |
| `docs/harness/features.json` | JSON | Feature list with verified `passes` |
| `docs/harness/PHASE_LOOP.md` | Markdown | Full workflow reference |
| `reports/harness/error_memory.jsonl` | JSONL | Structured error log |
| `subagent_results/` | Markdown | Temporary phase artifacts |
