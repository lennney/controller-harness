---
phase: master-system
change: controller-harness-system
last_updated: 2026-05-08
owner: controller
---

# Skill: Controller Harness System (Master Skill)

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | skill_controller_harness_system |
| **Version** | 1.0.0 |
| **Created** | 2026-05-08 |
| **Last Updated** | 2026-05-08 |
| **Author** | Controller (auto-generated) |
| **Status** | active |
| **Type** | Master Skill (points to other skills) |

## Classification

| Field | Value |
|-------|-------|
| **Domain** | workflow |
| **Pattern Type** | best_practice |
| **Complexity** | complex (system-level) |

# System Architecture Diagram

See docs/PHASE_LOOP.md for the 7-step workflow diagram.

# File Structure

Your project using Controller Harness should have:

```
<your-project>/
docs/harness/                              # Controller harness docs
  CONTROLLER_HARNESS_PRACTICE.md         # Core principles
  PROJECT_CONTEXT.md                     # Current state tracking
  PHASE_LOOP.md                          # 7-step workflow definition
  skills/                                # Reusable skill entries

subagent_results/                          # Phase execution artifacts
  {phase}_plan.md
  {phase}_requirements.md
  {phase}_implementation.md
  {phase}_review.md
  {phase}_doc_review.md
  {phase}_experience.md

reports/harness/                            # Error memory and playbooks
  error_memory.jsonl                     # Real-time error logging
  repair_playbook.md                      # Categorized repair procedures
  compression_handoff.md                   # Context compression handling

openspec/                                   # OpenSpec state anchor (if using OpenSpec)
  changes/
    {active-change}/
      tasks.md                       # Task tracking
      design.md                      # Architecture decisions
      repair_entry.md                # Error tracking per change
  specs/

AGENTS.md                                  # Core rules and constraints
```

# Subagent Role Mapping

| Phase Step | Subagent Type | When to Use |
|------------|--------------|-------------|
| **1 - PLANNER** | project-director | Create step-by-step plans with acceptance criteria |
| **2 - REQUIREMENTS ANALYSIS** | general-purpose | Convert plans to detailed requirements with field definitions |
| **3 - IMPLEMENTATION** | backend-engineer | Write code, refactor, module changes ([CODE] tasks) |
| **4 - REVIEW** | code-reviewer | Verify implementation against requirements |
| **5 - DOC REVIEW** | code-reviewer | Verify documentation accuracy and completeness |
| **6 - EXPERIENCE CONSOLIDATION** | general-purpose | Extract learnings, codify patterns |
| **Fix Phase** | system-architect | Workflow design, escalation handling |

### Delegation Rules

| Task Type | Who Executes | Controller Role |
|-----------|--------------|-----------------|
| [CODE] | backend-engineer subagent | Orchestrate + review (NEVER self) |
| [DOC] | Controller (self) | Execute directly |
| [DATA/TEST] | Dispatch appropriately | Orchestrate or execute |

### Output File Naming Convention

subagent_results/{phase}_{step}.md

Examples:
  phase1.1_plan.md           (Step 1: Planner)
  phase1.1_requirements.md    (Step 2: Requirements)
  phase1.1_implementation.md  (Step 3: Implementation)
  phase1.1_review.md          (Step 4: Review)
  phase1.1_doc_review.md      (Step 5: Doc Review)
  phase1.1_experience.md      (Step 6: Experience)

Handoff Protocol:
  1. Before: Check subagent status
  2. During: Monitor for context compression
  3. After: Read result file, verify completeness

# 7-Step Phase Loop Process Flow

See docs/PHASE_LOOP.md for detailed process flow.

### Fix Phase (on Review/Doc Failure)

When Step 4 or 5 fails:

| Sub-step | Action | Output |
|----------|--------|--------|
| F1 | Issue Documentation | Record findings with evidence |
| F2 | Root Cause Analysis | Determine WHY failure occurred |
| F3 | Skill Codification | Create/update skill if new pattern |
| F4 | Fix Plan | Create specific fix guidance |
| F5 | Retry Decision | Loop back (max 3) or escalate |

