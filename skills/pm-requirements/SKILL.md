---
description: Create product-manager-style requirements specifications with explicit field definitions, API signatures, and edge cases. Use when converting plans into implementable requirements (Step 2 of phase loop) or when the user asks for detailed specs.
---

# PM-Style Requirements Template

Requirements must be detailed enough to code from without asking questions.

## Required Sections

1. **Phase Information** — ID, task type, priority
2. **Functional Requirements (FR-{n})** — WHAT the system must do
3. **Non-Functional Requirements** — Performance, security, compatibility
4. **Constraints & Dependencies** — What's in/out of scope
5. **Verification Plan** — How to verify each FR

## Field Definition Table (mandatory for data/API)

```
| Field Name | Type | Required | Description | Valid Values / Constraints |
|------------|------|----------|-------------|---------------------------|
```

## API Signature (if applicable)

```python
def function_name(param: type, ...) -> ReturnType:
    """One-line description."""
```

## Acceptance Criteria
- Each FR gets actionable, testable acceptance criteria
- Use `[ ]` checkboxes for traceability
- Cover edge cases: boundary values, error states, empty inputs

## Rules
- No ambiguous language — use "MUST" not "should"/"could"/"may"
- Every field has type + constraints
- Edge cases as important as happy path
- If requirements need clarification, ask via AskUserQuestion — don't guess
