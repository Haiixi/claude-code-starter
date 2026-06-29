# Claude Code Hook 说明

本文件记录当前项目为 Claude Code 配置的自动化 hook。

## PreToolUse Hook：项目上下文提示

### 位置

`.claude/settings.json` → `hooks.PreToolUse`

### 触发条件

匹配 `Bash` 工具，且命令字符串包含以下搜索工具之一：

```text
grep, rg, ripgrep, find, fd, ack, ag
```

### 行为

1. Hook 从工具调用的输入中提取 `command` 字段。
2. 如果命令属于搜索类工具，检查当前工作目录下是否存在 `docs/claude/README.md`。
3. 如果存在，向 Claude 附加一条上下文提示：

   > Project context available: docs/claude/README.md exists. Read it before searching raw files to understand project conventions and architecture.

4. 如果不存在，hook 静默返回，不影响工具执行。

### 设计理由

- **通用性**：不依赖 graphify、MCP 或任何第三方工具，只要有 `docs/claude/README.md` 就能生效。
- **最小侵入**：只在执行搜索命令前触发，不会打断普通文件读写或构建命令。
- **优先使用整理好的上下文**：提醒 Claude 先阅读项目维护者编写的文档，再决定是否搜索源码。

### 与 cubby 方案的区别

cubby 的 hook 针对 `graphify-out/graph.json`，提示 Claude 使用知识图谱；本项目的 hook 只检查 `docs/claude/README.md`，适用于没有 graphify 的普通项目。

### 如何禁用或修改

编辑 `.claude/settings.json`：

- 修改 `hooks.PreToolUse[0].hooks[0].command` 中的提示文案或匹配条件。
- 删除整个 `hooks` 节点即可禁用。
- 将触发文件从 `docs/claude/README.md` 改为其他路径，只需替换命令中的文件检查部分。

### 验证方法

在包含 `docs/claude/README.md` 的项目目录下运行：

```bash
echo '{"tool_input":{"command":"rg example"}}' | bash -c \
  'CMD=$(python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('\''tool_input'\'',d).get('\''command'\'','\''\''))"); \
   case "$CMD" in *grep*|*rg\ *|*ripgrep*|*find\ *|*fd\ *|*ack\ *|*ag\ *) \
     [ -f docs/claude/README.md ] \
       \&\& echo '\''{"hookSpecificOutput":{"hookEventName":"PreToolUse","additionalContext":"..."}}'\'' \
       || true ;; esac'
```

如果文件存在，应输出带 `additionalContext` 的 JSON；否则无输出。
