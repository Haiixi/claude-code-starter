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

> 发布不只是部署，而是可观测、可回滚、可渐进放量的工程动作。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 新功能首次上线、重大变更、数据/基础设施迁移、开 beta |
| **Core rule** | 部署和发布解耦：先部署，通过 feature flag 渐进放量 |
| **Output** | 发布 checklist、flag 配置、回滚计划、发布后 1 小时验收 |

## Process

1. **发布前检查**：按代码质量、安全、性能、文档四维度检查。
2. **制定 flag 策略**：确定 flag 名称、负责人、过期时间。
3. **部署并关闭 flag**：代码上生产，功能不可见。
4. **内部验证**：团队或 beta 用户验证。
5. **渐进放量**：5% → 25% → 50% → 100%，每阶段观察指标。
6. **发布后 1 小时**：验证 health check、错误监控、延迟、核心流程。
7. **清理 flag**：全量 2 周内移除 flag 和死代码。

## Output Format

```markdown
## Launch Plan: [Feature Name]

### Pre-launch Checklist
- [ ] Tests pass
- [ ] Build clean
- [ ] Security review done
- [ ] Feature flag configured

### Rollout Stages
| Stage | % | Criteria to Advance |
|-------|---|---------------------|
| Team only | 0% | No critical bugs for 24h |
| Beta | 5% | Error rate ≤ baseline + 10% |
| Gradual | 25% → 50% | Latency ≤ baseline + 20% |
| Full | 100% | Business metrics stable |

### Rollback Plan
- Trigger: error rate > 2x baseline or P95 latency > [X]ms
- Step 1: Disable feature flag
- Step 2: Deploy previous version if needed
- Step 3: Verify health checks

### Post-launch (1h)
- [ ] Health check 200
- [ ] No new error types
- [ ] Latency stable
- [ ] Core user flow manually verified
```

## Examples

### Good: Flag Lifecycle

```
1. DEPLOY with flag OFF    → code on production, invisible
2. ENABLE for team/beta    → internal validation
3. GRADUAL ROLLOUT         → 5% → 25% → 50% → 100%
4. MONITOR each stage      → errors, latency, feedback
5. CLEAN UP                → remove flag and dead code
```

### Bad: Big Bang

```
1. Build everything
2. Deploy to 100%
3. Hope it works
```

## Standards

### Feature Flag 规则
- 每个 flag 有负责人和过期时间。
- 全量后 2 周内清理。
- 不嵌套 flag。
- CI 中测试 flag on/off 两种状态。

### 灰度阈值

| 指标 | 继续推进 | 观望 | 回滚 |
|------|----------|------|------|
| 错误率 | 与基线差异 ≤ 10% | 10%–100% 上升 | > 2x 基线 |
| P95 延迟 | ≤ 20% 基线 | 20%–50% 上升 | > 50% 上升 |
| 新 JS 错误 | 无新类型 | < 0.1% 会话 | > 0.1% 会话 |
| 业务指标 | 持平或正 | 下降 < 5% | 下降 > 5% |

### 回滚计划

- 触发条件明确：错误率、延迟、用户反馈、数据异常、安全漏洞。
- 回滚步骤从快到慢：flag → 版本 → 数据库。
- flag 回滚 < 1 分钟，版本回滚 < 5 分钟。
- 数据库迁移必须可逆或兼容，新写入数据需要清理或保留策略。

## Checklist

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

### 发布后 1 小时
- [ ] health check 返回 200
- [ ] 错误监控无新错误类型
- [ ] 延迟无回归
- [ ] 手动跑一遍核心用户流程
- [ ] 日志正常输出
- [ ] 回滚机制已验证或 dry run

## Red Flags

- 没有 feature flag 就全量发布
- 没有回滚计划
- 没有监控就发布
- flag 过期不清理
- 嵌套 flag 导致策略难以理清
- 大型 PR "too big to review"
- 接受 "I'll fix it later"
