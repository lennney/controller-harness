# Controller Harness for GitHub Copilot

GitHub Copilot uses **`.github/copilot-instructions.md`** as a single-file instruction set. This adapter condenses Controller Harness into that format.

## Setup

```bash
cp platforms/copilot/copilot-instructions.md your-project/.github/
```

## File Structure

```
your-project/
└── .github/
    └── copilot-instructions.md    # All harness rules in one file
```

## Pattern Mapping

| Controller Harness | Copilot Equivalent |
|--------------------|--------------------|
| `.claude/skills/` | Sections in `copilot-instructions.md` |
| `.claude/CLAUDE.md` | `copilot-instructions.md` header |
| Subagents | Copilot Chat (separate thread per role) |
| Hooks | Not available |
| JSON state | Same — `docs/harness/PROJECT_CONTEXT.json` |

## Key Differences

1. **Single file** — Everything must fit in one markdown file. Keep it concise.
2. **No native subagents** — Use separate Copilot Chat threads with role prompts.
3. **Instruction length limits** — Copilot has token limits on instructions. Prioritize the most important rules.
4. **Works in all Copilot surfaces** — Instructions apply to completions, chat, and inline suggestions.

## Minimal Instruction Set

The copilot-instructions.md file includes only the essential patterns:
- [CODE] delegation rule
- Task type markers
- 7-step loop summary (1 line per step)
- Fix Phase (3 retries max)

Full skill details are in `platforms/generic/docs/` — reference them manually when needed.
