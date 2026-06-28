---
name: git-commit
description: 根据当前 git 变更生成符合 Conventional Commits 规范的提交信息。
triggers:
  - /git-commit
  - 生成提交信息
  - commit message
---

# Git Commit

## 流程

1. 运行 `git diff --cached` 或 `git diff` 查看已暂存变更
2. 分析变更类型和范围
3. 生成符合 Conventional Commits 规范的提交信息
4. 让用户确认后再执行 `git commit`

## 提交格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

## 常用 type

| Type | 含义 |
|------|------|
| feat | 新功能 |
| fix | 修复 bug |
| docs | 文档变更 |
| style | 代码格式（不影响代码含义） |
| refactor | 重构 |
| perf | 性能优化 |
| test | 测试相关 |
| chore | 构建/工具相关 |

## 示例

```
feat(auth): add JWT token validation

- Implement middleware to validate tokens on protected routes
- Add tests for expired and malformed tokens

Closes #123
```
