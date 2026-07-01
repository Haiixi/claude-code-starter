---
name: refactor-clean
description: 清理代码中的死代码、未使用文件、重复代码和临时文件。
triggers:
  - /refactor-clean
  - 清理代码
  - 清理死代码
---

# Refactor Clean

> 清理不是删得多，而是删得对。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 代码库累积了无用代码、重构前想减小影响面 |
| **Precondition** | 当前分支干净或已提交 |
| **Core rule** | 每次只清理一类问题，清理后运行测试 |

## Process

1. **选择清理类别**：一次只做一类（如未使用 import）。
2. **静态分析**：用 linter 快速定位明显问题。
3. **手动检查**：确认无动态使用、无跨文件引用。
4. **删除或合并**：删除死代码，合并重复代码。
5. **验证**：运行测试，确保没有破坏功能。
6. **汇总**：生成简要变更摘要。

## Output Format

```markdown
## Refactor Clean Summary

### Scope
- 清理类别：未使用 import
- 涉及文件：3 个

### Changes
| File | Action | Details |
|------|--------|---------|
| src/utils.ts | 删除 | 未引用的 `formatDate` |
| src/auth.ts | 合并 | 将两个校验函数合并 |

### Verification
- [ ] 测试通过
- [ ] Lint 通过
- [ ] 手动检查核心流程
```

## Examples

### Good

```typescript
// 合并重复校验
function validateEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
```

### Bad

```typescript
// 临时注释与调试代码残留
// const oldImpl = ...
console.log('debug', user);
```

## Standards

### 清理范围
- 未使用的 import / require
- 未引用的函数和变量
- 临时文件和日志文件
- 重复代码
- 已注释掉的代码块
- 调试用的 `console.log` / `print`

### 安全边界
- 不删除可能被动态使用的内容。
- 不在同一次修改中混合清理与功能变更。
- 清理前先确保分支干净。

## Checklist

- [ ] 当前分支已提交或干净
- [ ] 此次只清理一类问题
- [ ] 静态分析无警告
- [ ] 涉及动态使用的内容已确认
- [ ] 测试通过
- [ ] 生成了变更摘要

## Red Flags

- 清理前未提交就大规模删除
- 同时清理多类问题，难以回溯
- 删除后不运行测试
- 删除被其他代码动态引用的内容
- 将清理和功能变更混在同一次提交
