# Platform Adapters

Each subdirectory contains instructions for adapting Controller Harness to a specific AI coding platform. The `.claude/` directory in the repo root is the canonical reference implementation.

## Available Adapters

| Platform | Directory | Approach |
|----------|-----------|----------|
| **Claude Code** | `../.claude/` | Native skills + agents + hooks (reference implementation) |
| **OpenAI Codex** | `codex/` | Rules files + custom instructions |
| **Cursor** | `cursor/` | `.cursor/rules/` with glob patterns |
| **Windsurf** | `windsurf/` | `.windsurf/rules/` + Cascade-as-subagent |
| **GitHub Copilot** | `copilot/` | Single `.github/copilot-instructions.md` |
| **Generic / Any** | `generic/` | Plain markdown docs, manual workflow |

## How to Choose

- **Claude Code** — Best experience, all features: skills, subagents, hooks, JSON state
- **Codex / Cursor / Windsurf** — Core patterns work, subagent delegation is manual
- **Copilot** — Minimal version due to single-file instruction limit
- **Generic** — Works with any AI tool, all patterns manual

## Platform Capability Matrix

| Feature | Claude Code | Codex | Cursor | Windsurf | Copilot | Generic |
|---------|-------------|-------|--------|----------|---------|---------|
| Skills/Rules | Native | Rules | Rules | Rules | Sections | Manual |
| Subagents | Native | Manual | Manual | Cascade | Chat threads | Manual |
| Hooks | Native | None | None | None | None | None |
| JSON State | Auto | Manual | Manual | Manual | Manual | Manual |
| Auto-Codify | Yes | No | No | No | No | No |
| Session Start | Hook | Manual | Manual | Manual | Manual | Manual |

## Adding a New Platform

1. Create `platforms/<name>/README.md`
2. Map Controller Harness concepts to the platform's native mechanisms
3. Document differences and workarounds
4. Add to this index

Follow the same structure as existing adapters: Setup → File Structure → Pattern Mapping → Key Differences.
