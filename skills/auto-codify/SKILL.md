---
description: Autonomous pattern detection and skill creation. After completing any complex task, automatically evaluate whether the workflow should be encoded as a reusable skill. Based on Hermes Agent's closed learning loop — the agent creates and refines its own skills from experience.
---

# Auto-Codify: Closed Learning Loop

Inspired by [Hermes Agent](https://github.com/NousResearch/hermes-agent)'s signature feature: "autonomous skill creation after complex tasks, with skills that self-improve during use."

## When to Trigger

After any multi-step task that:
- Involved 3+ distinct tool calls or subagent delegations
- Required a non-obvious sequence or workaround
- Produced a new error pattern
- Used a pattern not already in `.claude/skills/`

## Three Questions to Evaluate

1. **Will this workflow repeat?** — If the same situation will arise again, encode it.
2. **Is the pattern non-obvious?** — If a fresh Claude would make the same mistake, encode it.
3. **Did it require specific constraints?** — If certain tools/models/paths were critical, encode them.

## Skill Creation Process

1. **Check for existing skill** — search `.claude/skills/` for similar patterns
2. **If known pattern**: update existing skill with new learnings (refinement, not replacement)
3. **If new pattern**: create new skill directory with SKILL.md:
   ```yaml
   ---
   description: [What + When to use, specific trigger keywords]
   ---
   # [Skill Name]
   ## Trigger
   [When to load this skill]
   
   ## Pattern
   [Steps or rules, concise]
   
   ## Anti-Pattern (if applicable)
   [What NOT to do]
   
   ## Source
   Learned from: [phase/task where pattern was discovered]
   ```
4. **Keep it concise** — under 50 lines. Long reference material goes in supporting files.

## Skill Refinement

When using an existing skill and discovering a better approach:
- Update the skill with the new learning
- Don't create a duplicate skill
- Keep the skill focused — split if it grows beyond 50 lines

## Difference from Traditional Documentation

Hermes-style skills are:
- **Procedural** (how to do X) vs **Declarative** (what X is)
- **Executable** (Claude follows steps) vs **Reference** (human reads)
- **Self-improving** (updates on use) vs **Static** (written once)