**Max Retries**: 3 total per phase
**Escalation Trigger**: After 3rd retry failure

# Shared Information Locations

| File | Purpose | Update Frequency | TTL |
|------|---------|------------------|-----|
| docs/harness/PROJECT_CONTEXT.md | Current phase, tasks, next actions | Every phase transition | 7 days |
| docs/harness/PHASE_LOOP.md | 7-step workflow definition | When process changes | Permanent |
| reports/harness/error_memory.jsonl | Real-time error logging | On every error | Review weekly |
| reports/harness/repair_playbook.md | Categorized repair procedures | On new error patterns | Permanent |
| reports/harness/compression_handoff.md | Context compression handling | When compression occurs | Permanent |
| skills/*.md | Reusable skill entries | On new patterns | Permanent |
| subagent_results/*.md | Phase execution artifacts | Every phase step | Delete after phase done |
| openspec/changes/{active}/tasks.md | Task tracking | Every task state change | Until phase complete |

# Quick Start Checklist

## Session Start
- [ ] Read openspec/changes/{active}/tasks.md - confirm current task state
- [ ] Read docs/harness/PROJECT_CONTEXT.md - understand current phase
- [ ] Check reports/harness/error_memory.jsonl - any P1 errors?
- [ ] Review AGENTS.md if needed - core constraints

## Phase Execution
- [ ] Identify phase from tasks.md
- [ ] Execute Step 1 (Planner) -> output: subagent_results/{phase}_plan.md
- [ ] Execute Step 2 (Requirements) -> output: subagent_results/{phase}_requirements.md
- [ ] Execute Step 3 (Implementation) -> output: subagent_results/{phase}_implementation.md
- [ ] Execute Step 4 (Review) -> output: subagent_results/{phase}_review.md
- [ ] If Review FAILS -> Enter Fix Phase (F1-F5) -> max 3 retries
- [ ] Execute Step 5 (Doc Review) -> output: subagent_results/{phase}_doc_review.md
- [ ] If Doc Review FAILS -> Enter Fix Phase (F1-F5) -> max 3 retries
- [ ] Execute Step 6 (Experience) -> output: subagent_results/{phase}_experience.md
- [ ] Execute Step 7 (Controller Coordination) -> commit+push or next phase

## Phase Complete
- [ ] All 7 steps PASS
- [ ] Update docs/harness/PROJECT_CONTEXT.md
- [ ] Update openspec/changes/{active}/tasks.md
- [ ] Commit and push changes
- [ ] Clean up subagent_results/ if desired

# Core Principles

1. **OpenSpec is the only state anchor** - Do not create parallel documents
2. **Error management feeds OpenSpec** - Errors are input layer for state
3. **Main window compression recovery** - Use file records to restore context
4. **All agents share the same file system** - Consistent information access
5. **Controller NEVER implements code directly** - Always delegate [CODE] tasks
6. **Task type markers are mandatory** - [CODE]/[DOC]/[DATA]/[TEST]/[AUTO]
7. **Unmarked tasks default to [CODE]** - Safer delegation path
8. **Fix Phase before escalation** - 3 retries before giving up

# Related Skills

| Skill ID | Relationship | Purpose |
|----------|--------------|---------|
| skill_workflow_phase_loop | parent | Detailed 7-step workflow |
| skill_workflow_subagent_delegation | depends_on | Delegation rules for [CODE] tasks |
| skill_requirements_pm_style | depends_on | PM-style requirements template |

# Related Files

| File | Purpose |
|------|---------|
| docs/PHASE_LOOP.md | 7-step workflow definition |
| docs/PROJECT_CONTEXT.md | Current state tracking |
| docs/CONTROLLER_HARNESS_PRACTICE.md | Core principles |
| skills/TEMPLATE.md | Skill entry template |

# Changelog

| Version | Date | Change |
|---------|------|--------|
| 1.0.0 | 2026-05-08 | Initial creation - comprehensive master skill |
