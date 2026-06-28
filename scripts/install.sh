#!/usr/bin/env bash
set -euo pipefail

# Claude Code Starter Kit 安装脚本
# 用法: ./scripts/install.sh [global|project]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
MODE="${1:-global}"
BACKUP_DIR=""

echo "=== Claude Code Starter Kit Installer ==="
echo "Mode: $MODE"

# 检查依赖
if ! command -v claude >/dev/null 2>&1; then
    echo "警告: 未检测到 Claude Code，请先安装。"
fi

if ! command -v npx >/dev/null 2>&1; then
    echo "警告: 未检测到 npx，MCP 服务可能无法正常运行。"
fi

# 备份现有配置
if [ -d "$HOME/.claude" ]; then
    BACKUP_DIR="$HOME/.claude.bak.$(date +%Y%m%d%H%M%S)"
    echo "备份现有配置到: $BACKUP_DIR"
    cp -r "$HOME/.claude" "$BACKUP_DIR"
fi

# 确保目录存在
mkdir -p "$HOME/.claude/skills"
mkdir -p "$HOME/.claude/claude-starter"

# 复制 skill 文件
if [ -d "$REPO_ROOT/.claude/skills" ]; then
    cp -r "$REPO_ROOT/.claude/skills/"* "$HOME/.claude/skills/"
    echo "已安装 skills"
fi

# 处理 CLAUDE.md
if [ "$MODE" = "global" ]; then
    cp "$REPO_ROOT/.claude/skills/claude-code-starter/templates/global-claude.md" "$HOME/.claude/CLAUDE.md"
    echo "已安装全局 CLAUDE.md: $HOME/.claude/CLAUDE.md"
elif [ "$MODE" = "project" ]; then
    mkdir -p "$PWD/.claude"
    cp "$REPO_ROOT/.claude/skills/claude-code-starter/templates/project-claude.md" "$PWD/.claude/CLAUDE.md"
    echo "已安装项目级 CLAUDE.md: $PWD/.claude/CLAUDE.md"
else
    echo "错误: 未知模式 '$MODE'，请使用 global 或 project"
    exit 1
fi

# 处理 settings.json
if [ -f "$HOME/.claude/settings.json" ]; then
    echo "注意: $HOME/.claude/settings.json 已存在，不会覆盖。"
    echo "请手动将 $REPO_ROOT/.claude/settings.json 中的 MCP 配置合并到现有 settings.json。"
else
    cp "$REPO_ROOT/.claude/settings.json" "$HOME/.claude/settings.json"
    echo "已创建 settings.json，请修改其中的占位符"
fi

# 生成 plugin 安装命令文件
awk '/^## /{p=0} /^## 推荐 Plugins/{p=1} p && /^\| / && $2 != "Plugin" && $2 != "---"' \
    "$REPO_ROOT/.claude/skills/claude-code-starter/recommended-plugins.md" | \
    awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); gsub(/^[ \t]+|[ \t]+$/, "", $3); print $3}' | \
    sed 's/^\([ \t]*\)/\1/' > "$HOME/.claude/claude-starter/install-plugins.md"

# 生成使用说明
cp "$REPO_ROOT/.claude/skills/claude-code-starter/USAGE.md" "$HOME/.claude/claude-starter/USAGE.md"

echo ""
echo "=== 安装完成 ==="
echo "下一步:"
echo "1. 编辑 $HOME/.claude/settings.json，填充 GitHub token 和 filesystem 访问路径"
echo "2. 在 Claude Code 中运行 /claude-starter docs 刷新文档"
echo "3. 按照 $HOME/.claude/claude-starter/install-plugins.md 安装推荐 plugins"
if [ -n "$BACKUP_DIR" ]; then
    echo "4. 原配置已备份至: $BACKUP_DIR"
fi
