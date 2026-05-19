# Controller Harness — Development

This is the development repo for Controller Harness. Changes here ship to users who install it as a skill.

## Project Structure

```
skills/       → installed to user's .claude/skills/
agents/       → installed to user's .claude/agents/
hooks/        → installed to user's .claude/settings.json (merge)
templates/    → project templates for downstream
platforms/    → cross-platform adapters
```

## Development Rules

- Skills use YAML frontmatter with `description` field
- Keep SKILL.md under 50 lines (long reference → supporting files)
- Agent definitions specify `name`, `tools`, `model`
- Test changes by running `./install.sh <test-project>` before committing
