---
description: Fix phase workflow using the evaluator-optimizer pattern. After review failure: document issue → root cause analysis → codify skill → create fix plan → retry (max 3) or escalate. Based on Anthropic's evaluator-optimizer agent pattern.
paths: "subagent_results/*_review.md"
---

# Fix Phase — Evaluator-Optimizer Pattern

Based on Anthropic's [evaluator-optimizer workflow pattern](https://www.anthropic.com/engineering/building-effective-agents): one agent evaluates output, another optimizes it, looping until quality passes.

## Evaluator-Optimizer Loop

```
REVIEW (Evaluator)        FIX PHASE (Optimizer)
     │                          │
     │ FAIL with issues ───────►│ F1: Document issue
     │                          │ F2: Root cause analysis
     │                          │ F3: Codify pattern (if new)
     │                          │ F4: Create fix plan
     │                          │ F5: Retry decision
     │                          │
     │◄── back to STEP 3 ──────│ (optimized implementation)
     │                          │
     │ PASS ──────────────────►│ proceed to step 5
```

## 5-Step Fix Process

| Step | Action | Key Question |
|------|--------|-------------|
| F1 | Document issue with line numbers + evidence | WHAT failed? |
| F2 | Root cause analysis | WHY did it fail? |
| F3 | Check skills/ for existing pattern; create if new | Is this reusable? |
| F4 | Create specific fix instructions for implementation | HOW to fix it? |
| F5 | Retry (max 3) or escalate | Try again or escalate? |

## Rules

- Max 3 retries per phase — after 3rd failure, escalate to human
- Always enter Fix Phase before retry (never skip to direct retry)
- Codify new error patterns into `skills/` using `skills/TEMPLATE.md` (project root)
- Trivial issues (typos, formatting) can skip Fix Phase

## Escalation Format

```
## Escalation Report
**Phase**: [id] | **Task Type**: [marker] | **Retries**: 3

### What Was Tried
1. Attempt 1: [approach]
2. Attempt 2: [approach]  
3. Attempt 3: [approach]

### What Failed
- [specific failure with evidence]

### Root Cause
[why the implementation keeps failing]

### Options
1. [Option A] — pros/cons
2. [Option B] — pros/cons

### Recommendation
[Controller's recommended path]
```
