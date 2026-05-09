# Controller Harness / 控制器 Harness

> **控制器 Harness**: 一套用于管理复杂多阶段开发任务的 AI 编排系统，提供 7 步阶段执行工作流、子代理委托和技能文档化机制。

> **Controller Harness**: A reusable AI orchestration system for managing complex multi-step development phases, providing a 7-step phase execution workflow, subagent delegation, and skill codification.

---

## 什么是 Controller Harness？/ What is Controller Harness?

Controller Harness 是一套 **AI 编排系统**，专为 Claude Code 等 AI 助手设计，帮助它们在复杂项目中保持结构化工作流程。它的核心思想是：将一个复杂任务分解为**有序的阶段（Phase）**，每个阶段内又遵循 **7 步循环**，并在适当时候委托（Delegate）给专门的子代理执行。

Controller Harness is an **AI orchestration system** designed for AI assistants like Claude Code. Its core idea: decompose complex tasks into **ordered phases**, each following a **7-step loop**, and delegate specific work to specialized subagents when appropriate.

### 核心能力 / Core Capabilities

| 能力 | 说明 | Description |
|------|------|-------------|
| **7 步阶段循环** | Planner → Requirements → Implementation → Review → Doc Review → Experience → Coordination | Structured 7-step workflow per phase |
| **子代理委托** | 将 [CODE] 任务委托给 backend-engineer 等角色型子代理 | Delegate [CODE] tasks to role-based subagents |
| **Fix Phase 修复** | 失败时进入系统化修复流程，最多重试 3 次 | Systematic failure handling, max 3 retries |
| **技能系统** | 从错误中提取模式并文档化为可复用技能 | Extract patterns from errors into reusable skills |
| **上下文管理** | 项目状态追踪、交接协议、压缩恢复机制 | Project state tracking, handoff protocols |

---

## 优势 / Advantages

### ✓ 结构化防迷失 / Structured — No More Getting Lost

复杂任务容易让人迷失方向。Harness 提供了清晰的阶段边界和步骤指引，每一步都知道该做什么。

Complex tasks can make you lose direction. Harness provides clear phase boundaries and step guidance, so you always know what to do next.

### ✓ 责任分离更清晰 / Clear Responsibility Separation

[CODE] 任务委托给子代理，Controller 负责编排和审核。职责边界明确，减少角色混淆。

[CODE] tasks go to subagents; Controller orchestrates and reviews. Clear boundaries reduce role confusion.

### ✓ 错误可转化为资产 / Errors Become Assets

Fix Phase 不是简单地重试，而是要求文档化问题根源，并将修复模式固化为可复用技能。每一个错误都是团队知识库的积累。

Fix Phase doesn't just retry — it requires documenting root causes and codifying patterns into reusable skills. Every error becomes an asset.

### ✓ 可扩展的技能系统 / Extensible Skill System

skills/ 目录下存放着从实践中提炼的模式。遇到新错误时，创建新技能；下次遇到类似问题，直接调用已有技能。

The skills/ directory holds patterns distilled from practice. Encounter a new error? Create a skill. Next time similar problem appears? Call the existing skill directly.

### ✓ 与 OpenSpec 兼容 / OpenSpec Compatible

可与 OpenSpec 变更管理流程配合使用，每个阶段对应 OpenSpec 的一个实现单元。

Works with OpenSpec change management. Each phase maps to an OpenSpec implementation unit.

---

## 局限性 / Limitations

### ✗ 学习曲线较陡 / Steep Learning Curve

需要理解 7 步循环、Fix Phase、任务类型标记等概念。新用户需要投入时间熟悉。

Requires understanding 7-step loops, Fix Phase, task type markers, etc. New users need time to get familiar.

### ✗ 过度工程化风险 / Risk of Over-Engineering

对于简单任务（如修改一个 README），使用 Harness 反而增加负担。阶段循环对于微调级别的任务显得冗余。

For simple tasks (e.g., editing a README), Harness adds overhead. Phase loops feel redundant for micro-adjustment-level work.

### ✗ 依赖子代理质量 / Depends on Subagent Quality

子代理的输出质量直接影响整体效果。如果子代理理解偏差或执行不当，Controller 的审核成本会很高。

Subagent output quality directly affects overall results. If a subagent misunderstands or performs poorly, Controller's review cost is high.

### ✗ 缺乏内置状态持久化 / No Built-in State Persistence

当前版本依赖内存和文档管理。如果 AI 会话中断，需要手动恢复上下文。缺少自动化的任务状态持久化机制。

Current version relies on memory and document management. If an AI session is interrupted, manual context restoration is needed. Lacks automated task state persistence.

