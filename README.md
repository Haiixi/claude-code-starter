---
title: Claude Code Starter Kit
created: 2026-06-28
updated: 2026-06-28
type: project
tags: [programming, framework]
sources:
  - https://github.com/Haiixi/claude-code-starter
confidence: high
---

# Claude Code Starter Kit

结合了两套方案优势的 Claude Code 初始化工具包：

- **你本地生成的 `claude-code-starter`**：生产级 CLAUDE.md、项目模板、完整的工作流
- **我生成的 `claude-code-setup`**：MCP 配置、中文触发词、内置保底 Skills

## 前置依赖

- Claude Code 已安装
- Node.js + npm（用于 npx MCP servers）
- Python + `uv`（可选，用于 `uvx mcp-server-fetch`，也可换成 npx 方案）

## 包含内容

| 文件/目录 | 说明 |
|------------|------|
| `.claude/CLAUDE.md` | 默认全局规则模板 |
| `.claude/settings.json` | MCP 与 PreToolUse hook 配置模板 |
| `.claude/skills/claude-code-starter/` | 主引导 Skill |
| `.claude/skills/{coding-standards,test-workflow,git-commit,code-review,refactor-clean,systematic-debugging,verification-before-completion,test-driven-development,planning-and-task-breakdown,writing-skills,security-and-hardening,shipping-and-launch,ecc-council,ecc-agent-orchestration}` | 内置保底 Skills |

## 安装方法

### Windows

```powershell
# 1. 备份现有配置（如果存在）
if (Test-Path "$env:USERPROFILE\.claude") {
    Move-Item "$env:USERPROFILE\.claude" "$env:USERPROFILE\.claude.bak.$(Get-Date -Format yyyyMMddHHmmss)"
}

# 2. 将本目录下的 .claude 复制到用户目录
Copy-Item -Recurse -Force ".\.claude" "$env:USERPROFILE\.claude"
```

### macOS / Linux

```bash
# 1. 备份现有配置（如果存在）
[ -d ~/.claude ] && mv ~/.claude ~/.claude.bak.$(date +%Y%m%d%H%M%S)

# 2. 复制
mkdir -p ~/.claude
cp -r .claude/* ~/.claude/
```

### 项目级

```bash
# 为当前项目复制
cp -r .claude <your-project>/.claude
```

## 使用

安装完成后，在 Claude Code 中运行：

```text
/claude-starter              # 交互式向导
/claude-starter global       # 全局配置
/claude-starter project      # 当前项目配置
/claude-starter docs         # 刷新使用说明
```

## 配置完成后

1. 修改 `.claude/CLAUDE.md` 中需要个性化的部分
2. 在 `.claude/settings.json` 中填入 GitHub token 和允许访问的路径
3. Starter 内置的 PreToolUse hook 会在执行 Bash 搜索命令前，检查当前项目是否存在 `docs/claude/README.md`；存在时会提醒 Claude 先阅读项目文档
4. 按照 `USAGE.md` 安装推荐的 Skills 和 Plugins

## 卸载/回滚

```bash
# 移除安装
rm -rf ~/.claude/skills/claude-code-starter
rm -rf ~/.claude/skills/{coding-standards,test-workflow,git-commit,code-review,refactor-clean,systematic-debugging,verification-before-completion,test-driven-development,planning-and-task-breakdown,writing-skills,security-and-hardening,shipping-and-launch,ecc-council,ecc-agent-orchestration}
rm -f ~/.claude/CLAUDE.md
rm -f ~/.claude/settings.json
rm -rf ~/.claude/claude-starter
rm -rf ~/.claude/knowledge-base

# 如果之前备份过，可以恢复
mv ~/.claude.bak.<timestamp> ~/.claude
```

## 与原始方案的对比

| 特性 | 合并版 | 方案 A（你本地版） | 方案 B（知识库旧版） |
|------|--------|---------------------|---------------------|
| 命令式 Skill | ✅ | ✅（修复了 `trigger` 写法） | ❌ |
| 高质量 CLAUDE.md | ✅ | ✅ | ❌ |
| 项目模板 | ✅ | ✅ | ❌ |
| MCP 配置 | ✅ | ❌ | ✅ |
| 内置保底 Skills | ✅ | ❌ | ✅ |
| 推荐 Plugins | ✅ | ✅ | ❌ |
| 中文 | ✅ | ❌ | ✅ |

## 更新历史

- 2026-06-28: 整合优化，创建合并版
- 2026-06-28: 重写 SKILL.md 为可执行 prompt，修正推荐来源，改进模板
