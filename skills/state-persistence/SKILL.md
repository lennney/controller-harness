---
description: Manage project state persistence across sessions. Use JSON for state files (resists agent corruption better than Markdown), structured handoff summaries, and clean-state discipline at session boundaries. Based on Anthropic's harness state management findings.
---

# State Persistence Patterns

Based on [Anthropic's research on effective harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents).

## State File Format: JSON Always

Anthropic found that agents are less likely to corrupt JSON than Markdown. Use JSON for:
- `docs/harness/PROJECT_CONTEXT.json` — current phase, active change, next tasks
- `docs/harness/features.json` — feature list with `passes` boolean
- `reports/harness/error_memory.jsonl` — append-only error log

## PROJECT_CONTEXT.json Schema

```json
{
  "phase": {
    "current": "phase_id",
    "status": "in_progress | complete",
    "retry_count": 0
  },
  "active_change": "openspec_change_id",
  "last_session": {
    "ended": "ISO8601",
    "commits": ["hash1", "hash2"],
    "test_status": "passing | failing",
    "left_clean": true
  },
  "next_tasks": [
    {"id": "T-001", "type": "[CODE]", "description": "...", "priority": "high"}
  ]
}
```

## Clean-State Discipline

At every session boundary:
1. All tests must pass
2. No broken WIP features left in main branch
3. Code must be "appropriate for merging" — well-documented, orderly, no debugging artifacts
4. Git commit with descriptive message
5. Update PROJECT_CONTEXT.json with session results

## Handoff Summary Format

When a session ends, write to `reports/harness/handoff_{date}.md`:
- What was accomplished this session
- What's in progress (not yet done)
- Known issues discovered
- Recommended next task