### ✗ 固定流程可能限制灵活性 / Fixed Workflow May Limit Flexibility

某些创意性或探索性任务不适合严格按阶段执行。Harness 的结构化特性在此场景下可能成为约束。

Some creative or exploratory tasks don't fit strict phase execution. Harness's structured nature can become a constraint in these scenarios.

---

## 适用场景 / Use Cases

### 适合使用 / Good Fit

- **复杂多阶段项目** — 需要跨多个阶段协同的大型功能开发
  *Complex multi-phase projects — large feature development requiring coordination across phases*

- **需要严格审核的代码** — 安全关键或金融类代码，需要双人审核机制
  *Code requiring strict review — safety-critical or financial code needing dual-review mechanism*

- **团队知识积累** — 希望通过技能系统沉淀团队经验的场景
  *Team knowledge accumulation — scenarios wanting to build team experience via skill system*

- **OpenSpec 项目** — 使用 OpenSpec 进行变更管理的团队
  *OpenSpec projects — teams using OpenSpec for change management*

### 不适合使用 / Not a Good Fit

- **快速探索/原型** — 前期探索阶段，灵活性优先于结构
  *Quick exploration/prototyping — early exploration phase where flexibility beats structure*

- **简单单次修改** — 修改一个文件、调一个 bug，不值得启动完整流程
  *Simple one-off changes — editing one file, fixing one bug, not worth launching full workflow*

- **非结构化对话** — 纯问答、信息检索类的任务
  *Unstructured conversation — pure Q&A, information retrieval tasks*

---

## 安装 / Installation

### 前置要求 / Prerequisites

- Claude Code 或兼容的 AI 助手
  *Claude Code or compatible AI assistant*
- OpenSpec CLI（可选，用于 OpenSpec 集成）
  *OpenSpec CLI (optional, for OpenSpec integration)*
- Git

### 方式一：全局安装（推荐）/ Option 1: Global Installation (Recommended)

```bash
# 克隆仓库
git clone https://github.com/controller-harness/controller-harness.git
cd controller-harness

# 运行安装脚本
./scripts/install.sh --global
```

This installs to `~/.claude/skills/controller-harness/`.  
安装到 `~/.claude/skills/controller-harness/` 目录。

### 方式二：项目级安装 / Option 2: Project-Level Installation

```bash
cd your-project

# 克隆到临时目录
git clone https://github.com/controller-harness/controller-harness.git harness-temp

# 复制到项目 skills 目录
cp -r harness-temp .claude/skills/controller-harness

# 清理临时目录
rm -rf harness-temp
```

### 方式三：手动安装 / Option 3: Manual Installation

```bash
# 创建目录
mkdir -p ~/.claude/skills/controller-harness

# 复制所有文件
cp -r controller-harness/* ~/.claude/skills/controller-harness/
```

### 验证安装 / Verify Installation

```bash
ls -la ~/.claude/skills/controller-harness/
# 应看到 plugin.json, README.md 等文件
# Should see plugin.json, README.md, etc.
```

---

## 快速开始 / Quick Start

### Step 1: 进入 Controller 模式 / Enter Controller Mode

对话中输入：

```
开始执行阶段 3 / start phase 3
```

或直接说明任务：

```
run controller harness for feature X
对功能 X 使用 controller harness
```

### Step 2: 执行一个阶段 / Execute a Phase

典型流程：

```markdown
1. [PLANNER] 阅读任务文件，理解当前任务
2. [REQUIREMENTS] 将任务转化为具体需求
3. [IMPLEMENTATION] 执行，复杂代码委托子代理
4. [REVIEW] 审核结果是否满足需求
5. [DOC REVIEW] 检查文档是否更新
6. [EXPERIENCE] 提炼经验，更新技能库
7. [COORDINATION] 提交代码或进入 Fix Phase
```

Typical flow:

```markdown
1. [PLANNER] Read task file, understand current task
2. [REQUIREMENTS] Convert task to specific requirements
3. [IMPLEMENTATION] Execute, delegate complex code to subagent
4. [REVIEW] Verify results against requirements
5. [DOC REVIEW] Check documentation is updated
6. [EXPERIENCE] Extract learnings, update skill library
7. [COORDINATION] Commit code or enter Fix Phase
```

### Step 3: 从错误中创建技能 / Create Skills from Errors

发现可复用模式时：

```bash
# 1. 检查 skills/ 是否已有类似技能
ls skills/

# 2. 创建新技能
cp skills/TEMPLATE.md skills/skill_my_pattern.md

# 3. 编辑技能内容
# 按照 TEMPLATE.md 格式填写
```

Discover reusable patterns:

