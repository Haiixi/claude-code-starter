---
name: git-commit
description: 根据当前 git 变更生成符合 Conventional Commits 规范的提交信息。
triggers:
  - /git-commit
  - 生成提交信息
  - commit message
---

# Git Commit

> 每次提交都是对未来自己的一封信。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 需要提交代码时，不确定提交信息怎么写 |
| **Format** | `<type>(<scope>): <subject>` |
| **Rule** | 第一行不超过 72 字符，语义化 type 和 scope |

## Process

1. **查看待提交变更**：运行 `git diff --cached` 或 `git diff`。
2. **分类变更**：确定 type 和 scope。
3. **编写提交信息**：主题 + 必要的 body/footer。
4. **用户确认**：展示生成的提交信息，待确认后执行 `git commit`。

## Output Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

| Field | Description |
|-------|-------------|
| `type` | 变更性质（feat/fix/docs/style/refactor/perf/test/chore） |
| `scope` | 影响模块（可省略） |
| `subject` | 简短描述，使用命令式语气 |
| `body` | 详细说明 why/how（可选） |
| `footer` | 关联 issue/BREAKING CHANGE（可选） |

## Examples

### Good

```
feat(auth): add JWT token validation

- Implement middleware to validate tokens on protected routes
- Add tests for expired and malformed tokens

Closes #123
```

### Bad

```
update code

fixed stuff
```

### Common Types

| Type | Use when |
|------|----------|
| `feat` | 新功能 |
| `fix` | 修复 bug |
| `docs` | 文档变更 |
| `style` | 代码格式（不影响逻辑） |
| `refactor` | 重构 |
| `perf` | 性能优化 |
| `test` | 测试相关 |
| `chore` | 构建/工具相关 |

## Standards

- 主题行以小写动词开头，不用句号结尾。
- 描述 what 和 why，而不是 how（how 在 body 中）。
- 同一提交只做一类变更，避免混合修改。

## Checklist

- [ ] 确认变更已暂存（`git diff --cached` 有内容）
- [ ] type 选择正确
- [ ] subject 简洁且描述清晰
- [ ] body 说明 why/how（如需要）
- [ ] 用户确认后再执行 `git commit`

## Red Flags

- `提交一下`、`更新代码`等空泛 subject
- 一个提交混合了 bug 修复、新功能和重构
- 第一行超过 72 字符
- 使用句号结尾 subject
