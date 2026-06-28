# 推荐 Plugins

从官方 marketplace 安装：`/plugin install <name>@claude-plugins-official`。

**重要：以下命令必须在 Claude Code 会话内运行，不能放到 shell 脚本中执行。**

## 安装前检查

如果某个 plugin 安装失败，尝试：

```text
/plugin discover <name>
/plugin marketplace list
```

## Git 与协作

| Plugin | 安装命令 | 用途 |
|--------|----------|------|
| commit-commands | `/plugin install commit-commands@claude-plugins-official` | `/commit`、`/commit-push-pr` |
| pr-review-toolkit | `/plugin install pr-review-toolkit@claude-plugins-official` | PR 审查 agent |

## 代码质量

| Plugin | 安装命令 | 用途 |
|--------|----------|------|
| code-review | `/plugin install code-review@claude-plugins-official` | 自动化代码审查 |
| code-simplifier | `/plugin install code-simplifier@claude-plugins-official` | 简化代码同时保持行为 |

## 前端与功能开发

| Plugin | 安装命令 | 用途 |
|--------|----------|------|
| frontend-design | `/plugin install frontend-design@claude-plugins-official` | 高质量 UI 组件 |
| feature-dev | `/plugin install feature-dev@claude-plugins-official` | 端到端功能开发流程 |

## 自动化

| Plugin | 安装命令 | 用途 |
|--------|----------|------|
| hookify | `/plugin install hookify@claude-plugins-official` | 从对话模式生成自动化规则 |

## 安装步骤

1. 在 Claude Code 中运行 `/plugin`
2. 选择 Discover 或直接粘贴上面的安装命令
3. 安装完成后可用对应的 `/` 命令
