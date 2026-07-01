---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes.
---

# Systematic Debugging

> Random fixes waste time and create new bugs. ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | Test failures, bugs, unexpected behavior, performance issues, build failures, integration issues |
| **Iron law** | NO fixes without root cause investigation first |
| **Four phases** | 1. Root Cause → 2. Pattern → 3. Hypothesis → 4. Implementation |
| **Output** | Root cause statement + failing test + single fix + verification |

## Process

1. **Root Cause Investigation**
   - Read error messages and stack traces completely.
   - Reproduce the issue consistently.
   - Check recent changes (git diff, dependencies, config).
   - In multi-component systems, add diagnostic instrumentation at each boundary.
   - Trace data flow backward to find the source.

2. **Pattern Analysis**
   - Find similar working code.
   - Compare against reference implementations.
   - Identify differences, no matter how small.
   - Understand dependencies and assumptions.

3. **Hypothesis and Testing**
   - Form a single, specific hypothesis.
   - Test it with the smallest possible change.
   - If wrong, form a new hypothesis. Don't add fixes on top.
   - If you don't understand, say so and ask for help.

4. **Implementation**
   - Create a failing test case first.
   - Implement ONE fix for the root cause.
   - Verify the fix and ensure no other tests break.
   - If 3+ fixes fail, STOP and question the architecture with your human partner.

For the complete four-phase process with detailed steps, see `reference/debugging-process.md`.

## Output Format

```markdown
## Systematic Debugging Report: [Issue]

### Root Cause
[Clear statement of the actual cause]

### Evidence
- Error message: ...
- Reproduction steps: ...
- Recent changes: ...
- Data flow: ...

### Failing Test
```python
# minimal reproduction
```

### Fix
[Single change addressing root cause]

### Verification
- [ ] Failing test now passes
- [ ] No other tests broken
- [ ] Manual reproduction confirmed fixed
```

## Examples

### Good: Root-Cause Fix

```markdown
**Issue**: Users see 500 error on login.

**Root cause**: `getUserByEmail` returns `null` when email has trailing spaces, and `authenticate` does not validate input before calling it.

**Fix**: Trim and validate email at the API boundary; add null check in `authenticate`.

**Verification**: New test `test_login_with_trailing_space` passes; existing auth tests still pass.
```

### Bad: Symptom Fix

```markdown
**Issue**: Users see 500 error on login.

**Fix**: Wrap login in try/catch and return generic error.

**Result**: Symptom hidden; underlying bug remains and will cause data corruption elsewhere.
```

## Standards

### Phase Summary

| Phase | Key Activities | Success Criteria |
|-------|---------------|------------------|
| **1. Root Cause** | Read errors, reproduce, check changes, gather evidence | Understand WHAT and WHY |
| **2. Pattern** | Find working examples, compare | Identify differences |
| **3. Hypothesis** | Form theory, test minimally | Confirmed or new hypothesis |
| **4. Implementation** | Create test, fix, verify | Bug resolved, tests pass |

### When NOT to Skip

- Issue seems simple
- You're in a hurry
- Manager wants it fixed NOW
- "Just one quick fix" seems obvious
- You've already tried multiple fixes
- Previous fix didn't work
- You don't fully understand the issue

### When "No Root Cause" Is Real

If investigation reveals the issue is truly environmental, timing-dependent, or external:
1. Document what you investigated.
2. Implement appropriate handling (retry, timeout, error message).
3. Add monitoring/logging for future investigation.

**But:** 95% of "no root cause" cases are incomplete investigation.

## Supporting Resources

In this skill directory:
- `reference/debugging-process.md` — Detailed four-phase process
- `root-cause-tracing.md` — Trace bugs backward through call stack
- `defense-in-depth.md` — Add validation at multiple layers
- `condition-based-waiting.md` — Replace arbitrary timeouts with condition polling

Related skills:
- `test-driven-development` — Create failing test case
- `verification-before-completion` — Verify fix before claiming success

## Checklist

- [ ] Error messages read completely
- [ ] Issue reproduced consistently
- [ ] Recent changes checked
- [ ] Evidence gathered at component boundaries (if multi-component)
- [ ] Data flow traced to source
- [ ] Working examples compared
- [ ] Single hypothesis formed and tested
- [ ] Failing test created before fix
- [ ] One fix implemented for root cause
- [ ] Fix verified, no regressions
- [ ] If 3+ fixes failed, architecture discussion initiated

## Red Flags

- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- Proposing solutions before tracing data flow
- "One more fix attempt" (after 2+ failures)
- Each fix reveals a new problem in a different place
- "I don't fully understand but this might work"
