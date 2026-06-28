# Claude Code Starter Kit — 使用说明

本文档由 `/claude-starter` 自动生成，记录当前环境已配置的规则、Skills 和 Plugins。

## 前置依赖

- Claude Code 已安装
- Node.js + npm（用于 GitHub / filesystem MCP server）
- `uv`（可选，用于 fetch MCP server）

## 快速开始

```text
# 新机器/全局配置
/claude-starter global

# 给当前项目生成 CLAUDE.md
/claude-starter project

# 仅刷新这份说明
/claude-starter docs
```

## 内置保底 Skills

以下 skill 随本配置包安装，无需额外下载，但功能较简单，仅作为临时替代。

| Skill | 触发词 | 什么时候用 | 定位 |
|-------|--------|------------|------|
| coding-standards | `/coding-standards` | 检查代码规范 | 简易 |
| test-workflow | `/test-workflow` | TDD 流程 | 简易 |
| git-commit | `/git-commit` | 生成规范提交信息 | 简易 |
| code-review | `/code-review` | 代码审查 | 简易 |
| refactor-clean | `/refactor-clean` | 清理死代码 | 简易 |

## 推荐 Skills 速查

以下 skill 需要额外安装。主要来源是 [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)。

| Skill | 触发方式 | 什么时候用 |
|-------|----------|------------|
| using-agent-skills | `/using-agent-skills` | 不确定该用哪个 skill 时 |
| context-engineering | `/context-engineering` | 开始新会话、切换任务、上下文质量下降 |
| spec-driven-development | `/spec-driven-development` | 新项目/新功能/重大改动，先写 spec |
| planning-and-task-breakdown | `/planning-and-task-breakdown` | 有 spec 后拆成任务 |
| incremental-implementation | `/incremental-implementation` | 多文件实现，切片交付 |
| test-driven-development | `/test-driven-development` | 写逻辑、修 bug、改行为 |
| code-review-and-quality | `/code-review-and-quality` | 合并前审查 |
| security-and-hardening | `/security-and-hardening` | 处理用户输入、认证、外部 API |
| code-simplification | `/code-simplification` | 代码能跑但可读性差 |
| git-workflow-and-versioning | `/git-workflow-and-versioning` | 提交、分支、合并 |
| documentation-and-adrs | `/documentation-and-adrs` | 写文档、做架构决策 |
| debugging-and-error-recovery | `/debugging-and-error-recovery` | 测试失败、构建报错、行为异常 |
| frontend-ui-engineering | `/frontend-ui-engineering` | 构建或修改 UI |

## 推荐 Plugins 速查

| Plugin | 安装命令 | 用途 |
|--------|----------|------|
| commit-commands | `/plugin install commit-commands@claude-plugins-official` | `/commit`、`/commit-push-pr` |
| pr-review-toolkit | `/plugin install pr-review-toolkit@claude-plugins-official` | PR 审查 agent |
| code-review | `/plugin install code-review@claude-plugins-official` | 自动化代码审查 |
| code-simplifier | `/plugin install code-simplifier@claude-plugins-official` | 简化代码 |
| frontend-design | `/plugin install frontend-design@claude-plugins-official` | 高质量 UI 组件 |
| feature-dev | `/plugin install feature-dev@claude-plugins-official` | 端到端功能开发 |
| hookify | `/plugin install hookify@claude-plugins-official` | 自动化规则/Hook |

**注意**：以上命令必须在 Claude Code 会话内运行。如果安装失败，尝试 `/plugin discover <name>` 或 `/plugin marketplace list`。

## 常用 MCP

| Server | 用途 | 配置注意 |
|--------|------|----------|
| github | 访问 GitHub Issues/PRs | 填充 `GITHUB_PERSONAL_ACCESS_TOKEN` |
| filesystem | 读写指定路径下的文件 | 修改 `<allowed-path>` |
| fetch | 抓取网页内容 | 需要 `uv`或替换为 npx 方案 |

### 启用/禁用某个 MCP server

在 `.claude/settings.json` 中：

```json
{
  "mcpServers": {
    "fetch": {
      "command": "uvx",
      "args": ["mcp-server-fetch"]
    }
  }
}
```

删除整个 server 节点即可禁用。

## 典型新手工作流

```text
1. 进入新项目  → /claude-starter project
2. 需求不清晰   → 直接说出疑问，让 Claude 帮你理清
3. 有需求后    → /spec-driven-development
4. 拆任务      → /planning-and-task-breakdown
5. 写代码      → /incremental-implementation + /test-workflow
6. 提交前      → /code-review
7. 提交       → /git-commit 或 /commit
```

## 更新本套件

1. 修改 `~/.claude/skills/claude-code-starter/recommended-skills.md` 或 `recommended-plugins.md`。
2. 运行 `/claude-starter docs` 重新生成使用说明。
3. 运行 `/claude-starter global` 或 `/claude-starter project` 更新对应的 `CLAUDE.md`。

## 更新历史

- 1.1.0: 重写 SKILL.md 为可执行模型指令，修正推荐来源，区分内置/推荐 skill
