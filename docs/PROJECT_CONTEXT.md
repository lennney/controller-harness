---
phase: 
change: 
last_updated: 2026-05-08
owner: controller
---

# Project State

## 核心约束
Define your project constraints here. Examples:
- No auto-send
- No LLM in pipeline (default)
- Fake embedding default

## 当前阶段
描述当前 Phase 状态。

## Active OpenSpec
描述当前 active change。

## 技术栈
Define your tech stack:
- Python 3.x / uv
- PostgreSQL + pgvector
- pytest + ruff

## 下一步任务
描述下一任务。

## Phase Loop 规则
- Requirements Analysis: 必须像产品经理一样详细，包含字段定义
- Skills/Learning: 错误/模式 → codify 到 skills/ 可复用
- Code Review 失败 → 进入 Fix Phase，不忽视
- Controller NEVER implements code directly
