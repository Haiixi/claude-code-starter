#!/usr/bin/env bash
set -euo pipefail

# Claude Code Starter Kit 更新脚本
# 用法: ./scripts/update.sh [global|project]
# 功能: 同步公共规则，完全保留本地自定义规则

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
MODE="${1:-global}"
SEPARATOR="### ===== 公共规则结束，下方是您的自定义规则（不会被同步覆盖）====="

echo "=== Claude Code Starter Kit Updater ==="
echo "Mode: $MODE"

# 备份当前 CLAUDE.md
backup_claude_md() {
    local target="$1"
    if [ -f "$target" ]; then
        local backup="$(dirname "$target")/CLAUDE.md.bak.$(date +%Y%m%d%H%M%S)"
        cp "$target" "$backup"
        echo "已备份当前 CLAUDE.md: $backup"
    fi
}

# 合并 CLAUDE.md：仓库公共规则 + 本地自定义规则
merge_claude_md() {
    local remote_file="$1"
    local local_file="$2"

    local remote_claude=""
    local local_custom=""

    remote_claude="$(cat "$remote_file")"

    if [ -f "$local_file" ] && grep -qF "$SEPARATOR" "$local_file" 2>/dev/null; then
        # 提取分隔符之后的本地自定义规则
        local_custom="$(awk -v sep="$SEPARATOR" 'f; $0 == sep {f=1}' "$local_file" 2>/dev/null)"
    fi

    cat > "$local_file" << EOF
$remote_claude

$SEPARATOR
$local_custom
EOF
    echo "已合并 CLAUDE.md：更新公共规则，保留本地自定义规则"
}

# 处理 skills
sync_skills() {
    if [ -d "$REPO_ROOT/.claude/skills" ]; then
        mkdir -p "$HOME/.claude/skills"
        cp -r "$REPO_ROOT/.claude/skills/"* "$HOME/.claude/skills/"
        echo "已同步 skills"
    fi
}

# 处理知识库
sync_knowledge_base() {
    if [ -d "$REPO_ROOT/docs/claude" ]; then
        if [ "$MODE" = "global" ]; then
            mkdir -p "$HOME/.claude/knowledge-base"
            cp -r "$REPO_ROOT/docs/claude/"* "$HOME/.claude/knowledge-base/"
            echo "已同步知识库到: $HOME/.claude/knowledge-base"
        elif [ "$MODE" = "project" ]; then
            mkdir -p "$PWD/docs/claude"
            cp -r "$REPO_ROOT/docs/claude/"* "$PWD/docs/claude/"
            echo "已同步知识库到: $PWD/docs/claude"
        fi
    fi
}

# 主逻辑
if [ "$MODE" = "global" ]; then
    mkdir -p "$HOME/.claude"
    backup_claude_md "$HOME/.claude/CLAUDE.md"
    merge_claude_md "$REPO_ROOT/.claude/skills/claude-code-starter/templates/global-claude.md" "$HOME/.claude/CLAUDE.md"
    sync_skills
    sync_knowledge_base
elif [ "$MODE" = "project" ]; then
    mkdir -p "$PWD/.claude"
    backup_claude_md "$PWD/.claude/CLAUDE.md"
    merge_claude_md "$REPO_ROOT/.claude/skills/claude-code-starter/templates/project-claude.md" "$PWD/.claude/CLAUDE.md"
    sync_knowledge_base
else
    echo "错误: 未知模式 '$MODE'，请使用 global 或 project"
    exit 1
fi

# 刷新使用说明
cp "$REPO_ROOT/.claude/skills/claude-code-starter/USAGE.md" "$HOME/.claude/claude-starter/USAGE.md" 2>/dev/null || true
echo "已刷新使用说明"

echo ""
echo "=== 更新完成 ==="
echo "重启 Claude Code 后生效"
