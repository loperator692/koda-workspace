# Skill Audit

## When to Use
Before installing ANY external skill from ClawHub or unknown sources.

## When NOT to Use
Skills you wrote yourself or from fully trusted sources.

## Audit Checklist

Before installing a skill, review its SKILL.md and any scripts for:

- [ ] **No network calls** to external services (unless clearly documented and expected)
- [ ] **No credential access** — skills shouldn't read config files or env vars
- [ ] **No file writes** outside the skill's own directory
- [ ] **No exec/shell commands** that aren't clearly explained
- [ ] **No base64-encoded strings** (obfuscation red flag)
- [ ] **No `eval()` or dynamic code execution**
- [ ] **Author/source is identifiable** — anonymous skills are higher risk

## Risk Levels
- 🟢 **Low** — pure markdown/prompts, no scripts
- 🟡 **Medium** — has scripts but they're readable and scoped
- 🔴 **High** — network calls, credential access, or obfuscated code → don't install

## Quick Start
```
# Before installing:
cat /path/to/skill/SKILL.md  # Read it fully
ls /path/to/skill/           # Check all files
# For each script:
cat /path/to/skill/scripts/whatever.sh  # Read every script
```
