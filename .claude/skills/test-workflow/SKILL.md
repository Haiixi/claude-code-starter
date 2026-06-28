---
name: test-workflow
description: 帮助用户按测试驱动开发（TDD）流程编写测试和实现代码。
triggers:
  - /test-workflow
  - TDD
  - 测试驱动开发
---

# Test Workflow

## 流程

1. **Red**：写一个失败的测试
2. **Green**：写最少代码让测试通过
3. **Refactor**：重构，保持测试通过

## 规则

- 一个测试只验证一个行为
- 测试名描述行为，而非实现
- 优先测试真实代码，少用 mock
- 必须覆盖边界情况和错误路径
- 测试失败时先修复测试，再写业务代码

## 常用命令

```bash
# 运行单个测试
pytest tests/test_feature.py::test_name -v

# 运行某个模块
pytest tests/test_feature.py -v

# 运行全部测试
pytest tests/ -q
```

## 工作流程

当用户说"给这个功能写测试"时：

1. 先询问具体需求和输入输出
2. 写一个最简单的失败测试
3. 让用户确认测试方向
4. 写最少实现代码
5. 重构并运行全部测试
