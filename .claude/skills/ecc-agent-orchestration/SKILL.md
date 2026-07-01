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

> 不要所有事都自己做。遇到适合独立视角或并行工作的任务，主动使用 subagent 分担。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 复杂多步任务、并行搜索、写完代码后审查、安全敏感代码、架构决策 |
| **Common agents** | Explore, Plan, code-reviewer, security-review |
| **Rule** | 只给必要上下文，明确输出格式，指定角色和限制 |

## Process

1. **判断是否需要 subagent**：任务是否复杂、需要多视角、可并行？
2. **选择合适的 agent 类型**：Explore / Plan / code-reviewer / security-review / general-purpose。
3. **准备精简上下文**：去掉完整对话历史，只留必要信息。
4. **启动 subagent**：明确角色、限制、输出格式。
5. **整合结果**：按任务流程串联或并行结果。
6. **验证**：最后用 verification-before-completion 检查。

## Output Format

```markdown
## Agent Orchestration Plan

### Task
[What needs to be done]

### Agents Used
| Agent | Purpose | Input | Output |
|-------|---------|-------|--------|
| Explore | ... | ... | ... |
| code-reviewer | ... | ... | ... |

### Sequence
1. Plan → 2. Implement → 3. code-reviewer → 4. security-review → 5. verification

### Final Result
[Summary of outcomes]
```

## Examples

### New Feature Workflow

```text
1. Plan — 出实施计划
2. test-driven-development — 红-绿-重构
3. code-reviewer — 审查实现
4. security-review（如涉及用户输入/认证）
5. verification-before-completion — 验证后收尾
```

### Bug Fix Workflow

```text
1. systematic-debugging — 根因分析
2. test-driven-development — 写回归测试并修复
3. code-reviewer — 审查修复
4. verification-before-completion — 验证
```

### New Project Exploration

```text
1. Explore — 项目结构、技术栈、关键目录
2. Plan — 如果要改动，先出计划
3. verification-before-completion — 完成前验证
```

## Standards

### Common Agent Types

| Agent | 用途 | 典型触发 |
|-------|------|----------|
| **Explore** | 只读搜索，快速摸清代码库 | 进入新项目、找实现位置 |
| **Plan** | 做实施计划，权衡架构 | 复杂功能、重构前 |
| **general-purpose** | 通用研究、多步任务 | 不适合特定类型时 |
| **code-reviewer** | 审查改动 | 改完代码后 |
| **security-review** | 安全审查 | 认证/支付/敏感数据 |

### Auto-Trigger Rules

| 事件 | 动作 |
|------|------|
| 用户要做一个复杂功能 | 先启动 Plan，再按步骤执行 |
| 刚写完/改完代码 | 自动调用 code-reviewer |
| 涉及认证、支付、敏感数据 | 自动调用 security-review |
| 进入陌生代码库 | 先启动 Explore 做概览 |
| 需要同时查多个文件/方向 | 并行启动多个 Explore |
| 准备声称任务完成 | 先调用 verification-before-completion |

### Parallel vs Sequential

**并行**：任务之间无依赖，可独立出结果。

```text
同时启动：
- Explore: 找 API 路由实现
- Explore: 找数据库模型
- Explore: 找前端调用方
```

**顺序**：后一步依赖前一步输出。

```text
Plan → Implement → code-reviewer → security-review → verification-before-completion
```

### Prompt Principles for Subagents

- 只给必要上下文，不要丢整段对话历史。
- 明确输出格式（列表、diff、结论）。
- 指定角色和限制（只读、不要改文件）。
- 复杂任务拆成可验证的小任务。

## Checklist

- [ ] 任务适合使用 subagent（复杂/多视角/并行）
- [ ] 选择了合适的 agent 类型
- [ ] 上下文精简，不含完整对话历史
- [ ] 角色、限制、输出格式已明确
- [ ] 并行任务之间真的无依赖
- [ ] 顺序任务的依赖关系清晰
- [ ] 最终用 verification-before-completion 验证

## Red Flags

- 所有事亲力亲为
- 明明可并行却串行执行
- 跳过 review 直接提交
- 给 subagent 过大的范围
- 给 subagent 完整对话历史
- 不明确输出格式
