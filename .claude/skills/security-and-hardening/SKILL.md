---
name: security-and-hardening
description: 在编写用户输入、认证授权、敏感数据或外部集成时，提供安全加固检查清单和常见坑点。
triggers:
  - /security-and-hardening
  - /security
  - 安全检查
  - 加固
---

# Security and Hardening / 安全加固

> 把安全当作默认约束，不是事后补丁。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 新增输入接口、修改认证授权、接入外部服务、处理 PII/密钥、发布前扫描 |
| **Core rule** | 边界校验、参数化查询、输出编码、密码哈希 |
| **Output** | 按清单检查，标注严重的安全问题和必须请示人类的事项 |

## Process

1. **确讦触碰边界**：确认这次代码涉及哪些外部输入、认证、授权或敏感数据。
2. **过「永远先做」清单**：逐条检查，不跳步。
3. **扫描常见漏洞**：搜索 SQL 注入、XSS、命令注入、硬编码密钥等。
4. **确认人工决策点**：如有必须请示人类的事项，先报告。
5. **输出检查结果**：按严重级分类问题，给出修复建议。

## Output Format

```markdown
## Security Review

### 🔴 Must Fix Before Merge
- [位置] 问题 → 修复建议

### 🟡 Should Fix
- [位置] 问题 → 修复建议

### ⚠️ Human Approval Required
- 新增认证流程 / 修改授权逻辑
```

## Examples

### Bad: SQL 注入

```typescript
const query = `SELECT * FROM users WHERE id = '${userId}'`;
```

### Good: 参数化

```typescript
const user = await db.query('SELECT * FROM users WHERE id = $1', [userId]);
```

### Bad: XSS

```typescript
element.innerHTML = userInput;
```

### Good: 框架转义

```tsx
return <div>{userInput}</div>;
```

## Standards

### 永远先做
- 边界校验：所有外部输入在入口处校验（zod / Joi / schema）。
- 参数化查询：SQL / NoSQL 禁止字符串拼接。
- 输出编码：交给框架自动转义，不手动 `innerHTML`。
- HTTPS：所有外部通信走 TLS。
- 密码哈希：bcrypt / scrypt / argon2，salt rounds ≥ 12。
- 安全响应头：CSP、HSTS、X-Frame-Options、X-Content-Type-Options。
- Cookie 安全：httpOnly + secure + sameSite。
- 依赖审计：发布前运行 `npm audit` 或等价工具。

### 必须请示人类
- 新增认证流程或修改授权逻辑
- 存储新的敏感数据类型
- 新增外部服务集成
- 修改 CORS、rate limit、文件上传配置
- 提升权限/角色

### 绝不做的红线
- 不把 secrets、密码、token 提交到版本控制
- 不在日志里打印敏感数据
- 不将客户端校验当作唯一安全边界
- 不为了调试关闭安全响应头
- 不对用户输入使用 `eval()` / `exec()` / `innerHTML`
- 不把会话 token 存 localStorage
- 不向用户暴露堆栈或内部错误详情

## Checklist

### 输入与查询
- [ ] 所有用户输入在边界处校验并限制长度/类型
- [ ] 数据库查询参数化或使用 ORM
- [ ] 文件上传限制类型、大小，不信任扩展名

### 认证与授权
- [ ] 密码哈希且 salt rounds ≥ 12
- [ ] 会话 token httpOnly / secure / sameSite
- [ ] 登录接口有 rate limit
- [ ] 每个受保护端点都校验权限
- [ ] 用户只能访问自己的资源

### 数据与配置
- [ ] 代码和 git 历史中没有 secrets
- [ ] API 响应不返回敏感字段
- [ ] API key 使用环境变量
- [ ] `.env` 已在 `.gitignore` 中

### 基础设施
- [ ] 安全响应头已配置
- [ ] CORS 限制到已知 origin
- [ ] 认证端点有 rate limit
- [ ] 生产错误返回统一消息
- [ ] 发布前 `npm audit` 无 critical/high（不可修复的需记录）

## Red Flags

- 硬编码密钥 / token / 密码
- SQL 注入（字符串拼接）
- 命令注入（`os.system`、`subprocess shell=True`）
- 不安全反序列化（`pickle.loads`）
- `eval()` / `exec()` 调用
- 路径穿越
- 修改认证时未请示人类
