---
name: shipping-and-launch
description: 发布前检查、灰度发布、监控与回滚策略。用于准备生产上线、规划 staged rollout 或写发布 checklist。
triggers:
  - /shipping-and-launch
  - /launch
  - /ship
  - 发布
  - 上线
---

# Shipping and Launch / 上线发布

发布不只是部署，而是可观测、可回滚、可渐进放量的工程动作。

## 何时使用

- 新功能首次上线
- 重大变更发布
- 数据/基础设施迁移
- 开 beta 或 early access
- 任何有风险的生产部署（所有部署都有风险）

## 发布前 Checklist

### 代码质量

- [ ] 测试通过（unit / integration / e2e）
- [ ] 构建通过，无 warning
- [ ] lint 和类型检查通过
- [ ] 代码已 review
- [ ] 没有遗留 TODO 或调试日志

### 安全

- [ ] 无 secrets 在代码或 git 中
- [ ] 用户输入校验就位
- [ ] 认证/授权检查就位
- [ ] 安全响应头配置正确
- [ ] 认证端点有 rate limit

### 性能与可观测

- [ ] 关键路径无 N+1 查询
- [ ] 静态资源有缓存/CDN
- [ ] 错误上报和日志已配置
- [ ] 健康检查接口可用
- [ ] 关键业务指标可监控

### 文档

- [ ] README / API 文档已更新
- [ ] 架构决策已记录（ADR）
- [ ] Changelog 已更新

## Feature Flag 策略

用 flag 把部署和发布解耦：

```
1. DEPLOY with flag OFF    → 代码已在生产，但不可见
2. ENABLE for team/beta    → 内部验证
3. GRADUAL ROLLOUT         → 5% → 25% → 50% → 100%
4. MONITOR each stage      → 看错误率、延迟、用户反馈
5. CLEAN UP                → 全量后移除 flag 和死代码
```

**规则：**

- 每个 flag 有负责人和过期时间
- 全量后 2 周内清理
- 不嵌套 flag
- CI 中测试 flag on/off 两种状态

## 灰度发布阈值

| 指标 | 继续推进 | 观望 | 回滚 |
|------|----------|------|------|
| 错误率 | 与基线差异 ≤ 10% | 10%–100% 上升 | > 2x 基线 |
| P95 延迟 | ≤ 20% 基线 | 20%–50% 上升 | > 50% 上升 |
| 新 JS 错误 | 无新类型 | < 0.1% 会话 | > 0.1% 会话 |
| 业务指标 | 持平或正 | 下降 < 5% | 下降 > 5% |

## 回滚计划模板

```markdown
## Rollback Plan

### 触发条件
- 错误率 > 2x 基线
- P95 延迟 > [X]ms
- 用户反馈激增 / 数据异常 / 安全漏洞

### 回滚步骤
1. 关闭 feature flag（如有）
2. 否则部署上一版本：`git revert <commit> && git push`
3. 验证 health check 和错误监控
4. 通知团队

### 数据库
- 正向迁移是否可逆？
- 新写入数据如何处理（保留/清理）？

### 时间目标
- flag 回滚：< 1 分钟
- 版本回滚：< 5 分钟
- 数据库回滚：< 15 分钟
```

## 发布后 1 小时必做

1. health check 返回 200
2. 错误监控无新错误类型
3. 延迟无回归
4. 手动跑一遍核心用户流程
5. 日志正常输出
6. 回滚机制已验证或 dry run

## 一句话提醒

> 没有回滚计划和监控的发布不是发布，是赌博。
