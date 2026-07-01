---
name: claude-code-starter
description: 一键初始化 Claude Code 最佳实践配置，安装 CLAUDE.md、推荐 Skills、Plugins 和 MCP，并生成使用说明。
version: 1.2.0
triggers:
  - /claude-starter
  - /claude-code-starter
---

# /claude-starter

> 在新电脚或新项目中快速搭建 Claude Code 最佳实践环境。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 新机器、刚安装 Claude Code、新成员入职、想统一规则基线 |
| **Modes** | `global` / `project` / `docs` |
| **Core rule** | 不自动覆盖用户现有配置，除非用户确认 |
| **Output** | 安装报告 + USAGE.md + 推荐项检查表 |

## Process

1. **确定模式**：根据用户消息判断 `global` / `project` / `docs`，否则询问。
2. **检测环境**：创建 `$HOME/.claude/claude-starter` 目录。
3. **安装 CLAUDE.md**：根据模式写入对应位置。
4. **验证推荐 Skills**：检查是否已安装，生成状态表，不自动安装。
5. **生成 Plugin 安装命令**：写入安装命令列表。
6. **安装 MCP 与 Hooks**：合并到 `settings.json`，需要用户确认。
7. **同步知识库与生成文档**：生成或刷新 `USAGE.md`。
8. **输出最终报告**：摘要 + 待手动执行命令。

## Usage

```text
/claude-starter              # 交互式向导
/claude-starter global       # 安装用户级 CLAUDE.md + 使用说明
/claude-starter project      # 为当前项目生成 .claude/CLAUDE.md + 使用说明
/claude-starter docs         # 仅刷新使用说明
```

## Output Format

```markdown
## Claude Code Starter 安装报告

### 已安装
- CLAUDE.md → [path]
- USAGE.md → [path]

### 推荐 Skills 状态
| Skill | 状态 | 安装来源 |
|-------|------|----------|
| ... | ... | ... |

### 推荐 Plugins
```
/plugin install ...
```

### MCP 状态
- GitHub MCP: 已配置 / 待填充 token
- Filesystem MCP: 待配置允许路径

### 下一步
1. 填充 GitHub token
2. 配置 filesystem 允许路径
3. 在项目内运行 `/claude-starter docs` 刷新文档
```

## Examples

### Global Install

```text
User: /claude-starter global
Agent: 已安装 ~/.claude/CLAUDE.md。
       推荐 skills 验证表：...
       plugin 安装命令已写入 ~/.claude/claude-starter/install-plugins.md。
       请手动填充 GitHub token。
```

### Project Install

```text
User: /claude-starter project
Agent: 已安装 ./.claude/CLAUDE.md 和 ./CLAUDE_USAGE.md。
       建议将项目重要规则提炼为 skill。
```

## Standards

### 步骤 1 — 确定模式

- `global` → 用户级 `~/.claude/CLAUDE.md`
- `project` → 当前项目 `./.claude/CLAUDE.md`
- `docs` → 仅刷新使用说明

如果消息中不含模式，向用户展示选项：
```text
请选择模式：
1. global  — 配置用户级 ~/.claude/CLAUDE.md
2. project — 为当前项目生成 ./.claude/CLAUDE.md
3. docs    — 仅刷新使用说明
```

### 步骤 2 — 检测环境

使用 `Bash` 工具运行：
```bash
echo "$HOME/.claude"
mkdir -p "$HOME/.claude/claude-starter"
```

记住路径：
- `CLAUDE_HOME = $HOME/.claude`
- `SKILL_DIR = $CLAUDE_HOME/skills/claude-code-starter`

### 步骤 3 — 安装 CLAUDE.md

- `global`: `$SKILL_DIR/templates/global-claude.md` → `$CLAUDE_HOME/CLAUDE.md`
- `project`: `$SKILL_DIR/templates/project-claude.md` → `./.claude/CLAUDE.md`
- `docs`: 跳过

如果目标已存在：
1. `Read` 前 40 行。
2. 向用户展示摘要并询问：`overwrite / skip / backup-and-overwrite`。
3. 如果选择 `backup-and-overwrite`，先复制为 `target.<timestamp>.bak`。

### 步骤 4 — 验证推荐 Skills

1. `Read` `$SKILL_DIR/recommended-skills.md`。
2. 对每个 skill 名称，`Bash` 检查 `$CLAUDE_HOME/skills/<name>/SKILL.md` 是否存在。
3. 生成状态表。
4. **不自动安装**缺失 skill，只是展示表格和安装命令。

### 步骤 5 — 生成 Plugin 安装命令

1. `Read` `$SKILL_DIR/recommended-plugins.md`。
2. 为每个 plugin 生成 `/plugin install <name>@claude-plugins-official`。
3. `Write` 到 `$CLAUDE_HOME/claude-starter/install-plugins.md`。
4. 告诉用户这些命令需要在 **Claude Code 会话内** 运行。

### 步骤 6 — 安装 MCP 与 PreToolUse Hook 配置

1. `Read` `$SKILL_DIR/recommended-mcp.json`。
2. `Read` `$CLAUDE_HOME/settings.json` 检查是否存在。
3. 如果不存在，`Write` 直接写入 `recommended-mcp.json`。
4. 如果已存在：
   - 精确合并 `mcpServers` 和 `hooks`。
   - 同名 server 以用户现有配置为准，不覆盖。
   - 需要用户确认后才修改。
5. 提醒用户填充 GitHub token 和 filesystem 允许访问路径。

### 步骤 7 — 同步知识库与生成使用文档

1. `Bash` 检查 `docs/claude/` 目录是否存在。
2. 如果 `MODE=global` 或 `MODE=project` 且当前项目下存在 `docs/claude/`：
   - 向用户报告知识库路径。
   - 建议将重要规则提炼为 skill。
3. `Read` `$SKILL_DIR/USAGE.md`。
4. 在文档末尾附加：生成时间、CLAUDE.md 安装状态、Skills 验证表、Plugin 安装命令、MCP 配置状态、知识库路径。
5. `Write` 到 `$CLAUDE_HOME/claude-starter/USAGE.md`。
6. 如果 `MODE=project`，同时写入 `./CLAUDE_USAGE.md`。

### 步骤 8 — 最终报告

输出简洁摘要：
- 哪些文件已创建/更新
- 哪些步骤被跳过
- 接下来需要手动执行的命令
- 如何继续使用（`/claude-starter docs` 刷新文档）

## Failure Handling

- 如果 `$SKILL_DIR` 或任何必需的打包文件缺失，停止并报告缺失路径。
- 如果读写操作失败，报告错误并停止。
- 如果用户拒绝覆盖，跳过该步骤并继续。

## Checklist

- [ ] 模式已确定（global/project/docs）
- [ ] 目标 CLAUDE.md 已安装/更新
- [ ] 推荐 Skills 状态表已生成
- [ ] Plugin 安装命令已生成
- [ ] MCP/Hooks 配置已合并
- [ ] 用户已被提醒填充 token 和路径
- [ ] USAGE.md 已生成
- [ ] 最终报告已输出

## Red Flags

- 不询问用户就覆盖现有配置
- 自动安装了缺失的 skills/plugins（应该只展示）
- 忽略 settings.json 合并中的冲突
- 未告知用户需要手动填充的凭证
- 文档生成了但没有告诉用户在哪里

## Changelog

- 1.2.0: 重构为渐进式披露结构
- 1.1.0: 移除 `disable-model-invocation: true`，重写为可执行模型指令，修正推荐来源
