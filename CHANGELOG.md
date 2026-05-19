# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-05-19

### Added
- **4-Pattern Architecture**: Orchestrator-Workers (Anthropic), Evaluator-Optimizer (Anthropic), Triage Router (OpenAI), Closed Learning Loop (Hermes Agent)
- **10 native Claude Code skills** in `.claude/skills/` with YAML frontmatter: session-start, initializer, phase-loop, fix-phase, delegate-code, triage-router, pm-requirements, state-persistence, auto-codify, harness-system
- **5 role-based subagent definitions** in `.claude/agents/`: backend-engineer, code-reviewer, requirements-analyst, project-director, experience-consolidator
- **Claude Code hooks** in `.claude/settings.json`: SessionStart state check, PostToolUse linting, SubagentStop validation
- **Closed Learning Loop** (Hermes-inspired): `/auto-codify` skill auto-detects patterns and creates/refines skills after complex tasks
- **Cross-platform adapters** in `platforms/`: Codex, Cursor, Windsurf, GitHub Copilot, Generic
- **Freedom + Constraints** design principle: agentic freedom within hard guardrails (JSON state, passes boolean, session boundaries)
- **JSON state management**: `PROJECT_CONTEXT.json` + `features.json` with `passes` boolean (resists corruption better than Markdown)

### Changed
- **Complete architecture redesign**: from single custom-markdown skills to native Claude Code SKILL.md format with progressive disclosure
- **Skills now directories** with SKILL.md + supporting files (follows Anthropic's Agent Skills standard)
- **README fully rewritten**: bilingual, platform-agnostic architecture focus, cross-platform install guides
- **Old flat `skills/`** replaced by `.claude/skills/<name>/SKILL.md` directory structure
- **Task routing**: added [AUTO] marker, unmarked tasks now default to [CODE] (safer default)

### Removed
- Old v1 flat skill files (`skills/skill_*.md`)
- `plugin.json` (OpenSpec plugin manifest)
- `scripts/install.sh`, `scripts/package.sh` (replaced by direct copy + submodule approach)
- `dist/` release artifacts
- `templates/AGENTS.md.template` (AGENTS.md is not a Claude Code concept)
- `docs/AGENTS_INTEGRATION.md`, `docs/CLAUDE_BOOTSTRAP.md`, `docs/PROJECT_CONTEXT.md` (superseded)

## [1.0.0] - 2026-05-08

### Added
- Initial release as standalone repository
- 7-step Phase Loop workflow (Planner -> Requirements -> Implementation -> Review -> Doc Review -> Experience -> Coordination)
- Subagent Delegation System for role-based task execution
- Fix Phase workflow for systematic failure handling (max 3 retries)
- Skill Codification system for pattern-based learning
- Controller Context Management with handoff protocols
- Cross-platform installation scripts (Linux, Mac, Windows Git Bash/WSL)
- Documentation templates and bootstrap files
- OpenSpec plugin manifest (plugin.json)
