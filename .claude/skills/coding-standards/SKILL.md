---
name: coding-standards
description: 检查并确保代码符合项目编码规范，包括命名、格式、结构和最佳实践。
triggers:
  - /coding-standards
  - 检查代码规范
  - 编码规范
---

# Coding Standards

> 代码规范不是风格之争，而是减少认知负担。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 完成代码后自检、代码 review 前、重构前 |
| **Core rule** | 命名清晰、函数单一职责、无重复代码、完善错误处理 |
| **Output** | 按严重级排序的问题清单，每项带位置和修复建议 |

## Process

1. **阅读目标代码**：确定需要检查的文件或差异范围。
2. **对照检查清单**：逐条执行，不跳步。
3. **记录问题**：按严重级分类，给出具体位置和建议。
4. **确认修复方向**：优先修复：错误/安全 → 可维护性 → 风格。

## Output Format

```markdown
## Coding Standards Review

### 🔴 Critical（影响正确性或安全）
- [文件:行] 问题描述 → 修复建议

### 🟡 Warnings（影响可维护性）
- [文件:行] 问题描述 → 修复建议

### 🟢 Suggestions（可优化的小问题）
- [文件:行] 问题描述 → 修复建议
```

## Examples

### Good

```typescript
// 函数单一职责，命名清晰，有边界校验
function calculateDiscount(price: number, rate: number): number {
  if (price < 0 || rate < 0 || rate > 1) {
    throw new ValidationError('Invalid price or discount rate');
  }
  return price * rate;
}
```

### Bad

```typescript
// 多职责、魔法值、无边界校验
function calc(a: any, b: any) {
  if (a < 0) return 0;
  return a * 0.15; // 硬编码折扣率
}
```

## Standards

### 命名
- 函数/变量名称描述其目的，避免 `temp`、`data`、`obj`。
- 常量用大写 + 下划线，不用魔法字面量。

### 函数
- 一个函数只做一件事。
- 函数行数不宜过长（建议 ≤30 行）。

### 错误处理
- 所有外部输入在边界处校验。
- 不对敏感操作使用封装异常。

### 重复与冗余
- 删除未使用的 import、变量、函数。
- 合并重复代码为独立函数/类。

### 注释
- 注释说明**为什么**，而不是**做了什么**。
- 代码本身能表达的意思，不要写注释。

## Checklist

- [ ] 命名清晰且一致
- [ ] 函数单一职责
- [ ] 无重复代码
- [ ] 错误处理完善
- [ ] 无硬编码魔法值
- [ ] 注释说明"为什么"
- [ ] 无未使用的导入或变量
- [ ] 无明显性能问题

## Red Flags

- 变量名是 `temp`、`data`、`ret`、`flag`
- 函数超过 50 行且没有明确分块
- 一个函数里有 3+ 层嵌套
- 条件分支里重复的代码块
- 使用 `any` / `unknown` 但没有类型守卫
- 为了调试临时关闭类型检查
