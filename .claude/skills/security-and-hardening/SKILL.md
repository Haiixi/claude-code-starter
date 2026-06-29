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

把安全当作默认约束，不是事后补丁。任何接触外部输入、用户身份、敏感数据或第三方服务的代码，都应该先过一遍安全清单。

## 何时使用

- 新增用户输入接口（表单、API、文件上传、Webhook）
- 修改认证、授权、会话或密码逻辑
- 接入外部 API 或支付服务
- 处理 PII、Token、密钥、密码
- 发布前快速安全扫描

## 永远先做

- **边界校验**：所有外部输入在入口处校验（zod、Joi、schema 都行）
- **参数化查询**：SQL / NoSQL 查询禁止字符串拼接
- **输出编码**：交给框架自动转义，不要手动 `innerHTML`
- **HTTPS**：所有外部通信走 TLS
- **密码哈希**：bcrypt / scrypt / argon2，salt rounds ≥ 12
- **安全响应头**：CSP、HSTS、X-Frame-Options、X-Content-Type-Options
- **Cookie 安全**：httpOnly + secure + sameSite
- **依赖审计**：发布前运行 `npm audit` 或等价工具

## 必须请示人类

- 新增认证流程或修改授权逻辑
- 存储新的敏感数据类型
- 新增外部服务集成
- 修改 CORS、rate limit、文件上传配置
- 提升权限/角色

## 绝不做的红线

- 不把 secrets、密码、token 提交到版本控制
- 不在日志里打印敏感数据
- 不将客户端校验当作唯一安全边界
- 不为了调试关闭安全响应头
- 不对用户输入使用 `eval()` / `exec()` / `innerHTML`
- 不把会话 token 存 localStorage
- 不向用户暴露堆栈或内部错误详情

## 快速检查清单

### 输入与查询

- [ ] 所有用户输入在边界处校验并限制长度/类型
- [ ] 数据库查询参数化或使用 ORM
- [ ] 文件上传限制类型、大小，不信任扩展名

### 认证与授权

- [ ] 密码哈希且 salt rounds ≥ 12
- [ ] 会话 token httpOnly / secure / sameSite
- [ ] 登录接口有 rate limit
- [ ] 每个受保护端点都校验权限，不只是登录状态
- [ ] 用户只能访问自己的资源

### 数据与配置

- [ ] 代码和 git 历史中没有 secrets
- [ ] API 响应不返回敏感字段（passwordHash、token 等）
- [ ] 使用环境变量读取 API key
- [ ] `.env` 已在 `.gitignore` 中

### 基础设施

- [ ] 安全响应头已配置
- [ ] CORS 限制到已知 origin，不是 `*`
- [ ] 认证端点有 rate limit
- [ ] 生产错误返回统一消息，不暴露内部细节
- [ ] 发布前 `npm audit` 无 critical/high 漏洞（不可修复的需记录）

## 常见反例

```typescript
// BAD: SQL 注入
const query = `SELECT * FROM users WHERE id = '${userId}'`;

// GOOD: 参数化
const user = await db.query('SELECT * FROM users WHERE id = $1', [userId]);

// BAD: XSS
element.innerHTML = userInput;

// GOOD: 框架自动转义
return <div>{userInput}</div>;
```

## npm audit 处理原则

| 严重级别 | reachable | 不可达/仅 dev | 动作 |
|----------|-----------|---------------|------|
| critical/high | 是 | — | 立即修复 |
| critical/high | 否 | 是 | 下个周期修复，记录原因 |
| moderate | 是 | 否 | 下个 release 修复 |
| low | — | — | 常规依赖更新时处理 |

## 一句话提醒

> 自动化扫描会找到你写的每一行漏洞。借口不会让攻击者手软。
