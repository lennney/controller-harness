---
description: Session start ritual that recovers project state after context windows reset. Run at the beginning of every new session to re-orient to current work and verify the project is in working order. Based on Anthropic's effective harness pattern.
---

# Session Start Ritual

Inspired by [Anthropic's harness design for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents).

## Recovery Sequence (must run in order)

1. **Check working directory** — confirm you're in the right project
2. **Read `docs/harness/PROJECT_CONTEXT.json`** — current phase, active change, task state
3. **Read `docs/harness/features.json`** (if exists) — find highest-priority unfinished feature
4. **Check git log** — `git log --oneline -20` to see recent commits
5. **Read `reports/harness/error_memory.jsonl`** — any unresolved P1 errors?
6. **Run existing tests** — `pytest` or equivalent to verify the project isn't broken
7. **Start dev server** (if applicable) — verify the app runs

## Why This Order Matters

- Step 6 catches broken state left by a previous session
- Step 2-3 tell you what to work on next
- Step 4 provides context on what was recently done
- Skipping verification (step 6) is the #1 cause of compounding bugs across sessions

## After Recovery

Report: current phase, last commit, test status, and recommended next task.