```bash
# 1. Check if similar skill exists in skills/
ls skills/

# 2. Create new skill
cp skills/TEMPLATE.md skills/skill_my_pattern.md

# 3. Edit skill content
# Fill according to TEMPLATE.md format
```

---

## 核心概念 / Core Concepts

### 7 步阶段循环 / 7-Step Phase Loop

```
[1] PLANNER         -> 创建分步骤计划
[1] PLANNER         -> Create step-by-step plan

[2] REQUIREMENTS    -> 转化为具体需求
[2] REQUIREMENTS    -> Convert to specific requirements

[3] IMPLEMENTATION  -> 执行（[CODE] 任务委托子代理）
[3] IMPLEMENTATION  -> Execute (delegate [CODE] to subagent)

[4] REVIEW          -> 验证是否满足需求
[4] REVIEW          -> Verify against requirements

[5] DOC REVIEW      -> 检查文档
[5] DOC REVIEW      -> Verify documentation

[6] EXPERIENCE      -> 提炼经验，文档化技能
[6] EXPERIENCE      -> Extract learnings, codify skills

[7] COORDINATION    -> 提交+推送 或 进入 Fix Phase
[7] COORDINATION    -> Commit+push or enter Fix Phase
```

### 任务类型标记 / Task Type Markers

所有任务必须有类型标记，用于决定由谁执行：

All tasks MUST have type markers, determining who executes:

| 标记 | 说明 | 执行者 |
|------|------|--------|
| `[CODE]` | 代码实现 | 委托给子代理 / Delegate to subagent |
| `[DOC]` | 文档编写 | Controller 直接执行 / Controller executes directly |
| `[DATA]` | 数据文件 | 按需调度 / Dispatch as needed |
| `[TEST]` | 测试编写 | 按需调度 / Dispatch as needed |
| `[AUTO]` | 自动验证 | 自动执行 / Auto-execute |

### Fix Phase 修复流程 / Fix Phase Workflow

当 REVIEW 或 DOC REVIEW 失败时，进入修复流程：

When REVIEW or DOC REVIEW fails, enter fix workflow:

```
F1: 问题文档化        F2: 根因分析
F1: Issue Documentation  F2: Root Cause Analysis

    -> F3: 技能文档化  -> F4: 修复计划  -> F5: 重试决策
    -> F3: Skill Codification -> F4: Fix Plan -> F5: Retry Decision
```

每个阶段最多重试 3 次，超过则升级。  
Max 3 retries per phase before escalation.

### 技能系统 / Skill System

技能是存放在 `skills/` 目录下的可复用模式条目：

Skills are reusable pattern entries in `skills/`:

| 文件 | 用途 |
|------|------|
| `skills/TEMPLATE.md` | 技能条目模板 |
| `skills/skill_*.md` | 已创建的技能文件 |
| `skills/skill_workflow_*.md` | 内置工作流技能 |

| File | Purpose |
|------|---------|
| `skills/TEMPLATE.md` | Skill entry template |
| `skills/skill_*.md` | Created skill files |
| `skills/skill_workflow_*.md` | Built-in workflow skills |

---

## 对比其他方案 / Comparison with Alternatives

| 方案 | 优势 | 劣势 |
|------|------|------|
| **Controller Harness** | 结构化防迷失；错误可积累为知识；与 OpenSpec 兼容 | 学习成本高；对简单任务过度工程；依赖子代理质量 |
| **直接对话** | 灵活无约束；适合探索性任务；零学习成本 | 复杂任务易迷失方向；缺少审核机制；错误难以追踪 |
| **固定工作流** | 可预测性强；易于新人上手 | 灵活性差；难以适配不同场景；创意受限 |

| Option | Advantages | Disadvantages |
|--------|------------|---------------|
| **Controller Harness** | Structured, no getting lost; errors become knowledge; OpenSpec compatible | Learning curve; over-engineering for simple tasks; depends on subagent quality |
| **Direct Conversation** | Flexible, no constraints; good for exploratory tasks; zero learning cost | Easy to lose direction on complex tasks; no review mechanism; hard to track errors |
| **Fixed Workflow** | Predictable; easy for newcomers | Inflexible; hard to adapt; creativity limited |

### 何时选择哪种方案？/ When to Choose Which?

| 场景 | 推荐方案 |
|------|----------|
| 探索性/原型开发 | 直接对话 |
| 简单单次修改 | 直接对话 |
| 复杂多阶段功能 | Controller Harness |
| 需要严格审核的代码 | Controller Harness |
| 高度结构化的团队流程 | 固定工作流 |

| Scenario | Recommended |
|----------|-------------|
| Exploratory/prototyping | Direct Conversation |
| Simple one-off change | Direct Conversation |
| Complex multi-phase feature | Controller Harness |
| Code requiring strict review | Controller Harness |
| Highly structured team process | Fixed Workflow |

