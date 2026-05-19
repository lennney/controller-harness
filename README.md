# Controller Harness v2

> **AI 编排系统** — 基于 Anthropic、OpenAI 和 Hermes Agent 的经过验证的模式，为 AI 编码助手提供结构化的多阶段工作流。
>
> **AI Orchestration System** — Structured multi-phase workflows for AI coding assistants, built on proven patterns from Anthropic, OpenAI, and Hermes Agent.

---

## 是什么？ / What is it?

Controller Harness 是一套**可复用的 AI 编排框架**。它把复杂开发任务拆成 7 步阶段循环，通过角色型子代理委托执行，并自动从错误中学习。它不是另一个工具，而是**给 AI 助手的操作手册**。

Controller Harness is a **reusable AI orchestration framework**. It breaks complex dev tasks into a 7-step phase loop, delegates to role-based subagents, and learns from errors automatically. It's not another tool — it's an **operating manual for AI assistants**.

### 核心能力 / Core Capabilities

| 能力 / Capability | 说明 / Description |
|-------------------|-------------------|
| **7 步阶段循环 / 7-Step Phase Loop** | Planner → Requirements → Implementation → Review → Doc Review → Experience → Coordination |
| **子代理委托 / Subagent Delegation** | 角色型代理：backend-engineer、code-reviewer、requirements-analyst、project-director / Role-based agents |
| **评估-优化器 / Evaluator-Optimizer** | Review → Fix Phase → 重试循环（最多 3 次），含根因分析 / Retry loop (max 3) with root cause analysis |
| **闭环学习 / Closed Learning Loop** | 自动检测模式，从经验中创建/优化技能（受 Hermes 启发） / Auto-detect patterns, create/refine skills from experience (Hermes-inspired) |
| **分诊路由 / Triage Router** | 任务类型标记（[CODE]/[DOC]/[TEST]/[DATA]/[AUTO]）路由到正确的执行者 / Task type markers route to correct executor |
| **JSON 状态 / JSON State** | 抗损坏的状态追踪（Anthropic 的发现：JSON > Markdown） / Corruption-resistant state tracking |

---

## 架构 / Architecture

Controller Harness 融合了 4 个来源的经过验证的模式：
Controller Harness combines proven patterns from 4 sources:

