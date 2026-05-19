---
description: Initialize a new project with the Controller Harness scaffolding. Creates PROJECT_CONTEXT.json, features.json, directory structure, and initial commit. Use once when setting up a new project. Based on Anthropic's initializer agent pattern.
---

# Project Initializer

Inspired by Anthropic's two-agent architecture: an "Initializer Agent" scaffolds the project on session 1, then "Coding Agents" work incrementally in subsequent sessions.

## Scaffolding Steps

1. **Create directory structure:**
   ```
   docs/harness/
   subagent_results/
   reports/harness/
   ```

2. **Create `docs/harness/PROJECT_CONTEXT.json`** — state tracking (JSON, not Markdown)
3. **Create `docs/harness/features.json`** — expand the user's goal into a feature list with `passes: false`
4. **Create `init.sh`** — script that runs the dev server and basic end-to-end tests
5. **Create `.claude/settings.json`** — if not using the default
6. **Initial git commit** — scaffold in place

## Why JSON > Markdown for State

Anthropic found that "the model is less likely to inappropriately change or overwrite JSON files compared to Markdown files." Use JSON for all state files.

## features.json Format

```json
{
  "project": "project-name",
  "created": "YYYY-MM-DD",
  "features": [
    {
      "id": "F-001",
      "category": "core",
      "description": "What the feature does",
      "acceptance": ["testable criteria 1", "testable criteria 2"],
      "passes": false
    }
  ]
}
```

Rules:
- Agents can ONLY flip `passes` from `false` → `true` after verified testing
- NEVER remove or edit existing tests/acceptance criteria
- Mark features as `passes: true` only after end-to-end verification