---

## 文件结构 / File Structure

```
controller-harness/
├── plugin.json                    # 插件清单 / Plugin manifest
├── README.md                      # 本文件 / This file
├── LICENSE                        # MIT 许可证
├── CHANGELOG.md                   # 版本历史 / Version history
├── .claude/
│   └── CLAUDE.md                 # 引导入口 / Bootstrap entry
├── scripts/
│   ├── install.sh                 # 安装脚本 / Installation script
│   └── package.sh                 # 打包脚本 / Packaging script
├── docs/
│   ├── PHASE_LOOP.md             # 7 步工作流定义
│   ├── PROJECT_CONTEXT.md        # 状态追踪模板
│   ├── CONTROLLER_HARNESS_PRACTICE.md  # 核心原则
│   └── AGENTS_INTEGRATION.md     # 集成指南
├── skills/
│   ├── TEMPLATE.md               # 技能条目模板
│   ├── skill_workflow_phase_loop.md
│   ├── skill_workflow_subagent_delegation.md
│   ├── skill_requirements_pm_style.md
│   └── skill_controller_harness_system.md
└── templates/
    ├── claude.md                 # 引导 CLAUDE.md 模板
    └── AGENTS.md.template        # AGENTS.md 集成模板
```

---

## 与你的项目集成 / Integration with Your Project

### Step 1: 添加引导引用 / Add Bootstrap Reference

在你的 `.claude/CLAUDE.md` 中添加：

Add to your `.claude/CLAUDE.md`:

```markdown
> **Bootstrap**: 本文件由 `.claude/CLAUDE.md` 加载。阶段执行工作流见 `docs/PHASE_LOOP.md`。

> **Bootstrap**: This file is loaded by `.claude/CLAUDE.md`. See `docs/PHASE_LOOP.md` for phase execution workflow.
```

### Step 2: 创建项目上下文 / Create Project Context

复制 `docs/PROJECT_CONTEXT.md` 到你项目的 `docs/` 目录并自定义。

Copy `docs/PROJECT_CONTEXT.md` to your project's `docs/` directory and customize.

### Step 3: 配置任务文件 / Configure Task Files

项目应有一个任务追踪文件（如 `tasks.md` 或 `openspec/changes/{active}/tasks.md`），使用任务类型标记：

Your project should have a task tracking file (e.g., `tasks.md` or `openspec/changes/{active}/tasks.md`) with task type markers:

```markdown
## 阶段 1：功能设置
- [ ] 1.1 [CODE]: 初始化模块结构
- [ ] 1.2 [DOC]: 更新 README
```

---

## 常见问题 / FAQ

### Q: 什么情况下不适合使用 Harness？

A: 对于单次简单修改、探索性任务、纯问答场景，直接对话更高效。Harness 的价值在于复杂任务的长期管理和知识积累。

### Q: 如果子代理输出质量不好怎么办？

A: Controller 应仔细审核子代理输出。必要时可以调整子代理的 prompt，或在 Fix Phase 中记录问题并创建技能。

### Q: 如何处理跨阶段的状态保持？

A: 当前版本依赖文档和内存。建议在每个阶段结束时更新项目上下文文档，保持状态可追踪。

### Q: Can I use Harness for small tasks?

A: For single quick changes, exploratory tasks, or pure Q&A, direct conversation is more efficient. Harness's value is in managing complex tasks and accumulating knowledge over time.

### Q: What if subagent output quality is poor?

A: Controller should carefully review subagent output. If needed, adjust the subagent's prompt, or document the issue in Fix Phase and create a skill.

### Q: How to handle cross-phase state persistence?

A: Current version relies on documents and memory. Recommended: update project context document at end of each phase to keep state traceable.

---

## 贡献 / Contributing

欢迎提交 Issue 和 Pull Request！请确保：

1. 遵循现有代码风格
2. 添加或更新相关文档
3. 测试你的改动

详细贡献指南请参阅 CONTRIBUTING.md。

---

## 许可证 / License

MIT License - 详见 LICENSE 文件。

MIT License - See LICENSE file for details.

---

## 参考资源 / Reference Resources

- [7 步阶段循环详解 / 7-Step Phase Loop](docs/PHASE_LOOP.md)
- [项目上下文模板 / Project Context Template](docs/PROJECT_CONTEXT.md)
- [核心实践原则 / Core Practice Principles](docs/CONTROLLER_HARNESS_PRACTICE.md)
- [子代理集成指南 / Subagent Integration Guide](docs/AGENTS_INTEGRATION.md)
- [技能模板 / Skill Template](skills/TEMPLATE.md)