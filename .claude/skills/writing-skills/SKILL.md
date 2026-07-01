---
name: writing-skills
description: Use when creating new skills, editing existing skills, or verifying skills work before deployment.
triggers:
  - /writing-skills
  - /skill-guide
---

# Writing Skills

> Writing skills is Test-Driven Development applied to process documentation. If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing.

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | Creating new skills, editing existing skills, verifying skills |
| **Core rule** | Skills are reusable techniques/patterns/tools, not one-off war stories |
| **Structure** | Quick Reference → Process → Output Format → Examples → Standards → Checklist → Red Flags |

## Process

1. **Identify the reusable technique**: What pattern applies broadly across projects?
2. **Write pressure scenarios**: Test cases that show current behavior without the skill.
3. **Draft the skill**: Use the standard structure.
4. **Test the skill**: Have an agent follow it and watch it succeed.
5. **Refine**: Close loopholes based on failures.
6. **Verify before deployment**: Ensure triggers, steps, and examples are clear.

## Output Format

```markdown
---
name: skill-name
description: Use when [triggering condition]. [More context].
triggers:
  - /skill-name
  - keyword
---

# Skill Title

> One-sentence principle.

## Quick Reference
| Item | Answer |
| ... |

## Process
1. ...

## Output Format
...

## Examples
### Good
...

### Bad
...

## Standards
...

## Checklist
- [ ] ...

## Red Flags
- ...
```

## Examples

### Good Skill Description

```yaml
name: retry-policy
description: Use when designing retry logic for external service calls. Ensures exponential backoff, idempotency, and circuit breaker patterns.
```

### Bad Skill Description

```yaml
name: that-time-we-fixed-redis
description: Explains how we fixed a Redis timeout last Tuesday.
```

## Standards

### When to Create
**Create when:**
- Technique wasn't intuitively obvious
- You'd reference this again across projects
- Pattern applies broadly (not project-specific)
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in CLAUDE.md)
- Mechanical constraints (automate those instead)

### Skill Types

| Type | Description | Example |
|------|-------------|---------|
| **Technique** | Concrete method with steps | condition-based-waiting |
| **Pattern** | Way of thinking about problems | flatten-with-flags |
| **Reference** | API docs, syntax guides | office docs |

### Directory Structure

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    reference/            # Detailed docs (>100 lines)
    templates/            # Reusable templates
    scripts/              # Reusable tools
```

### Frontmatter

```yaml
---
name: skill-name                    # letters, numbers, hyphens only
description: Use when ...           # third-person, max 1024 chars
triggers:
  - /skill-name
  - keyword
---
```

### Body Structure

- **Quick Reference**: When, core rule, output format at a glance.
- **Process**: Numbered steps, actionable without interpretation.
- **Output Format**: Template or example of expected output.
- **Examples**: Good/Bad cases for every rule.
- **Standards**: Detailed rules and conventions.
- **Checklist**: Forces completeness.
- **Red Flags**: Common rationalizations and warning signs.

### Writing Tips

1. **Be specific, not abstract**
   - Bad: "Be careful with errors"
   - Good: "Check for null before accessing user.email"

2. **Lead with action**
   - Bad: "This skill explains how to..."
   - Good: "Use this skill when you see..."

3. **Include examples**: Every rule needs a Good/Bad example.

4. **Use checklists**: They force completeness.

5. **Close loopholes**: List common rationalizations and why they're wrong.

6. **Keep it scannable**: Tables, lists, clear headings.

## Checklist

- [ ] Skill has clear trigger conditions
- [ ] Steps are actionable without interpretation
- [ ] Examples show both good and bad cases
- [ ] Common mistakes are addressed
- [ ] Red flags and rationalizations are listed
- [ ] A subagent or another model can follow it successfully
- [ ] Frontmatter name/describes are valid

## Red Flags

- Skill describes a one-time problem instead of a reusable technique
- No clear trigger condition
- Steps are vague or require interpretation
- Missing examples
- Missing checklist
- "Overview" is longer than the actual guidance
- Skill overlaps with CLAUDE.md instead of complementing it
