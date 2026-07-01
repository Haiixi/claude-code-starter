---
name: test-workflow
description: 帮助用户按测试驱动开发（TDD）流程编写测试和实现代码。
triggers:
  - /test-workflow
  - TDD
  - 测试驱动开发
---

# Test Workflow

> 测试不是事后验证，而是设计工具。

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | 用户说"给这个功能写测试"或希望按 TDD 开发 |
| **Cycle** | Red → Green → Refactor |
| **Rule** | 一个测试只验证一个行为 |

## Process

1. **确认需求**：与用户确认输入、输出和边界情况。
2. **写失败测试**：一个最简单的失败测试，展示期望行为。
3. **让用户确认方向**：确保测试方向正确。
4. **写最少实现**：只写让测试通过的代码。
5. **重构**：保持测试绿色，清理代码。
6. **运行全部测试**：确保无回归。

## Output Format

```markdown
## Test Workflow

### Requirement
- Input: ...
- Expected: ...
- Edge cases: ...

### Red
```python
def test_feature():
    assert feature(input) == expected
```
Result: FAIL (expected)

### Green
```python
def feature(x):
    return expected
```
Result: PASS

### Refactor
- [ ] Remove duplication
- [ ] Improve names
- [ ] Add edge cases

### Final Verification
- [ ] All tests pass
```

## Examples

### Good Test

```python
def test_retry_exhausts_after_three_attempts():
    attempts = 0
    def fail_twice():
        nonlocal attempts
        attempts += 1
        if attempts < 3:
            raise ConnectionError()
        return 'ok'

    assert retry(fail_twice, max_attempts=3) == 'ok'
    assert attempts == 3
```

### Bad Test

```python
def test_retry():
    assert retry(lambda: 'ok') == 'ok'  # 没有测试失败/重试逻辑
```

## Standards

### 测试命名
- 描述行为，而不是实现。
- 使用 `test_<behavior>_when_<condition>` 格式。

### 测试范围
- 优先测试真实代码，少用 mock。
- 必须覆盖边界情况和错误路径。

### Red-Green-Refactor
- Red：测试必须先失败，否则测试可能无效。
- Green：代码最小化，不加额外功能。
- Refactor：在测试通过后重构，不改变行为。

## Common Commands

```bash
# 运行单个测试
pytest tests/test_feature.py::test_name -v

# 运行某个模块
pytest tests/test_feature.py -v

# 运行全部测试
pytest tests/ -q
```

## Checklist

- [ ] 需求、输入、输出已确认
- [ ] 失败测试已写并已看到失败
- [ ] 实现代码让测试通过
- [ ] 边界情况和错误路径已覆盖
- [ ] 重构完成且测试仍通过
- [ ] 全部测试通过

## Red Flags

- 测试名包含实现细节
- 测试过于依赖 mock，没测试真实交互
- 没有看到测试失败就写实现
- 一个测试验证多个行为
- 实现和测试混在同一次提交
