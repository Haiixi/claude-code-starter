---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code.
triggers:
  - /test-driven-development
  - /tdd
---

# Test-Driven Development (TDD)

> Write the test first. Watch it fail. Write minimal code to pass. If you didn't watch the test fail, you don't know if it tests the right thing.

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | New features, bug fixes, refactoring, behavior changes |
| **Cycle** | RED → GREEN → REFACTOR |
| **Iron law** | No production code without a failing test first |

## Process

### RED — Write Failing Test

1. Write one minimal test showing expected behavior.
2. Requirements: one behavior, clear name, real code (no mocks unless unavoidable).
3. Run the test and confirm it fails for the expected reason.

```typescript
test('retries failed operations 3 times', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };

  const result = await retryOperation(operation);

  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
```

### GREEN — Minimal Code

1. Write the simplest code that passes the test.
2. Don't add features, refactor, or improve beyond the test.

```typescript
async function retryOperation<T>(fn: () => Promise<T>): Promise<T> {
  for (let i = 0; i < 3; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === 2) throw e;
    }
  }
  throw new Error('unreachable');
}
```

### REFACTOR — Clean Up

1. Remove duplication.
2. Improve names.
3. Extract helpers.
4. Keep tests green.
5. Don't add behavior.

## Output Format

```markdown
## TDD: [Feature/Bug]

### Red
```typescript
// failing test
```
Result: FAIL (expected reason)

### Green
```typescript
// minimal implementation
```
Result: PASS

### Refactor
- [ ] Remove duplication
- [ ] Improve names
- [ ] Extract helpers

### Verification
- [ ] Original test passes
- [ ] Regression test added and passes
- [ ] All other tests pass
```

## Examples

### Good: Single Behavior Test

```typescript
test('returns discounted price for valid coupon', () => {
  expect(applyCoupon(100, 'SAVE20')).toBe(80);
});
```

### Bad: Multiple Behaviors in One Test

```typescript
test('coupon system', () => {
  expect(applyCoupon(100, 'SAVE20')).toBe(80);
  expect(applyCoupon(100, 'INVALID')).toBe(100);
  expect(applyCoupon(-10, 'SAVE20')).toThrow();
});
```

## Standards

### Test Naming
- Describe behavior, not implementation.
- Use `test_<behavior>_when_<condition>` or natural language.

### Test Scope
- One test verifies one behavior.
- Prefer real code; use mocks only when unavoidable.
- Cover boundary cases and error paths.

### Red Phase
- Test must fail before implementation.
- If test passes, you're testing existing behavior — fix the test.

### Green Phase
- Code should be the minimum to pass.
- No "while I'm here" improvements.

### Refactor Phase
- Only after green.
- Keep tests green throughout.

## Verification Checklist

- [ ] Every new function/method has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for expected reason
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] Output pristine (no errors, warnings)

## Red Flags

- "Too simple to test"
- "I'll test after"
- Writing implementation before any test
- Not watching the test fail
- Multiple behaviors in one test
- Heavy mocking without testing real integration
- Refactoring before green
