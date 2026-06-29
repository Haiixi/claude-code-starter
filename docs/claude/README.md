# Claude Code 知识库

本目录存放与 Claude Code 协作相关的最佳实践、项目架构决策和操作手册。

## 目录结构

```
docs/claude/
├── README.md              # 本文件
├── best-practices.md     # 项目级最佳实践
├── architecture/          # 架构决策和 ADR
└── playbooks/             # 常见场景操作手册
```

## Claude Code 会如何使用它

- `.claude/CLAUDE.md` 中的全局规则会在每次会话时加载。
- `docs/claude/` 中的内容不会自动加载，但可以通过 `@docs/claude/README.md` 等方式手动引用。
- 对于重要且频繁使用的规则，建议抽象为 `.claude/skills/<skill-name>/SKILL.md`。

## 添加新内容

1. 在对应子目录下新建 Markdown 文件。
2. 使用简洁的标题和条目化结构，便于 Claude 检索。
3. 如果是会频繁使用的规则，考虑是否需要提炼为 skill。
