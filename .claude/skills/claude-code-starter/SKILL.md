---
name: claude-code-starter
description: 一键初始化 Claude Code 最佳实践配置，安装 CLAUDE.md、推荐 Skills、Plugins 和 MCP，并生成使用说明。
version: 1.1.0
triggers:
  - /claude-starter
  - /claude-code-starter
---

# /claude-starter

在新电脚或新项目中快速搭建 Claude Code 最佳实践环境。

## 使用场景

- 新机器或刚安装 Claude Code
- 新成员入职
- 希望统一规则、Skills、Plugins 和文档基线

## 用法

```text
/claude-starter              # 交互式向导
/claude-starter global       # 安装用户级 CLAUDE.md + 使用说明
/claude-starter project      # 为当前项目生成 CLAUDE.md + 使用说明
/claude-starter docs         # 仅刷新使用说明
```

## 执行指令

当用户输入 `/claude-starter` 或 `/claude-code-starter` 时，按以下步骤执行。

### 步骤 1 — 确定模式

1. 使用 `Read` 工具阅读用户的完整消息。
2. 如果消息中包含 `global`，设置 `MODE=global`。
3. 如果消息中包含 `project`，设置 `MODE=project`。
4. 如果消息中包含 `docs`，设置 `MODE=docs`。
5. 如果不包含以上任何一个，向用户询问：
   ```text
   请选择模式：
   1. global  — 配置用户级 ~/.claude/CLAUDE.md
   2. project — 为当前项目生成 ./.claude/CLAUDE.md
   3. docs    — 仅刷新使用说明
   ```

### 步骤 2 — 检测环境

1. 使用 `Bash` 工具运行：
   ```bash
   echo "$HOME/.claude"
   mkdir -p "$HOME/.claude/claude-starter"
   ```
2. 记住以下路径：
   - `CLAUDE_HOME = $HOME/.claude`
   - `SKILL_DIR = $CLAUDE_HOME/skills/claude-code-starter`

### 步骤 3 — 安装 CLAUDE.md

1. 根据 `MODE` 选择源模板：
   - `global`: `$SKILL_DIR/templates/global-claude.md` → `$CLAUDE_HOME/CLAUDE.md`
   - `project`: `$SKILL_DIR/templates/project-claude.md` → `./.claude/CLAUDE.md`
   - `docs`: 跳过
2. 使用 `Read` 检查目标路径是否已存在。
3. 如果目标已存在：
   - 使用 `Read` 读取前 40 行。
   - 向用户展示摘要并询问：`overwrite / skip / backup-and-overwrite`。
   - 如果用户选择 `backup-and-overwrite`，先使用 `Bash` 复制为 `target.<timestamp>.bak`。
4. 使用 `Write` 将模板写入目标路径。
5. 输出：`已安装 <mode> CLAUDE.md 位于 <path>`。

### 步骤 4 — 验证推荐 Skills

1. 使用 `Read` 工具读取 `$SKILL_DIR/recommended-skills.md`。
2. 对每个 skill 名称，使用 `Bash` 检查 `$CLAUDE_HOME/skills/<name>/SKILL.md` 是否存在。
3. 生成状态表：
   ```markdown
   | Skill | 状态 | 安装来源 |
   |-------|------|----------|
   | <name> | 已安装 / 未安装 | <source> |
   ```
4. 不自动安装缺失 skill，只是展示表格和安装命令。

### 步骤 5 — 生成 Plugin 安装命令

1. 使用 `Read` 工具读取 `$SKILL_DIR/recommended-plugins.md`。
2. 为每个 plugin 生成 `/plugin install <name>@claude-plugins-official`。
3. 使用 `Write` 将命令列表写入 `$CLAUDE_HOME/claude-starter/install-plugins.md`。
4. 告诉用户这些命令需要在 **Claude Code 会话内** 运行。

### 步骤 6 — 安装 MCP 配置

1. 使用 `Read` 工具读取 `$SKILL_DIR/recommended-mcp.json`。
2. 使用 `Read` 工具检查 `$CLAUDE_HOME/settings.json` 是否存在。
3. 如果 `settings.json` 不存在，使用 `Write` 直接写入 `recommended-mcp.json`。
4. 如果已存在：
   - 使用 `Bash` 工具或者自己精确合并 `mcpServers`。
   - 同名 server 以用户现有配置为准，不覆盖。
   - 需要用户确认后才修改。
5. 提醒用户填充 GitHub token 和 filesystem 允许访问路径。

### 步骤 7 — 同步知识库和生成使用文档

1. 使用 `Bash` 工具检查 `docs/claude/` 目录是否存在。
2. 如果 `MODE=global` 或 `MODE=project` 且当前项目下存在 `docs/claude/`：
   - 向用户报告知识库路径。
   - 建议将重要规则提炼为 skill。
3. 使用 `Read` 工具读取 `$SKILL_DIR/USAGE.md`。
4. 在文档末尾附加：
   - 生成时间
   - CLAUDE.md 安装状态
   - Skills 验证表
   - Plugin 安装命令
   - MCP 配置状态
   - 知识库路径
5. 使用 `Write` 工具写入 `$CLAUDE_HOME/claude-starter/USAGE.md`。
6. 如果 `MODE=project`，同时写入 `./CLAUDE_USAGE.md`。

### 步骤 8 — 最终报告

1. 输出简洁摘要：
   - 哪些文件已创建/更新
   - 哪些步骤被跳过
   - 接下来需要手动执行的命令
   - 如何继续使用（`/claude-starter docs` 刷新文档）

## 失败处理

- 如果 `$SKILL_DIR` 或任何必需的打包文件缺失，停止并报告缺失路径。
- 如果读写操作失败，报告错误并停止。
- 如果用户拒绝覆盖，跳过该步骤并继续。

## 更新记录

- 1.1.0: 移除 `disable-model-invocation: true`，重写为可执行模型指令，修正推荐来源
