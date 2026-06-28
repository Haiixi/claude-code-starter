# 推荐 Skills

以下 skill 可从对应来源安装。安装方式：将 skill 文件夹复制到 `~/.claude/skills/<name>/`。

**主要来源**：[addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — 生产级工程 skill 集合。

```bash
# 安装单个 skill
git clone https://github.com/addyosmani/agent-skills.git /tmp/agent-skills
cp -r /tmp/agent-skills/skills/<skill-name> ~/.claude/skills/

# 或者安装全部
cp -r /tmp/agent-skills/skills/* ~/.claude/skills/
```

## 核心工作流

| Skill | 作用 | 安装来源 |
|-------|------|----------|
| `using-agent-skills` | 发现并调用合适的 workflow skill | https://github.com/addyosmani/agent-skills/tree/main/skills/using-agent-skills |
| `context-engineering` | 在合适时机加载合适上下文 | https://github.com/addyosmani/agent-skills/tree/main/skills/context-engineering |
| `spec-driven-development` | 先写规格再编码 | https://github.com/addyosmani/agent-skills/tree/main/skills/spec-driven-development |
| `incremental-implementation` | 分小步骤交付 | https://github.com/addyosmani/agent-skills/tree/main/skills/incremental-implementation |
| `test-driven-development` | 先写失败测试，再让它通过 | https://github.com/addyosmani/agent-skills/tree/main/skills/test-driven-development |

## 代码质量

| Skill | 作用 | 安装来源 |
|-------|------|----------|
| `code-review-and-quality` | 合并前多维度审查 | https://github.com/addyosmani/agent-skills/tree/main/skills/code-review-and-quality |
| `security-and-hardening` | OWASP 防御与输入验证 | https://github.com/addyosmani/agent-skills/tree/main/skills/security-and-hardening |
| `code-simplification` | 简化代码同时保持行为不变 | https://github.com/addyosmani/agent-skills/tree/main/skills/code-simplification |
| `frontend-ui-engineering` | 生产级 UI 构建 | https://github.com/addyosmani/agent-skills/tree/main/skills/frontend-ui-engineering |

## Git 与协作

| Skill | 作用 | 安装来源 |
|-------|------|----------|
| `git-workflow-and-versioning` | 规范提交和历史 | https://github.com/addyosmani/agent-skills/tree/main/skills/git-workflow-and-versioning |
| `documentation-and-adrs` | 记录决策和文档 | https://github.com/addyosmani/agent-skills/tree/main/skills/documentation-and-adrs |

## 规划与调试

| Skill | 作用 | 安装来源 |
|-------|------|----------|
| `planning-and-task-breakdown` | 把工作拆成有序任务 | https://github.com/addyosmani/agent-skills/tree/main/skills/planning-and-task-breakdown |
| `debugging-and-error-recovery` | 系统性根因调试 | https://github.com/addyosmani/agent-skills/tree/main/skills/debugging-and-error-recovery |

## 内置保底 Skills

如果外部 skill 暂时无法下载，以下技能随本配置包提供。它们的功能较简单，仅作为临时替代。

| Skill | 触发词 | 定位 |
|-------|--------|------|
| `coding-standards` | `/coding-standards` | 简易代码规范检查 |
| `test-workflow` | `/test-workflow` | 简易 TDD 流程 |
| `git-commit` | `/git-commit` | 简易提交信息生成 |
| `code-review` | `/code-review` | 简易代码审查 |
| `refactor-clean` | `/refactor-clean` | 简易清理死代码 |

## 更新本 skill 的推荐 skills

如需增加或更新推荐来源，修改 `$SKILL_DIR/recommended-skills.md`，然后运行 `/claude-starter docs` 刷新使用说明。
