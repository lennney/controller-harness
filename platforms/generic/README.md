# Controller Harness — Generic / Universal

This is the platform-agnostic version. Point any AI coding tool to `docs/harness/` as context and follow the patterns manually.

## Setup

```bash
cp -r platforms/generic/docs your-project/docs/harness/
```

## File Structure

```
your-project/
└── docs/harness/
    ├── README.md                # This file — overview
    ├── PATTERNS.md              # The 4 architecture patterns explained
    ├── PHASE_LOOP.md            # 7-step workflow (detailed)
    ├── TASK_MARKERS.md          # Task type marker system
    ├── FIX_PHASE.md             # Evaluator-Optimizer recovery flow
    └── SKILL_SYSTEM.md          # Skill creation from experience
```

## The 4 Patterns (Platform-Agnostic)

### 1. Orchestrator-Workers
You (Controller) decompose tasks and delegate to specialized workers.
Workers never coordinate with each other — you synthesize results.

### 2. Evaluator-Optimizer
After implementation: evaluate → if fail, analyze root cause → fix → retry.
Max 3 retries, then escalate.

### 3. Triage Router
Every task has a type marker: [CODE], [DOC], [TEST], [DATA], [AUTO].
Marker determines who executes. Unmarked = assume [CODE].

### 4. Closed Learning Loop
After complex tasks: was it repeatable? Non-obvious? Did it need specific constraints?
If yes → document as a reusable pattern (skill).

## Manual Workflow

Since generic platforms don't have native skill/agent support:

1. **Read** `docs/harness/PATTERNS.md` at session start
2. **Check** `docs/harness/PROJECT_CONTEXT.json` for current state
3. **Follow** the 7-step loop manually
4. **Delegate** by starting new sessions with role prompts
5. **Review** against requirements
6. **Record** errors in `error_memory.jsonl`
7. **Update** state at session end

## JSON State Files

Create these manually (or use the initializer skill on Claude Code):

- `docs/harness/PROJECT_CONTEXT.json` — Current phase, session log, task queue
- `docs/harness/features.json` — Feature list with `passes` boolean
- `reports/harness/error_memory.jsonl` — Append-only error log

Templates are in `.claude/skills/state-persistence/`.
