---
description: JSON project state template. Copy this to your project as docs/harness/PROJECT_CONTEXT.json and customize. Used as reference by session-start and state-persistence skills. Do not invoke directly.
user-invocable: false
---

# PROJECT_CONTEXT.json Template

Copy this to `docs/harness/PROJECT_CONTEXT.json` and customize:

```json
{
  "project": "project-name",
  "phase": {
    "current": "phase_id",
    "name": "Phase description",
    "status": "pending",
    "retry_count": 0,
    "max_retries": 3
  },
  "active_change": "",
  "last_session": {
    "ended": "",
    "commits": [],
    "test_status": "unknown",
    "left_clean": true
  },
  "next_tasks": [],
  "constraints": {
    "no_auto_send": true,
    "fake_embeddings": true,
    "no_real_data": true
  }
}
```

## Field Descriptions

| Field | Purpose | Updated By |
|-------|---------|-----------|
| `phase` | Current phase state and retry counter | Controller, after each step |
| `active_change` | OpenSpec change ID (if using OpenSpec) | Controller |
| `last_session` | What happened last session | Controller, at session end |
| `next_tasks` | Ordered task queue | Planner step |
| `constraints` | Non-negotiable project rules | Human, at project setup |
