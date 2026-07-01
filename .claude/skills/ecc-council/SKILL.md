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

> 当多个方案都合理、需要显式权衡时，启动四声部决策流程。核心目的是通过独立视角打破对话中的锚定效应。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 多条可信路径、需要显式 tradeoff、go/no-go、想要第二意见 |
| **Four voices** | Architect, Skeptic, Pragmatist, Critic |
| **Output** | Recommendation + consensus + disagreements + reversal conditions |

## Process

1. **提炼真实问题**：一句话写出要决定什么、约束是什么、怎样算成功。
2. **收集必要上下文**：代码片段保持精简，战略问题不放代码。
3. **写 Architect 立场**：先写下初始倾向、三个最强理由、最大风险。
4. **并行启动三个外部声音**：Skeptic、Pragmatist、Critic 独立运行，不带完整对话历史。
5. **综合**：对比声音，找出共识区、真正分歧点、最强反对意见、反转条件。
6. **输出决策报告**。

## Output Format

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

## Examples

### Subagent Prompt Template

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

### When NOT to Use

| 场景 | 更适合 |
|------|--------|
| 验证输出是否正确 | verification-before-completion |
| 拆任务 | planning-and-task-breakdown |
| 纯事实问题 | 直接回答 |
| 普通执行 | 直接做 |

## Standards

### Four Voices

| 声音 | 视角 |
|------|------|
| **Architect** | 正确性、可维护性、长期影响 |
| **Skeptic** | 质疑前提、简化、打破假设 |
| **Pragmatist** | 交付速度、用户价值、运维现实 |
| **Critic** | 边界情况、downside risk、失败模式 |

**关键：** Skeptic、Pragmatist、Critic 应该以独立 subagent 启动，只拿到问题和必要上下文，不携带完整对话历史。

### Problem Formulation

把决策写成一句话：
- 我们要决定什么？
- 关键约束是什么？
- 怎样算成功？

问题模糊时，先问一个澄清问题。

### Context Rules

- 代码库相关：取相关文件/片段，保持精简。
- 战略/通用：除非代码直接影响结论，否则不放代码。

## Checklist

- [ ] 真实问题已提炼成一句话
- [ ] 必要上下文已收集
- [ ] Architect 初始立场已写下
- [ ] 三个外部声音已独立启动
- [ ] 各声音拿到的是精简上下文，不是完整历史
- [ ] 共识区和分歧点已明确
- [ ] 最强反对意见已提取
- [ ] 反转条件已列出
- [ ] 最终推荐清晰明确

## Red Flags

- 诱导性问题
- 把自己的偏好塞进 subagent 上下文
- 把不同意见当噪音
- 变成投票表决（看论证质量，不看票数）
- 没有明确的 recommendation
- 没有 reversal conditions
