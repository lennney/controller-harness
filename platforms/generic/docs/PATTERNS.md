# Controller Harness Patterns — Platform-Agnostic Reference

These 4 patterns form the core of Controller Harness. They are platform-agnostic — implement them using whatever mechanisms your AI coding tool provides.

---

## Pattern 1: Orchestrator-Workers

**Source**: [Anthropic — Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents)

### Concept
A central Controller (you or the main AI session) decomposes tasks and delegates to specialized workers. Workers don't coordinate with each other — the Controller synthesizes all results.

### Implementation
```
Main Session (Controller)
  ├── Backend Engineer (implements [CODE] tasks)
  ├── Code Reviewer (reviews implementations)
  ├── Requirements Analyst (converts plans to specs)
  ├── Project Director (creates plans)
  └── Experience Consolidator (extracts learnings)
```

### Rules
- Controller NEVER implements code directly for [CODE] tasks
- Workers get only the context they need (input filter)
- Controller synthesizes worker outputs into a coherent result
- Workers don't know about each other

### Platform Adaptation
- **Claude Code**: Native subagents in `.claude/agents/`
- **Codex/Cursor/Windsurf**: Separate sessions/threads with role prompts
- **Copilot**: Separate Chat threads
- **Generic**: Manual — you open new sessions for each worker role

---

## Pattern 2: Evaluator-Optimizer

**Source**: [Anthropic — Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents)

### Concept
After implementation, evaluate results. If they fail, analyze root cause, fix, and retry. This replaces simple "retry" with structured improvement.

### Implementation
```
IMPLEMENTATION → EVALUATION → pass? → DONE
                         ↓ fail
                    F1: Document Issue
                    F2: Root Cause Analysis
                    F3: Codify Pattern (create/update skill)
                    F4: Fix Plan
                    F5: Retry (max 3, then escalate)
                         ↓
                    IMPLEMENTATION (retry)
```

### Rules
- Max 3 retries per phase
- Each failure MUST be documented (not just retried)
- Root cause analysis before fix (not just symptom fix)
- Escalation after 3 failures (don't loop forever)

### Platform Adaptation
- All platforms: Manual process. Document failures in `error_memory.jsonl`
- Claude Code: `/fix-phase` skill automates this

---

## Pattern 3: Triage Router

**Source**: [OpenAI — Agents SDK](https://openai.github.io/openai-agents-python/handoffs/)

### Concept
Every task has a type marker. The marker determines which worker executes it. Like a mailroom sorting packages to the right department.

### Implementation
| Marker | Executor | Rationale |
|--------|----------|-----------|
| [CODE] | Backend Engineer | Code needs specialized implementation |
| [DOC] | Controller (self) | Documentation needs context awareness |
| [TEST] | Backend Engineer | Tests are code |
| [DATA] | Dispatched | Depends on data type |
| [AUTO] | Controller (self) | Automated checks |

Unmarked tasks = assume [CODE] (safer to delegate than to accidentally implement).

### Platform Adaptation
- All platforms: Prefix tasks with markers in task lists
- Claude Code: `/triage-router` skill routes automatically
- Others: Manual routing based on markers

---

## Pattern 4: Closed Learning Loop

**Source**: [Hermes Agent](https://github.com/NousResearch/hermes-agent)

### Concept
After every complex task, evaluate whether the workflow should be encoded as a reusable pattern. Skills self-improve over time.

### Implementation
After any multi-step task, ask 3 questions:
1. **Repeatable?** — Will this workflow recur?
2. **Non-obvious?** — Would a fresh AI make the same mistake?
3. **Needs constraints?** — Were specific tools/models/paths critical?

If YES to any → create or update a skill.

### Skill Format
```markdown
---
description: [What + When to use]
---
# [Skill Name]
## Trigger
[When to load this skill]

## Pattern
[Steps or rules, concise]

## Anti-Pattern
[What NOT to do]

## Source
Learned from: [where the pattern was discovered]
```

### Platform Adaptation
- Claude Code: `/auto-codify` skill + `experience-consolidator` subagent (fully automated)
- Others: Manual — maintain a `skills/` directory with markdown files

---

## Putting It All Together

A typical task flow uses all 4 patterns:

```
1. TASK COMES IN → Triage Router classifies it ([CODE], [DOC], etc.)
2. CONTROLLER DECOMPOSES → Orchestrator-Workers assigns to subagents
3. IMPLEMENTATION DONE → Evaluator-Optimizer reviews quality
4. REVIEW PASSES → Closed Learning Loop extracts patterns for next time
```

## State Management

All platforms should use JSON for state:
- `docs/harness/PROJECT_CONTEXT.json` — Current phase, session log, task queue
- `docs/harness/features.json` — Feature list with `passes` boolean
- `reports/harness/error_memory.jsonl` — Append-only error log

Why JSON? Anthropic found agents corrupt Markdown-based state more easily. JSON structure resists accidental mutation.

## Session Discipline

- **Every session start**: Read state → check git log → run tests → identify next task
- **Every session end**: Commit → update state → leave code mergeable
- **Never leave broken state**: If something fails, document it before ending session