| 模式 / Pattern | 来源 / Source | 使用方式 / How We Use It |
|---------|--------|---------------|
| **编排-工作者 / Orchestrator-Workers** | [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) | Controller 分解任务，委托给子代理，综合结果 / Controller decomposes, delegates, synthesizes |
| **评估-优化器 / Evaluator-Optimizer** | [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) | Review（评估）→ Fix Phase（优化）→ 重试循环 / Review → Fix Phase → retry loop |
| **分诊路由 / Triage Router** | [OpenAI](https://openai.github.io/openai-agents-python/handoffs/) | 任务类型标记路由到正确的子代理 / Task type markers route to correct subagent |
| **闭环学习 / Closed Learning Loop** | [Hermes Agent](https://github.com/NousResearch/hermes-agent) | 自动检测模式 → 从经验中创建/优化技能 / Auto-detect patterns → create/refine skills |

### 设计原则：自由 + 约束 / Design Principle: Freedom + Constraints

给模型 agentic 自由，但用硬约束保护：
Give the model agentic freedom within hard constraints:

- **自由 / Freedom**：agents 自行选择如何实现、如何分解任务、如何使用工具 / agents choose HOW to implement, decompose tasks, use tools
- **约束 / Constraints**：JSON 状态文件抗损坏、`passes` 布尔值防止过早"完成"、session 边界强制执行干净状态、[CODE] 委托不可协商 / JSON state resists corruption, `passes` boolean prevents premature "done", session boundaries enforce clean state, [CODE] delegation is non-negotiable

---

## 安装 / Installation

Controller Harness 是一个 **skill 包**，可以一键安装到任何 Claude Code 项目。
Controller Harness is a **skill package** — install it into any Claude Code project with one command.

### 方式一：安装脚本（推荐） / Option 1: Install Script (Recommended)

```bash
# 1. 克隆仓库 / Clone the repo
git clone https://github.com/lennney/controller-harness.git
cd controller-harness

# 2. 安装到你的项目 / Install to your project
./install.sh /path/to/your-project

# 3. 安装到全局（所有项目可用） / Install globally (all projects)
./install.sh --global
```

安装脚本会自动把 skills、agents 复制到正确位置。
The script copies skills and agents to the correct locations automatically.

### 方式二：Git Submodule（可跟随更新） / Option 2: Git Submodule (Auto-Update)

```bash
cd your-project
git submodule add https://github.com/lennney/controller-harness.git .claude/skills/controller-harness
.claude/skills/controller-harness/install.sh .
```

### 方式三：手动安装 / Option 3: Manual Install

```bash
# 复制 skills / Copy skills
cp -r controller-harness/skills/* your-project/.claude/skills/

# 复制 agents / Copy agents
cp controller-harness/agents/* your-project/.claude/agents/

# 复制主 skill / Copy main skill
mkdir -p your-project/.claude/skills/controller-harness
cp controller-harness/SKILL.md your-project/.claude/skills/controller-harness/
```

---

## 支持平台 / Supported Platforms

Controller Harness 的核心是**平台无关的模式**，可以适配到任何 AI 编码助手。
The core patterns are **platform-agnostic** — adaptable to any AI coding assistant.

| 平台 / Platform | 状态 / Status | 适配目录 / Adapter | 说明 / Notes |
|-----------------|---------------|------------------|------|
| **Claude Code** | 主平台 / Primary | 仓库根目录 / repo root | 原生 Skills + Agents + Hooks / Full native support |
| **OpenAI Codex** | 适配器 / Adapter | `platforms/codex/` | Rules + 自定义指令 / Rules + custom instructions |
| **Cursor** | 适配器 / Adapter | `platforms/cursor/` | `.cursor/rules/` 集成 / Rules with glob patterns |
| **Windsurf** | 适配器 / Adapter | `platforms/windsurf/` | `.windsurf/rules/` 集成 |
| **GitHub Copilot** | 适配器 / Adapter | `platforms/copilot/` | 单文件指令 / Single-file instructions |
| **通用 / Generic** | 通用 / Universal | `platforms/generic/` | 纯 Markdown 文档，适用于任何工具 / Plain docs, works everywhere |

各平台的详细安装说明见 `platforms/<platform>/README.md`。
See `platforms/<platform>/README.md` for per-platform setup details.

---

## 核心概念 / Core Concepts

### 7 步阶段循环 / 7-Step Phase Loop

```
[1] PLANNER         规划    → 分解任务，创建带验收标准的计划
                             Decompose task, create plan with acceptance criteria

[2] REQUIREMENTS    需求    → 转化为具体需求规格
                             Convert to spec with specific requirements

[3] IMPLEMENTATION  实现    → 委托 [CODE] 给 backend-engineer（Controller 绝不直接写代码）
                             Delegate [CODE] to backend-engineer (Controller NEVER writes code directly)

[4] REVIEW          评审    → code-reviewer 验证是否满足需求
                             code-reviewer verifies against requirements

[5] DOC REVIEW      文档    → Controller 检查文档完整性和准确性
                             Controller checks documentation completeness and accuracy

[6] EXPERIENCE      经验    → 提炼经验，自动创建或更新技能
                             Extract learnings, auto-create or refine skills

[7] COORDINATION    协调    → 提交代码 或 进入 Fix Phase
                             Commit code or enter Fix Phase
```

### 任务类型标记 / Task Type Markers

所有任务必须有类型标记，决定由谁执行：
Every task must have a type marker, determining who executes it:

| 标记 / Marker | 执行者 / Executor | 说明 / Description |
|---------------|-------------------|------|
| `[CODE]` | backend-engineer 子代理 | 代码实现，Controller 绝不直接写 / Code — NEVER written by Controller |
| `[DOC]` | Controller（自己） / Controller (self) | 文档编写 / Documentation |
| `[TEST]` | backend-engineer 子代理 | 测试编写 / Test code |
| `[DATA]` | 按需调度 / Dispatched as needed | 数据文件 / Data files |
| `[AUTO]` | Controller（自己） / Controller (self) | 自动验证 / Automated checks |
| 未标记 / Unmarked | backend-engineer 子代理 | 假定为 [CODE]（安全默认） / Assume [CODE] (safe default) |

### Fix Phase 修复流程 / Fix Phase

```
Review 失败 / Review Fails
    ↓
F1: 问题文档化 / Issue Documentation    → 准确描述问题 / Describe the issue precisely
F2: 根因分析 / Root Cause Analysis      → 找出根本原因而非表面症状 / Find root cause, not symptoms
F3: 技能文档化 / Skill Codification     → 将修复方案固化为可复用技能 / Codify the fix as a reusable skill
F4: 修复计划 / Fix Plan                 → 制定具体修复步骤 / Create specific fix steps
F5: 重试 / Retry                        → 最多 3 次，超过则升级 / Max 3 retries, then escalate
```

### 技能系统 / Skill System

技能是存放在 `skills/` 中的可复用模式条目。每次复杂任务完成后，系统自动评估是否应该创建或更新技能（Hermes 的闭环学习）。

Skills are reusable pattern entries in `skills/`. After each complex task, the system automatically evaluates whether to create or refine a skill (Hermes' Closed Learning Loop).

**内置技能 / Built-in Skills:**

| 技能 / Skill | 用途 / Purpose |
|-------|---------|
| `session-start` | Session 开始时恢复状态 / State recovery at session start |
| `initializer` | 项目脚手架，生成 JSON 功能列表 / Project scaffolding with JSON feature list |
| `phase-loop` | 7 步执行，带质量门禁 / 7-step execution with quality gates |
| `fix-phase` | 系统化失败恢复（F1-F5） / Systematic failure recovery |
| `delegate-code` | 强制 [CODE] 委托给子代理 / Enforce [CODE] delegation |
| `triage-router` | 任务类型 → 正确的子代理 / Task type → correct subagent |
| `pm-requirements` | PM 风格的需求模板 / PM-style requirements template |
| `state-persistence` | JSON 状态模式，干净状态纪律 / JSON state, clean-state discipline |
| `auto-codify` | 从经验中自动创建技能（Hermes 闭环） / Autonomous skill creation |

---

## 文件结构 / File Structure

```
controller-harness/                 # 这个仓库 = 一个 skill 包 / This repo = a skill package
├── SKILL.md                        # 主 skill 入口（系统概览） / Main skill entry
├── install.sh                      # 一键安装脚本 / One-command installer
├── README.md                       # 本文件 / This file
├── CHANGELOG.md                    # 版本历史 / Version history
├── LICENSE                         # MIT 许可证
│
├── skills/                         # 9 个可安装 skill → 用户的 .claude/skills/
│   ├── session-start/SKILL.md      #   Session 启动
│   ├── initializer/SKILL.md        #   项目初始化
│   ├── phase-loop/SKILL.md         #   阶段循环
│   ├── fix-phase/SKILL.md          #   修复阶段
│   ├── delegate-code/SKILL.md      #   代码委托
│   ├── triage-router/SKILL.md      #   分诊路由
│   ├── pm-requirements/SKILL.md    #   需求模板
│   ├── state-persistence/SKILL.md  #   状态持久化
│   └── auto-codify/SKILL.md        #   自动技能创建
│
├── agents/                         # 5 个子代理定义 → 用户的 .claude/agents/
│   ├── backend-engineer.md         #   后端工程师
│   ├── code-reviewer.md            #   代码评审
│   ├── requirements-analyst.md     #   需求分析
│   ├── project-director.md         #   项目总监
│   └── experience-consolidator.md  #   经验整合
│
├── hooks/
│   └── settings.json               # Hooks 片段（合并到用户配置） / Merge into user settings
│
├── platforms/                      # 跨平台适配器 / Cross-platform adapters
│   ├── codex/                      #   OpenAI Codex
│   ├── cursor/                     #   Cursor IDE
│   ├── windsurf/                   #   Windsurf IDE
│   ├── copilot/                    #   GitHub Copilot
│   └── generic/                    #   通用（任何 AI 工具）
│
├── templates/
│   └── claude.md                   # 下游项目 CLAUDE.md 模板 / Downstream project template
│
└── docs/                           # 详细参考文档 / Detailed reference
    ├── PHASE_LOOP.md               #   7 步工作流详解
    └── CONTROLLER_HARNESS_PRACTICE.md  # 实践指南（中文）
```

---

## 对比 / Comparison

| 方案 / Approach | 适合 / Best For | 不适合 / Not For |
|-----------------|-----------------|------------------|
| **Controller Harness** | 复杂多阶段功能、需要严格审核的代码、团队知识积累 / Complex multi-phase features, strict review requirements, team knowledge accumulation | 快速原型、简单修改 / Quick prototypes, simple changes |
| **直接对话 / Direct Chat** | 探索性任务、简单修改、问答 / Exploratory tasks, simple changes, Q&A | 复杂多步骤功能 / Complex multi-step features |
| **固定工作流 / Fixed Workflow** | 高度标准化的团队流程 / Highly standardized team processes | 需要灵活性的场景 / Scenarios requiring flexibility |

---

## 常见问题 / FAQ

**Q: 为什么要用 Harness 而不是直接对话？ / Why not just chat directly?**

A: 直接对话在复杂任务中容易迷失方向。Harness 提供结构化流程、审核机制和知识积累。但对于简单任务（改一个文件、修一个 bug），直接对话更高效。

Direct chat can lose direction on complex tasks. Harness provides structure, review, and knowledge accumulation. But for simple tasks (edit one file, fix one bug), direct chat is more efficient.

**Q: 我能只用部分功能吗？ / Can I use only parts of it?**

A: 可以。每个 skill 是独立的。你可以只用 `delegate-code` + `code-reviewer` 这两个 skill，而不用完整的 7 步阶段循环。

Yes. Each skill works independently. You can use just `delegate-code` + `code-reviewer` without the full 7-step phase loop.

**Q: 怎么适配到其他平台？ / How do I adapt this to other platforms?**

A: 阅读 `platforms/generic/docs/PATTERNS.md` 了解核心模式，然后用你平台的机制（rules、instructions、context files）来实现。`platforms/` 目录下有各平台的具体适配指南。

Read `platforms/generic/docs/PATTERNS.md` for the core patterns, then implement them using your platform's mechanisms (rules, instructions, context files). See `platforms/` for per-platform guides.

**Q: 子代理输出质量不好怎么办？ / What if subagent output quality is poor?**

A: Controller 应仔细审核子代理输出。必要时调整子代理的 prompt 定义文件（`agents/*.md`）。如果问题是可复现的，在 Fix Phase 中记录并创建对应技能。

Controller should review subagent output carefully. Adjust agent definition files (`agents/*.md`) if needed. If the issue is reproducible, document it in Fix Phase and create a corresponding skill.

**Q: 和 OpenSpec 能一起用吗？ / Does it work with OpenSpec?**

A: 可以。Controller Harness 的 phase 概念和 OpenSpec 的 change 概念可以自然映射——每个 phase 对应一个 OpenSpec 实现单元。

Yes. The phase concept maps naturally to OpenSpec changes — each phase corresponds to an OpenSpec implementation unit.

---

## 贡献 / Contributing

欢迎提交 Issue 和 Pull Request！/ Issues and PRs welcome!

1. Fork 本仓库 / Fork the repo
2. 创建功能分支 / Create a feature branch
3. 进行修改 / Make your changes
4. 确保 `skills/`、`agents/`、`platforms/` 之间的一致性 / Ensure consistency across skills, agents, and platforms
5. 提交 PR / Submit a PR

---

## 致谢 / Credits

- [Anthropic — Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) — 5 种工作流模式 / 5 workflow patterns
- [Anthropic — Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) — Session 边界、JSON 状态管理 / Session boundaries, JSON state
- [OpenAI — Agents SDK](https://openai.github.io/openai-agents-python/) — 分诊/Handoff 模式 / Triage/handoff pattern
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — 闭环学习、自主技能创建 / Closed learning loop, autonomous skill creation
- [Agent Skills Standard](https://agentskills.io) — AI Agent 技能的开放标准 / Open standard for AI agent skills

---

## 许可证 / License

MIT — 详见 [LICENSE](LICENSE) / See [LICENSE](LICENSE)
