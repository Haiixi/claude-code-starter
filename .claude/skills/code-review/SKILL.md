---
name: code-review
description: Conducts multi-axis code review. Use before merging any change, when reviewing code written by yourself, another agent, or a human.
triggers:
  - /code-review
  - 代码审查
  - review
---

# Code Review

> Every change gets reviewed before merge — no exceptions. Approve when it definitely improves overall code health, even if it isn't perfect.

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | Before merging any PR/change, after feature completion, when evaluating another agent's code |
| **Axes** | Correctness, Readability, Architecture, Security, Performance |
| **Output** | Severity-labeled findings + verdict |

## Process

1. **Understand the change**: Read the diff and related context.
2. **Review five axes**: Correctness → Readability → Architecture → Security → Performance.
3. **Label findings**: Critical / Important / Nit / Optional / FYI.
4. **Summarize**: Verdict with clear action items.
5. **Follow up**: Re-review after fixes.

## Output Format

```markdown
## Review: [Change title]

### Summary
[Brief overall assessment]

### Findings

| Severity | Axis | Issue | Location | Suggestion |
|----------|------|-------|----------|------------|
| Critical | Security | 硬编码 API key | src/config.ts | 改用环境变量 |
| Important | Correctness | 未处理空值 | src/user.ts:42 | 添加 null check |
| Nit | Readability | 变量名 temp | src/utils.ts:15 | 改为具体名称 |

### Verdict
- [ ] Approve — Ready to merge
- [ ] Request changes — Issues must be addressed
```

## Examples

### Good Finding

```markdown
**Important | Architecture**
Location: `src/orders/service.ts:58`
Issue: Service directly calls external payment API without an abstraction.
Suggestion: Introduce `PaymentGateway` interface so tests can stub and provider can be swapped.
```

### Bad Finding

```markdown
This looks wrong.
```

## Standards

### 1. Correctness
- Matches spec/task requirements.
- Edge cases handled (null, empty, boundary values).
- Error paths handled, not just happy path.
- Tests exist and test the right things.

### 2. Readability & Simplicity
- Names are descriptive and consistent.
- Control flow is straightforward.
- Code is organized logically.
- Abstractions earn their complexity.

### 3. Architecture
- Follows existing patterns or introduces one deliberately.
- Maintains clean module boundaries.
- Avoids unnecessary duplication.
- Dependencies flow in the right direction.

### 4. Security
- User input is validated and sanitized.
- Secrets stay out of code, logs, and version control.
- Auth/authz checked where needed.
- SQL queries parameterized.
- Outputs encoded to prevent XSS.
- External data treated as untrusted.

### 5. Performance
- No N+1 query patterns.
- No unbounded loops or unconstrained data fetching.
- No synchronous operations that should be async.
- Pagination on list endpoints.
- No large objects in hot paths.

### Security Scan Focus
- 硬编码密钥 / token / 密码
- SQL 注入（字符串拼接）
- 命令注入（`os.system`、`subprocess shell=True`）
- 不安全反序列化（`pickle.loads`）
- `eval()` / `exec()` 调用
- 路径穿越

### Severity Labels

| Prefix | Meaning | Action |
|--------|---------|--------|
| **Critical:** | Blocks merge | Security vulnerability, data loss, broken functionality |
| **Important:** | Should fix before merge | Logic error, maintainability issue |
| **Nit:** | Minor, optional | Formatting, style preferences |
| **Optional:** / **Consider:** | Suggestion | Worth considering but not required |
| **FYI** | Informational only | No action needed |

## Checklist

- [ ] I understand what this change does and why
- [ ] Change matches spec/task requirements
- [ ] Edge cases handled
- [ ] Error paths handled
- [ ] Tests cover the change adequately
- [ ] Names are clear and consistent
- [ ] No unnecessary complexity
- [ ] Follows existing patterns
- [ ] No secrets in code
- [ ] Input validated at boundaries
- [ ] No N+1 patterns
- [ ] Tests pass
- [ ] Build succeeds

## Red Flags

- PRs merged without any review
- "LGTM" without evidence of actual review
- Security-sensitive changes without security-focused review
- Large PRs that are "too big to review properly" (split them)
- No regression tests with bug fix PRs
- Accepting "I'll fix it later" — it rarely happens
