---
description: Execute complex development tasks using a 7-step phase loop with evaluator-optimizer pattern for quality gates. Based on Anthropic's agent workflow patterns (Orchestrator-Workers + Evaluator-Optimizer) and OpenAI's handoff-based multi-agent architecture.
---

# 7-Step Phase Loop (Enhanced)

Based on Anthropic's [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) workflow patterns and OpenAI's [Agents SDK](https://github.com/openai/openai-agents-python) handoff patterns.

## Architecture: Orchestrator-Workers + Evaluator-Optimizer

This combines two of Anthropic's five workflow patterns:
- **Orchestrator-Workers**: Controller (orchestrator) dynamically delegates to subagents (workers)
- **Evaluator-Optimizer**: Review steps (evaluator) feed back into Fix Phase (optimizer)

## Phase Execution

### Step 1 — PLANNER (Controller or project-director subagent)
- Read `docs/harness/PROJECT_CONTEXT.json` and tasks.md
- Produce numbered steps with acceptance criteria
- Identify task type: [CODE]/[DOC]/[DATA]/[TEST]/[AUTO]
- Output: `subagent_results/{phase}_plan.md`

### Step 2 — REQUIREMENTS (requirements-analyst subagent)
- Convert plan to PM-style spec with field definitions, API signatures, edge cases
- See `/pm-requirements` for the full template
- Output: `subagent_results/{phase}_requirements.md`

### Step 3 — IMPLEMENTATION
**[CODE]/[TEST]/Unmarked** → Delegate to `backend-engineer` subagent (NEVER Controller self)
**[DOC]/[AUTO]** → Controller executes directly
**[DATA]** → Evaluate and dispatch
- Output: `subagent_results/{task_id}_result.md`

### Step 4 — REVIEW (code-reviewer subagent) ⬅ Evaluator
- Verify implementation against ALL requirements from Step 2
- Check edge cases, security, consistency, regression
- Output: `subagent_results/{task_id}_review.md` — PASS or FAIL with line numbers

### Step 5 — DOC REVIEW (Controller)
- Verify docs match implementation
- Check boundary wording in portfolio-facing docs
- Output: PASS or FAIL

### Step 6 — EXPERIENCE (experience-consolidator subagent)
- Check skills/ for related patterns
- If new error pattern → create skill entry
- If known pattern → update with new learnings
- Output: `subagent_results/{phase}_experience.md`

### Step 7 — COORDINATION (Controller)
- All pass → commit + push + update PROJECT_CONTEXT.json
- Review/Doc fail → **enter Fix Phase** (Evaluator-Optimizer loop)

## Fix Phase: Evaluator-Optimizer Loop

```
REVIEW (evaluator) → FAIL → F1: Document issue
                                F2: Root cause analysis
                                F3: Codify skill (if new pattern)
                                F4: Fix plan
                                F5: Retry (max 3)
                                ↓
                          BACK TO STEP 3 (optimized implementation)
                                ↓
                          REVIEW again (evaluator checks again)
```

This is Anthropic's evaluator-optimizer pattern: the review step evaluates, the fix phase optimizes, and the loop repeats until quality passes or escalation triggers.

## Triage Routing (OpenAI Pattern)

Task type markers act as a triage router:
- [CODE]/[TEST]/Unmarked → `backend-engineer` subagent (safer: always delegate)
- [DOC]/[AUTO] → Controller executes directly
- [DATA] → Evaluate: does it need code? Route accordingly

## Session Boundaries

- **Start**: Run `/session-start` ritual (recover state, verify project works)
- **End**: Commit with descriptive message, update PROJECT_CONTEXT.json, leave clean state
