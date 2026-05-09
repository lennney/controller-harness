# Controller Harness - Bootstrap Entry

## Project Overview

Controller Harness is a reusable AI orchestration system that provides a 7-step phase execution workflow with subagent delegation and skill codification.

## Quick Start

1. Run `./scripts/install.sh --global` to install globally
2. See `docs/PHASE_LOOP.md` for the core workflow
3. See `skills/TEMPLATE.md` to create skill entries

## Key Concepts

### 7-Step Phase Loop

| Step | Name | Role |
|------|------|------|
| 1 | PLANNER | Create step-by-step plan |
| 2 | REQUIREMENTS | Convert to specific requirements |
| 3 | IMPLEMENTATION | Execute (delegate to subagent for [CODE]) |
| 4 | REVIEW | Verify against requirements |
| 5 | DOC REVIEW | Verify documentation |
| 6 | EXPERIENCE | Extract learnings, codify skills |
| 7 | COORDINATION | Commit+push or Fix Phase |

### Task Type Markers

All tasks MUST have a type marker:
- [CODE] - Code implementation (delegate to subagent)
- [DOC] - Documentation-only (Controller executes)
- [DATA] - Data files
- [TEST] - Adding/updating tests
- [AUTO] - Automated verification

### Fix Phase (on failure)

F1: Issue Documentation -> F2: Root Cause Analysis -> F3: Skill Codification -> F4: Fix Plan -> F5: Retry Decision

Max 3 retries per phase before escalation.

## Key Files

| File | Purpose |
|------|---------|
| docs/PHASE_LOOP.md | 7-step workflow definition |
| docs/PROJECT_CONTEXT.md | State tracking template |
| docs/CONTROLLER_HARNESS_PRACTICE.md | Core principles |
| skills/TEMPLATE.md | Skill entry template |
| skills/*.md | Reusable skill entries |
| templates/claude.md | Bootstrap CLAUDE.md template |
