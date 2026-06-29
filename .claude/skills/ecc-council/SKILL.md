---
name: ecc-council
description: 面对模棱两可的决策、tradeoff 或 go/no-go 时，召集 Architect、Skeptic、Pragmatist、Critic 四个独立声音做结构化讨论。
triggers:
  - /ecc-council
  - /council
  - 决策委员会
  - 多听几个意见
---

# ECC Council / 决策委员会

当多个方案都合理、需要显式权衡时，启动四声部决策流程。核心目的是通过独立视角打破对话中的锚定效应。

## 何时使用

- 决策有多条可信路径，没有明显赢家
- 需要显式列出 tradeoff
- 用户想要第二意见、反对意见或多视角
- go/no-go 决策需要对抗性挑战

**例子：** 单体 vs 微服务、现在发布 vs 再打磨、feature flag vs 全量发布、简化 scope vs 保留战略功能。

## 何时不用

| 场景 | 更适合 |
|------|--------|
| 验证输出是否正确 | verification-before-completion |
| 拆任务 | planning-and-task-breakdown |
| 纯事实问题 | 直接回答 |
| 普通执行 | 直接做 |

## 四个角色

| 声音 | 视角 |
|------|------|
| **Architect** | 正确性、可维护性、长期影响 |
| **Skeptic** | 质疑前提、简化、打破假设 |
| **Pragmatist** | 交付速度、用户价值、运维现实 |
| **Critic** | 边界情况、 downside risk、失败模式 |

**关键：** Skeptic、Pragmatist、Critic 应该以**独立 subagent** 启动，只拿到问题和必要上下文，不携带完整对话历史。

## 工作流程

### 1. 提炼真实问题

把决策写成一句话：

- 我们要决定什么？
- 关键约束是什么？
- 怎样算成功？

问题模糊时，先问一个澄清问题。

### 2. 收集必要上下文

- 代码库相关：取相关文件/片段，保持精简
- 战略/通用：除非代码直接影响结论，否则不放代码

### 3. 先写 Architect 立场

在听其他声音前，先写下：

- 你的初始倾向
- 三个最强理由
- 该方案的最大风险

避免合成时简单附和外部声音。

### 4. 并行启动三个外部声音

每个 subagent 拿到：决策问题、精简上下文、角色、**不带历史对话**。

Prompt 模板：

```text
You are the [ROLE] on a four-voice decision council.

Question:
[决策问题]

Context:
[精简上下文]

Deliverables:
1. 你对问题的明确立场
2. 三个强理由
3. 若你的立场胜出，最大风险是什么
4. 一个会让你改变立场的可验证条件

Be concise. Pick a side and defend it.
```

### 5. 综合

- 对比外部声音与 Architect 初始立场
- 找出共识区和真正分歧点
- 提取每个声音最强论点
- 给出最终推荐、最强反对意见、反转条件

## 输出模板

```markdown
# Council Decision: [主题]

## Recommendation
[明确立场]

## Areas of Consensus
- [共识 1]
- [共识 2]

## Genuine Disagreements
- [议题]: [A 认为 X], [B 认为 Y]

## Strongest Counterargument
[对推荐的最佳反对意见]

## Reversal Conditions
- [可验证条件 1]
- [可验证条件 2]

## Voice Summaries

### Architect
Position: ...
Reasons: ...
Risk: ...

### Skeptic / Pragmatist / Critic
（同上）
```

## 反模式

- ❌ 诱导性问题
- ❌ 把自己的偏好塞进 subagent 上下文
- ❌ 把不同意见当噪音
- ❌ 变成投票表决（看论证质量，不看票数）

## 一句话提醒

> 委员会的目的不是达成一致，而是在做出决定前把真正的分歧摊开来。
