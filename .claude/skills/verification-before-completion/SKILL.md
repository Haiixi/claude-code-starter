---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before committing or creating PRs - requires running verification commands and confirming output before making any success claims; evidence before assertions always
---

# Verification Before Completion

> Claiming work is complete without verification is dishonesty, not efficiency. Evidence before claims, always.

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | Before any success/completion claim, before commit/PR, before moving to next task |
| **Iron law** | No completion claims without fresh verification evidence |
| **Output** | Claim + evidence from the actual command output |

## Process

1. **Identify**: What command proves this claim?
2. **Run**: Execute the FULL command fresh and completely.
3. **Read**: Full output, exit code, count failures.
4. **Verify**: Does output confirm the claim?
   - If NO: State actual status with evidence.
   - If YES: State claim WITH evidence.
5. **Claim**: Only after the above.

## Output Format

```markdown
## Verification

### Claim
[What you are claiming]

### Evidence
```
[Full command output]
```

### Result
- [x] Claim confirmed
- [ ] Claim not confirmed: [actual status]
```

## Examples

### Good

```markdown
**Claim**: All tests pass.
**Evidence**:
```
$ npm test
Test Suites: 12 passed, 12 total
Tests:       87 passed, 87 total
```
**Result**: ✓ Confirmed.
```

### Bad

```markdown
Tests should pass now.
```

## Standards

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Test command output: 0 failures | Previous run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check, extrapolation |
| Build succeeds | Build command: exit 0 | Linter passing, logs look good |
| Bug fixed | Test original symptom: passes | Code changed, assumed fixed |
| Regression test works | Red-green cycle verified | Test passes once |
| Agent completed | VCS diff shows changes | Agent reports "success" |
| Requirements met | Line-by-line checklist | Tests passing |

## Key Patterns

**Tests:**
```
✓ [Run test command] [See: 34/34 pass] "All tests pass"
✗ "Should pass now" / "Looks correct"
```

**Regression tests (TDD Red-Green):**
```
✓ Write → Run (pass) → Revert fix → Run (MUST FAIL) → Restore → Run (pass)
✗ "I've written a regression test" (without red-green verification)
```

**Build:**
```
✓ [Run build] [See: exit 0] "Build passes"
✗ "Linter passed" (linter doesn't check compilation)
```

**Requirements:**
```
✓ Re-read plan → Create checklist → Verify each → Report gaps or completion
✗ "Tests pass, phase complete"
```

## Checklist

- [ ] I identified the verification command
- [ ] I ran the full command fresh
- [ ] I read the full output and exit code
- [ ] The output confirms my claim
- [ ] I stated the claim with evidence

## Red Flags

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Perfect!", "Done!")
- About to commit/push/PR without verification
- Trusting agent success reports without checking
- Relying on partial verification
- Thinking "just this once"
- Tired and wanting work over
- ANY wording implying success without having run verification

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "Should work now" | RUN the verification |
| "I'm confident" | Confidence ≠ evidence |
| "Just this once" | No exceptions |
| "Linter passed" | Linter ≠ compiler |
| "Agent said success" | Verify independently |
| "I'm tired" | Exhaustion ≠ excuse |
| "Partial check is enough" | Partial proves nothing |
| "Different words so rule doesn't apply" | Spirit over letter |
