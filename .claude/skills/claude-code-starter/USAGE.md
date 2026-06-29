# Claude Code Starter Kit — 使用说明

本文档由 `/claude-starter` 自动生成，记录当前环境已配置的规则、Skills、Plugins、MCP 和典型用法。

## 前置依赖

- Claude Code 已安装
- Node.js + npm（用于 GitHub / filesystem MCP server）
- `uv`（可选，用于 fetch MCP server，也可用 npx 替代）

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
| code-review | `/code-review` | 代码审查 | 五轴审查 |
| refactor-clean | `/refactor-clean` | 清理死代码 | 简易 |
| systematic-debugging | `/systematic-debugging` | bug 根因分析 | 专业 |
| verification-before-completion | `/verification-before-completion` | 完成前验证 | 专业 |
| planning-and-task-breakdown | `/plan` | 拆解复杂任务为可执行计划 | 专业 |
| test-driven-development | `/tdd` | 严格 TDD 开发 | 专业 |
| writing-skills | `/writing-skills` | 编写新 skill | 参考 |
| security-and-hardening | `/security` | 安全审查和加固 | 专业 |
| shipping-and-launch | `/ship` | 上线部署流程 | 专业 |
| ecc-council | `/council` | 多视角决策会议 | 专业 |
| ecc-agent-orchestration | `/delegate` | 多 agent 委托 | 专业 |

### 内置 skill 使用示例

```text
# 检查当前文件的代码规范
/coding-standards

# 按 TDD 流程给某个功能写测试
/test-workflow
给 order_service.create_order 写单元测试

# 根据当前 git 变更生成提交信息
/git-commit

# 审查当前改动
/code-review

# 清理未使用的 import 和变量
/refactor-clean

# 系统化调试 bug
/systematic-debugging
给 order_service.create_order 报 "Course not found" 的 bug 做根因分析

# 完成前验证
/verification-before-completion
检查这次提交是否满足验证清单

# 拆解复杂任务
/plan
给校区课表权限优化做实施计划

# 严格 TDD
/tdd
给 CourseScheduleService 写测试并实现

# 学习如何写 skill
/writing-skills

# 安全审查
/security
审查本次提交中的认证和输入验证代码

# 上线检查
/ship
给校区课表权限优化功能做上线前检查

# 多视角决策
/council
校区课表系统应该用 monorepo 还是 polyrepo

# 多 agent 委托
/delegate
让 planner 先拆解这个复杂任务
```

## 推荐 Skills 速查

以下 skill 需要额外安装。主要来源是 [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)。

```bash
# 安装全部推荐 skill
git clone https://github.com/addyosmani/agent-skills.git /tmp/agent-skills
cp -r /tmp/agent-skills/skills/{using-agent-skills,context-engineering,spec-driven-development,planning-and-task-breakdown,incremental-implementation,test-driven-development,code-review-and-quality,security-and-hardening,code-simplification,git-workflow-and-versioning,documentation-and-adrs,debugging-and-error-recovery,frontend-ui-engineering} ~/.claude/skills/
```

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

### 推荐 skill 使用示例

```text
# 新项目启动：先写 spec
/spec-driven-development
需求：给校区课表系统增加按角色查看课表的权限控制

# 有 spec 后拆任务
/planning-and-task-breakdown
基于上面的 spec，拆成可执行的开发任务

# 分步骤实现
/incremental-implementation
按上面拆的任务，先实现第一步：数据库权限字段迁移

# 写逻辑时同步写测试
/test-driven-development
给 CourseScheduleService.get_visible_schedules(role, campus_id) 写测试并实现

# 合并前审查
/code-review-and-quality
审查本次改动的所有文件

# 处理报错
/debugging-and-error-recovery
pytest 报错：ForeignKeyViolationError in test_order_create
```

## 推荐 Plugins 速查

```text
# 批量安装
/plugin install commit-commands@claude-plugins-official
/plugin install pr-review-toolkit@claude-plugins-official
/plugin install code-review@claude-plugins-official
/plugin install code-simplifier@claude-plugins-official
/plugin install frontend-design@claude-plugins-official
/plugin install feature-dev@claude-plugins-official
/plugin install hookify@claude-plugins-official
```

| Plugin | 安装命令 | 用途 |
|--------|----------|------|
| commit-commands | `/plugin install commit-commands@claude-plugins-official` | `/commit`、`/commit-push-pr` |
| pr-review-toolkit | `/plugin install pr-review-toolkit@claude-plugins-official` | PR 审查 agent |
| code-review | `/plugin install code-review@claude-plugins-official` | 自动化代码审查 |
| code-simplifier | `/plugin install code-simplifier@claude-plugins-official` | 简化代码 |
| frontend-design | `/plugin install frontend-design@claude-plugins-official` | 高质量 UI 组件 |
| feature-dev | `/plugin install feature-dev@claude-plugins-official` | 端到端功能开发 |
| hookify | `/plugin install hookify@claude-plugins-official` | 自动化规则/Hook |

