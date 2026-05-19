# Controller Harness v2

> **AI 编排系统** — 基于 Anthropic、OpenAI 和 Hermes Agent 的经过验证的模式，为 AI 编码助手提供结构化的多阶段工作流。
>
> **AI Orchestration System** — Structured multi-phase workflows for AI coding assistants, built on proven patterns from Anthropic, OpenAI, and Hermes Agent.

---

## 是什么？/ What is it?

Controller Harness 是一套**可复用的 AI 编排框架**。它把复杂开发任务拆成 7 步阶段循环，通过角色型子代理委托执行，并自动从错误中学习。它不是另一个工具，而是**给 AI 助手的操作手册**。

Controller Harness is a **reusable AI orchestration framework**. It breaks complex dev tasks into a 7-step phase loop, delegates to role-based subagents, and learns from errors automatically. It's not another tool — it's an **operating manual for AI assistants**.

### 核心能力 / Core Capabilities

| 能力 / Capability | 说明 |
|-------------------|------|
| **7-Step Phase Loop** | Planner → Requirements → Implementation → Review → Doc Review → Experience → Coordination |
| **Subagent Delegation** | Role-based agents: backend-engineer, code-reviewer, requirements-analyst, project-director |
| **Evaluator-Optimizer** | Review → Fix Phase → Retry loop (max 3), with root cause analysis |
| **Closed Learning Loop** | Auto-detect patterns, create/refine skills from experience (Hermes-inspired) |
| **Triage Router** | Task type markers ([CODE]/[DOC]/[TEST]/[DATA]/[AUTO]) route to correct executor |
| **JSON State** | Corruption-resistant state tracking (Anthropic's finding: JSON > Markdown) |

---

## 架构 / Architecture

Controller Harness 融合了 4 个来源的经过验证的模式：
Controller Harness combines proven patterns from 4 sources:

| Pattern | Source | How We Use It |
|---------|--------|---------------|
| **Orchestrator-Workers** | [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) | Controller decomposes tasks, delegates to subagents, synthesizes results |
| **Evaluator-Optimizer** | [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) | Review (evaluator) → Fix Phase (optimizer) → retry loop |
| **Triage Router** | [OpenAI](https://openai.github.io/openai-agents-python/handoffs/) | Task type markers route to correct subagent |
| **Closed Learning Loop** | [Hermes Agent](https://github.com/NousResearch/hermes-agent) | Auto-detect patterns → create/refine skills from experience |

### 设计原则：自由 + 约束 / Design Principle: Freedom + Constraints

给模型 agentic 自由，但用硬约束保护：
Give the model agentic freedom within hard constraints:

- **自由 / Freedom**: agents choose HOW to implement, decompose tasks, use tools
- **约束 / Constraints**: JSON state files resist corruption, `passes` boolean prevents premature "done", session boundaries enforce clean state, [CODE] delegation is non-negotiable

---

## 支持平台 / Supported Platforms

Controller Harness 的核心是**平台无关的模式**，可以适配到任何 AI 编码助手。`.claude/` 是参考实现。
The core patterns are **platform-agnostic**. `.claude/` is the reference implementation.

| 平台 / Platform | 状态 / Status | 目录 / Directory | 说明 |
|-----------------|---------------|------------------|------|
| **Claude Code** | Primary | `.claude/` | Skills + Agents + Hooks, full native support |
| **OpenAI Codex** | Adapter | `platforms/codex/` | Rules + custom instructions |
| **Cursor** | Adapter | `platforms/cursor/` | `.cursor/rules/` integration |
| **Windsurf** | Adapter | `platforms/windsurf/` | `.windsurf/rules/` integration |
| **GitHub Copilot** | Adapter | `platforms/copilot/` | `.github/copilot-instructions.md` |
| **Generic / Any** | Universal | `platforms/generic/` | Plain markdown docs, works everywhere |

---

## 快速开始 / Quick Start

### Claude Code（主平台 / Primary）

```bash
# 1. Clone to your project
git clone https://github.com/lennney/controller-harness.git harness-temp

# 2. Copy the .claude directory
cp -r harness-temp/.claude your-project/
cp harness-temp/templates/claude.md your-project/.claude/CLAUDE.md

# 3. Clean up
rm -rf harness-temp

# 4. Start coding — the harness activates automatically
```

Or add as a git submodule:

```bash
cd your-project
git submodule add https://github.com/lennney/controller-harness.git .claude/harness
cp .claude/harness/templates/claude.md .claude/CLAUDE.md
```

### OpenAI Codex

```bash
cp -r platforms/codex/.codex your-project/
```

Codex uses rules files that encode the same patterns. See `platforms/codex/README.md` for details.

### Cursor

```bash
cp -r platforms/cursor/.cursor your-project/
```

Cursor rules with glob patterns for automatic file matching. See `platforms/cursor/README.md`.

### Windsurf

```bash
cp -r platforms/windsurf/.windsurf your-project/
```

See `platforms/windsurf/README.md`.

### GitHub Copilot

```bash
cp platforms/copilot/copilot-instructions.md your-project/.github/
```

See `platforms/copilot/README.md`.

### 通用 / Generic（任何 AI 工具 / Any AI Tool）

```bash
cp -r platforms/generic/docs your-project/docs/harness/
```

Plain markdown — point any AI tool to `docs/harness/` as context.

---

## 核心概念 / Core Concepts

### 7 步阶段循环 / 7-Step Phase Loop

```
[1] PLANNER         → 分解任务，创建计划
                      Decompose task, create plan
[2] REQUIREMENTS    → 转化为具体需求规格
                      Convert to spec with acceptance criteria
[3] IMPLEMENTATION  → 委托 [CODE] 给 backend-engineer
                      Delegate [CODE] to backend-engineer
[4] REVIEW          → code-reviewer 验证是否满足需求
                      Verify against requirements
[5] DOC REVIEW      → Controller 检查文档完整性
                      Controller checks doc completeness
[6] EXPERIENCE      → 提炼经验，自动创建/更新技能
                      Extract learnings, auto-create skills
[7] COORDINATION    → 提交代码 或 进入 Fix Phase
                      Commit or enter Fix Phase
```

### 任务类型标记 / Task Type Markers

| 标记 / Marker | 执行者 / Executor | 说明 |
|---------------|-------------------|------|
| `[CODE]` | backend-engineer subagent | 代码实现，Controller 绝不直接写 |
| `[DOC]` | Controller (self) | 文档编写 |
| `[TEST]` | backend-engineer subagent | 测试编写 |
| `[DATA]` | Dispatched as needed | 数据文件 |
| `[AUTO]` | Controller (self) | 自动验证 |
| Unmarked | backend-engineer subagent | 未标记 = 假定 [CODE]（安全默认） |

### Fix Phase 修复流程

```
Review 失败 / Review Fails
    ↓
F1: 问题文档化 / Issue Documentation
F2: 根因分析 / Root Cause Analysis
F3: 技能文档化 / Skill Codification
F4: 修复计划 / Fix Plan
F5: 重试 / Retry（最多 3 次 / max 3）
```

### 技能系统 / Skill System

技能是 `.claude/skills/` 中的可复用模式。每次复杂任务完成后，系统自动评估是否应该创建或更新技能（Hermes 的 Closed Learning Loop）。

Skills are reusable patterns in `.claude/skills/`. After each complex task, the system evaluates whether to create or refine a skill (Hermes' Closed Learning Loop).

**Built-in skills:**

| Skill | Purpose |
|-------|---------|
| `session-start` | State recovery at session start |
| `initializer` | Project scaffolding with JSON feature list |
| `phase-loop` | 7-step execution with quality gates |
| `fix-phase` | Systematic failure recovery |
| `delegate-code` | [CODE] must be delegated |
| `triage-router` | Task type → correct subagent |
| `pm-requirements` | PM-style requirements template |
| `state-persistence` | JSON state, clean-state discipline |
| `auto-codify` | Autonomous skill creation from experience |
| `harness-system` | System overview and architecture reference |

---

## 文件结构 / File Structure

```
controller-harness/
├── README.md                       # 本文件 / This file
├── CHANGELOG.md                    # 版本历史
├── LICENSE                         # MIT
├── .claude/                        # Claude Code 参考实现 / Reference implementation
│   ├── CLAUDE.md                   # 项目引导文件 / Bootstrap
│   ├── settings.json               # Hooks (SessionStart, PostToolUse, SubagentStop)
│   ├── skills/                     # 10 个可复用技能
│   │   ├── session-start/SKILL.md
│   │   ├── initializer/SKILL.md
│   │   ├── phase-loop/SKILL.md
│   │   ├── fix-phase/SKILL.md
│   │   ├── delegate-code/SKILL.md
│   │   ├── triage-router/SKILL.md
│   │   ├── pm-requirements/SKILL.md
│   │   ├── state-persistence/SKILL.md
│   │   ├── auto-codify/SKILL.md
│   │   └── harness-system/SKILL.md
│   └── agents/                     # 5 个角色型子代理
│       ├── backend-engineer.md
│       ├── code-reviewer.md
│       ├── requirements-analyst.md
│       ├── project-director.md
│       └── experience-consolidator.md
├── platforms/                      # 跨平台适配器 / Cross-platform adapters
│   ├── codex/
│   ├── cursor/
│   ├── windsurf/
│   ├── copilot/
│   └── generic/
├── templates/                      # 项目模板 / Project templates
│   └── claude.md                   # 下游项目 CLAUDE.md 模板
└── docs/                           # 详细参考文档 / Detailed references
    ├── PHASE_LOOP.md               # 7 步工作流详解
    └── CONTROLLER_HARNESS_PRACTICE.md  # 实践指南
```

---

## 对比 / Comparison

| 方案 / Approach | 适合 / Best For | 不适合 / Not For |
|-----------------|-----------------|------------------|
| **Controller Harness** | 复杂多阶段功能、需要审核的代码、团队知识积累 | 快速原型、简单修改 |
| **Direct Chat** | 探索性任务、简单修改、问答 | 复杂多步骤功能 |
| **Fixed Workflow** | 高度标准化的团队流程 | 需要灵活性的场景 |

---

## FAQ

**Q: 为什么要用 Harness 而不是直接对话？/ Why not just chat directly?**

A: 直接对话在复杂任务中容易迷失方向。Harness 提供结构化流程、审核机制和知识积累。对简单任务，直接对话更好。

Direct chat loses direction on complex tasks. Harness provides structure, review, and knowledge accumulation. For simple tasks, direct chat is better.

**Q: 我能只用部分功能吗？/ Can I use only parts of it?**

A: 可以。每个 skill 是独立的。你可以只用 `delegate-code` 和 `code-reviewer`，不用完整的 phase loop。

Yes. Each skill is independent. You can use just `delegate-code` + `code-reviewer` without the full phase loop.

**Q: 怎么适配到我的平台？/ How do I adapt to my platform?**

A: 阅读核心模式（见 `platforms/generic/`），然后用你平台的机制（rules、instructions、context files）来实现。`platforms/` 目录下有各平台的适配指南。

Read the core patterns, then implement them using your platform's mechanisms. See `platforms/` for platform-specific guides.

**Q: 子代理输出质量不好怎么办？/ What if subagent output quality is poor?**

A: Controller 应仔细审核。必要时调整 subagent prompt，或在 Fix Phase 中记录问题并创建技能。

Controller should review carefully. Adjust subagent prompts if needed, or document in Fix Phase and create a skill.

---

## 贡献 / Contributing

欢迎提交 Issue 和 PR！/ Issues and PRs welcome!

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Ensure consistency across `.claude/skills/` and `platforms/`
5. Submit a PR

---

## 致谢 / Credits

- [Anthropic — Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) — 5 workflow patterns
- [Anthropic — Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) — Session boundaries, JSON state
- [OpenAI — Agents SDK](https://openai.github.io/openai-agents-python/) — Triage/handoff pattern
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — Closed learning loop, autonomous skill creation
- [Agent Skills Standard](https://agentskills.io) — Open standard for AI agent skills

---

## 许可证 / License

MIT — see [LICENSE](LICENSE)
