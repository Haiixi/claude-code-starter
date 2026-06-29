---
name: ecc-agent-orchestration
description: 主动使用 subagent 分解复杂任务：读代码用 Explore、做计划用 Plan、改完代码自动 review、安全敏感代码额外检查。
triggers:
  - /ecc-agent-orchestration
  - /agent
  - /delegate
  - 用 agent
  - 拆成 subagent
---

# ECC Agent Orchestration / Agent 编排

不要所有事都自己做。遇到适合独立视角或并行工作的任务，主动使用 subagent 分担。

## 何时使用

- 任务复杂，需要多步骤独立调查
- 需要同时搜索多个地方（代码、文档、测试）
- 写完/改完代码后需要审查
- 安全敏感代码需要专门检查
- 需要设计计划或架构决策

## 常用 Agent 类型

| Agent | 用途 | 典型触发 |
|-------|------|----------|
| **Explore** | 只读搜索，快速摸清代码库 | 进入新项目、找实现位置 |
| **Plan** | 做实施计划，权衡架构 | 复杂功能、重构前 |
| **general-purpose** | 通用研究、多步任务 | 不适合特定类型时 |
| **code-reviewer** | 审查改动 | 改完代码后 |
| **security-review** | 安全审查 | 认证/支付/输入处理 |

## 自动触发规则

| 事件 | 动作 |
|------|------|
| 用户要做一个复杂功能 | 先启动 Plan，再按步骤执行 |
| 刚写完/改完代码 | 自动调用 code-reviewer |
| 涉及认证、支付、敏感数据 | 自动调用 security-review |
| 进入陌生代码库 | 先启动 Explore 做概览 |
| 需要同时查多个文件/方向 | 并行启动多个 Explore |
| 准备声称任务完成 | 先调用 verification-before-completion |

## 并行 vs 顺序

**并行：** 任务之间无依赖，可独立出结果

```
同时启动：
- Explore: 找 API 路由实现
- Explore: 找数据库模型
- Explore: 找前端调用方
```

**顺序：** 后一步依赖前一步输出

```
Plan → Implement → code-reviewer → security-review → verification-before-completion
```

## 典型工作流

### 新功能实现

1. **Plan** — 出实施计划
2. **test-driven-development** — 红-绿-重构
3. **code-reviewer** — 审查实现
4. **security-review**（如涉及用户输入/认证）
5. **verification-before-completion** — 验证后收尾

### Bug 修复

1. **systematic-debugging** — 根因分析
2. **test-driven-development** — 写回归测试并修复
3. **code-reviewer** — 审查修复
4. **verification-before-completion** — 验证

### 进入新项目

1. **Explore** — 项目结构、技术栈、关键目录
2. **Plan** — 如果要改动，先出计划
3. **verification-before-completion** — 完成前验证

## 给 subagent 的提示原则

- 只给必要上下文，不要丢整段对话历史
- 明确输出格式（列表、diff、结论）
- 指定角色和限制（只读、不要改文件）
- 复杂任务拆成可验证的小任务

## 反模式

- ❌ 所有事亲力亲为
- ❌ 明明可并行却串行执行
- ❌ 跳过 review 直接提交
- ❌ 给 subagent 过大的范围

## 一句话提醒

> Agent 不是为了炫技，而是为了在正确的时间用正确的视角解决问题。
