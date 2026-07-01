---
name: planning-and-task-breakdown
description: Breaks work into ordered tasks. Use when you have a spec or clear requirements and need to break work into implementable tasks, when a task feels too large to start, or when parallel work is possible.
triggers:
  - /planning-and-task-breakdown
  - /plan
  - /breakdown
---

# Planning and Task Breakdown

> Decompose work into small, verifiable tasks with explicit acceptance criteria. Every task should be small enough to implement, test, and verify in a single focused session.

## Quick Reference

| Item | Answer |
|------|--------|
| **Use when** | You have a spec, task feels too large, or work can be parallelized |
| **Slice style** | Vertical slices, not horizontal layers |
| **Output** | Numbered tasks with acceptance criteria, verification, dependencies, size |

## Process

1. **Enter plan mode**: Read spec and relevant code. Do NOT write implementation yet.
2. **Map dependency graph**: Identify what depends on what. Build foundations first.
3. **Slice vertically**: Each slice delivers a complete, working feature path.
4. **Write tasks**: Use the standard task structure.
5. **Order and checkpoint**: Dependencies first, verification after every 2-3 tasks.

## Output Format

```markdown
# Implementation Plan: [Feature/Project Name]

## Overview
[One paragraph summary]

## Task List

### Phase 1: Foundation
- [ ] Task 1: ...
- [ ] Task 2: ...

### Checkpoint: Foundation
- [ ] Tests pass, builds clean

### Phase 2: Core Features
- [ ] Task 3: ...
- [ ] Task 4: ...

### Checkpoint: Complete
- [ ] All acceptance criteria met
- [ ] Ready for review

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk] | [High/Med/Low] | [Strategy] |

## Open Questions
- [Question needing human input]
```

### Task Structure

```markdown
## Task [N]: [Short descriptive title]

**Description:** One paragraph explaining what this task accomplishes.

**Acceptance criteria:**
- [ ] [Specific, testable condition]
- [ ] [Specific, testable condition]

**Verification:**
- [ ] Tests pass: `npm test -- --grep "feature-name"`
- [ ] Build succeeds: `npm run build`
- [ ] Manual check: [description of what to verify]

**Dependencies:** [Task numbers this depends on, or "None"]

**Files likely touched:**
- `src/path/to/file.ts`
- `tests/path/to/test.ts`

**Estimated scope:** [XS|S|M|L]
```

## Examples

### Bad: Horizontal Slicing

```markdown
- Task 1: Build entire database schema
- Task 2: Build all API endpoints
- Task 3: Build all UI components
- Task 4: Connect everything
```

### Good: Vertical Slicing

```markdown
- Task 1: User can create an account (schema + API + UI for registration)
- Task 2: User can log in (auth schema + API + UI for login)
- Task 3: User can create a task (task schema + API + UI for creation)
```

## Standards

### Task Sizing Guidelines

| Size | Files | Scope | Example |
|------|-------|-------|---------|
| **XS** | 1 | Single function or config change | Add a validation rule |
| **S** | 1-2 | One component or endpoint | Add a new API endpoint |
| **M** | 3-5 | One feature slice | User registration flow |
| **L** | 5-8 | Multi-component feature | Search with filtering and pagination |
| **XL** | 8+ | **Too large — break it down further** | — |

If a task is L or larger, break it into smaller tasks.

### Ordering Rules

1. Dependencies are satisfied (build foundation first).
2. Each task leaves the system in a working state.
3. Verification checkpoints occur after every 2-3 tasks.
4. High-risk tasks are early (fail fast).

### Dependency Graph Example

```
Database schema
    │
    ├─── API models/types
    │       │
    │       ├─── API endpoints
    │       │       │
    │       │       └─── Frontend API client
    │       │               │
    │       │               └─── UI components
    │       │
    │       └─── Validation logic
    │
    └─── Seed data / migrations
```

## Checklist

- [ ] Spec and relevant code have been read
- [ ] Dependency graph is mapped
- [ ] Tasks are vertically sliced
- [ ] Each task has acceptance criteria
- [ ] Each task has verification steps
- [ ] Dependencies are explicit
- [ ] Tasks are XS/S/M/L sized
- [ ] Checkpoints are defined
- [ ] Risks and mitigations are listed
- [ ] Open questions are documented

## Red Flags

- Starting implementation without a written task list
- Tasks that say "implement the feature" without acceptance criteria
- No verification steps in the plan
- All tasks are XL-sized
- No checkpoints between tasks
- Horizontal slicing (all DB, then all API, then all UI)