### Plugin 使用示例

```text
# 根据当前 git diff 生成提交信息并提交
/commit

# 生成提交、推送到远端并创建 PR
/commit-push-pr

# 审查当前 PR 或分支
/pr-review-toolkit

# 让插件自动审查当前改动
/code-review

# 简化指定函数或文件
/code-simplifier
简化 CourseScheduleService 里的 get_query 方法

# 生成 UI 组件
/frontend-design
生成一个带分页和搜索的课程表列表组件

# 端到端开发一个功能
/feature-dev
实现按角色过滤课表的功能

# 把当前对话模式转成自动化 hook
/hookify
```

**注意**：以上命令必须在 Claude Code 会话内运行。如果安装失败，尝试 `/plugin discover <name>` 或 `/plugin marketplace list`。

## 常用 MCP

### 配置

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<your-github-token>"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/home/ubuntu/your-project"
      ]
    },
    "fetch": {
      "command": "uvx",
      "args": ["mcp-server-fetch"]
    }
  }
}
```

### MCP 使用示例

```text
# GitHub MCP：查看某个仓库的 open issues
@github 列出 haiixi/knowledge-base 的 open issues

# GitHub MCP：查看某个 PR 的变更摘要
@github 查看 haiixi/claude-code-starter PR #3 的改动

# Filesystem MCP：读取项目文件
@filesystem 读取 /home/ubuntu/knowledge-base/README.md

# Filesystem MCP：列出目录结构
@filesystem 列出 /home/ubuntu/knowledge-base/02-Projects

# Fetch MCP：抓取网页内容
@fetch https://code.claude.com/docs/en/discover-plugins
总结这个页面讲了什么
```

### 启用/禁用某个 MCP server

在 `.claude/settings.json` 中删除整个 server 节点即可禁用。

### MCP fetch 的 npx 替代方案

如果你没有 `uv`，可以把 `fetch` 改为：

```json
{
  "mcpServers": {
    "fetch": {
      "command": "npx",
      "args": ["-y", "mcp-server-fetch"]
    }
  }
}
```

## 工具组合速查

| 场景 | 推荐组合 |
|------|----------|
| 新项目启动 | `/claude-starter project` → `/spec-driven-development` |
| 日常开发 | `/incremental-implementation` + `/test-driven-development` |
| 调试报错 | `/debugging-and-error-recovery` |
| 提交前 | `/code-review` 或 `/code-review-and-quality` → `/git-commit` 或 `/commit` |
| 发 PR | `/pr-review-toolkit` + `/commit-push-pr` |
| 查文档/资料 | `@fetch` + `@github` |
| 快速生成 UI | `/frontend-design` |

## 典型新手工作流

```text
1. 进入新项目  → /claude-starter project
2. 需求不清晰   → 直接说出疑问，让 Claude 帮你理清
3. 有需求后    → /spec-driven-development
4. 拆任务      → /planning-and-task-breakdown
5. 写代码      → /incremental-implementation + /test-workflow
6. 提交前      → /code-review
7. 提交       → /git-commit 或 /commit
8. 发 PR       → /pr-review-toolkit 或 /commit-push-pr
```

## 更新本套件

1. 修改 `~/.claude/skills/claude-code-starter/recommended-skills.md` 或 `recommended-plugins.md`。
2. 运行 `/claude-starter docs` 重新生成使用说明。
3. 运行 `/claude-starter global` 或 `/claude-starter project` 更新对应的 `CLAUDE.md`。

## 常见问题

### Q: `/claude-starter` 没反应？
A: 确认 skill 已复制到 `~/.claude/skills/claude-code-starter/`，且 Claude Code 已重新加载 skills。

### Q: Plugin 安装失败？
A: 尝试 `/plugin discover <name>` 搜索正确 ID，或检查是否使用了正确的 marketplace 命名空间。

### Q: MCP server 无法启动？
A: 检查 `npx`/`uvx` 是否可用，以及 `settings.json` 中的 token/path 是否已替换为真实值。

### Q: 内置 skill 和外部 skill 冲突？
A: 同名 skill 中，Claude Code 通常加载最后安装的。建议外部 skill 安装稳定后，删除内置保底版本。

## 更新历史

- 1.1.0: 重写 SKILL.md 为可执行模型指令，修正推荐来源，区分内置/推荐 skill，补充 plugin/MCP 使用示例
