# continuous-learning — Agent Self-Improvement Patterns

## When to Use
- After making a mistake
- When discovering a better way to do something
- When encountering recurring issues
- During post-task reflection

## When NOT to Use
- For one-off situations that won't repeat
- When the lesson is already documented

## Core Principle

**If you learned something worth remembering, write it down.**

Every mistake is a lesson. Every lesson should prevent future mistakes.

## The Learning Loop

1. **Make mistake / discover insight**
2. **Identify root cause** — Why did this happen?
3. **Document the lesson** — Where should this knowledge live?
4. **Update the right file** — Make it actionable for future sessions
5. **Verify fix** — Does the documentation prevent recurrence?

## Where to Document

| Type of Learning | File to Update |
|------------------|----------------|
| How to operate | `AGENTS.md` |
| Personality/tone correction | `SOUL.md` |
| Tool usage pattern | `TOOLS.md` |
| User preference | `USER.md` |
| Technical detail | `MEMORY.md` or daily notes |
| Skill-specific | Relevant `skills/*/SKILL.md` |
| Code pattern | `agents/vibe-coding-guide.md` |

## Learning Patterns

### Pattern: Mistake → Documentation
**Example:** Asked for credentials that were already in config files.

**Fix:**
1. Identified root cause: Not checking existing configs first
2. Updated `AGENTS.md` session checklist: "Check `CREDENTIALS.md` + actual config files before asking for credentials"
3. Created `CREDENTIALS.md` to track what's configured
4. Result: Won't ask twice for same credentials

### Pattern: Inefficiency → Routing Rule
**Example:** Used `browser` tool for simple text extraction when `web_fetch` would work.

**Fix:**
1. Realized `browser` burns way more tokens than needed
2. Added routing table to `TOOLS.md`: "Web content — cascade: 1. web_fetch → 2. browser → 3. Tell user"
3. Result: Always try lightest tool first

### Pattern: Repeated Failure → Standing Rule
**Example:** Browser automation in main session burned context fast.

**Fix:**
1. Documented in `AGENTS.md`: "Browser automation → ALWAYS spawn subagent"
2. Added to `MEMORY.md` key rules
3. Result: Never repeat that mistake

## Reflection Prompts

After completing a task, ask yourself:

- **Did I take the optimal path?** If not, what would be better next time?
- **Did I waste tokens?** Could I have used a lighter tool or avoided repeated failures?
- **Did I ask for something I already had?** Should I check files first?
- **Did I miss context?** Should I have read a skill or memory file?
- **Did I learn something new?** Where should I document it?

## Meta-Learning: Learning How to Learn

Track your learning patterns in `memory/archive/lessons-learned.md`:

```markdown
## 2026-02-21 — Credential Management
**Mistake:** Asked for iCloud password that was already in himalaya config.
**Root cause:** Didn't check CREDENTIALS.md or ~/.config/ before asking.
**Fix:** Updated AGENTS.md session checklist.
**Pattern:** Check existing configs before asking for credentials.

## 2026-02-16 — Context Budget
**Mistake:** Called config.get in main session, burned 15K tokens.
**Root cause:** Didn't realize config is returned 3 times (current + schema + defaults).
**Fix:** Added to AGENTS.md: "Never call config.get/config.schema in main session"
**Pattern:** Research tool output size before calling in main session.
```

## Self-Improvement Cycle

### Weekly Review (during heartbeat)
1. Read recent `memory/YYYY-MM-DD.md` files
2. Identify patterns in mistakes or inefficiencies
3. Update relevant documentation
4. Archive detailed lessons to `memory/archive/lessons-learned.md`

### Monthly Audit
1. Review `AGENTS.md`, `SOUL.md`, `TOOLS.md` for outdated guidance
2. Prune stale rules
3. Consolidate related patterns
4. Update `MEMORY.md` with fresh insights

## Examples of Good Learning

### Before Learning
```
User: "Get me the text from this page"
Agent: [Uses browser tool, burns 500 tokens on CDP traffic]
```

### After Learning (TOOLS.md routing table)
```
User: "Get me the text from this page"
Agent: [Uses web_fetch, costs 50 tokens, gets result instantly]
```

### Before Learning
```
Agent: "What's your iCloud password?"
User: "I already gave you that on Feb 19"
Agent: "Sorry, checking... oh yes, it's in the config"
```

### After Learning (AGENTS.md checklist)
```
Agent: [Checks CREDENTIALS.md + ~/.config/himalaya/config.toml]
Agent: "iCloud email already configured, syncing now"
```

## Mistakes Worth Celebrating

Not all mistakes are bad. Some reveal:
- Better approaches you didn't know existed
- Edge cases that improve robustness
- User preferences that improve collaboration

Document the good ones too.

## Remember

**You are getting better every session.**

Each mistake documented = one fewer future mistake.
Each pattern captured = one more automatic good decision.
Each lesson learned = one step toward true expertise.

Files are memory. Sessions are ephemeral. **Write it down.**

---

*The only mistake that matters is the one you repeat.*
