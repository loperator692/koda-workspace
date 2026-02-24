# ai-compound — AI Compound Engineering Methodology

## When to Use
- Complex feature development requiring multiple iterations
- System design that benefits from AI assistance
- Code that needs progressive refinement
- Projects where "good enough" isn't good enough

## When NOT to Use
- Simple one-off tasks
- When the first pass is sufficient
- Time-sensitive work where iteration cost exceeds value
- Tasks with clear, simple implementations

## Core Concept

**Compound engineering** = Plan → Work → Review → Iterate → Capture Learnings

Instead of "build it once and ship," you build → review → improve → review → ship.

AI makes this fast enough to be practical for everyday work.

## The Compound Cycle

### Phase 1: Plan
**Before writing code, design the system.**

```
Agent: Read ~/clawd/agents/architect.md
Task: Design [feature/system]
Output: projects/[name]/architecture.md

Include:
- System boundaries
- Data flow
- Key abstractions
- Risk areas
- Success criteria
```

### Phase 2: Build
**Implement according to the plan.**

```
Agent: Read projects/[name]/architecture.md
Task: Implement core functionality
Output: projects/[name]/src/

Guidelines:
- Follow architecture
- Write tests alongside code
- Document complex decisions
- Flag areas needing review
```

### Phase 3: Review
**Get specialized perspectives.**

Spawn multiple reviewers (stagger 30s apart):

```
Code Reviewer:
- Read ~/clawd/agents/code-reviewer.md
- Review projects/[name]/src/
- Output: projects/[name]/reviews/code.md

Security Reviewer:
- Read ~/clawd/agents/security-reviewer.md
- Audit projects/[name]/src/
- Output: projects/[name]/reviews/security.md

(Optional) UI/UX Reviewer:
- Read ~/clawd/agents/ui-architect.md
- Review user-facing aspects
- Output: projects/[name]/reviews/ux.md
```

### Phase 4: Refine
**Address review findings.**

```
Main agent:
- Read all review files
- Prioritize issues
- Implement fixes
- Re-run critical reviews if major changes
```

### Phase 5: Capture
**Document learnings for next time.**

```
Update relevant files:
- New patterns → agents/vibe-coding-guide.md
- Security lessons → agents/security-checklist.md
- Architecture insights → memory/archive/patterns.md
- Tool discoveries → TOOLS.md
```

## Compound Patterns

### Pattern: Iterative Design
Don't settle for the first design.

```
Round 1: Quick architecture
  ↓
Round 2: Identify weak points
  ↓
Round 3: Redesign problem areas
  ↓
Round 4: Final validation
  ↓
Build
```

### Pattern: Progressive Enhancement
Start simple, compound up.

```
V1: Core functionality, minimal features
  ↓ Review
V2: Add error handling, edge cases
  ↓ Review
V3: Optimize performance
  ↓ Review
V4: Polish UX
  ↓ Ship
```

### Pattern: Multi-Perspective Validation
Get diverse opinions before committing.

```
Technical review (correctness)
  +
Security review (safety)
  +
UX review (usability)
  +
Performance review (efficiency)
  ↓
Synthesis → Final implementation
```

### Pattern: Test-Driven Compounding
Use tests to drive refinement.

```
Write tests for happy path
  ↓ Implement
Write tests for edge cases
  ↓ Fix
Write tests for error conditions
  ↓ Harden
Run full suite
  ↓ Ship
```

## Compounding Mindset

### Questions to Ask Each Iteration

**Design phase:**
- Is this the simplest design that could work?
- What will break first under load?
- Where are the security vulnerabilities?
- How will this evolve in 6 months?

**Build phase:**
- Am I following the architecture?
- Are tests comprehensive?
- Would a reviewer understand this code?
- What assumptions am I making?

**Review phase:**
- What did I miss?
- What could be clearer?
- What will future-me regret?
- Is there a better pattern?

**Refine phase:**
- Which issues matter most?
- Can I simplify instead of adding?
- Have I introduced new problems?
- When is good enough, good enough?

## When to Stop Compounding

You've reached "done" when:
- All critical issues are addressed
- No reviewer finds major flaws
- Tests are comprehensive and passing
- Code is clear enough for future-you
- Further refinement costs more than it's worth

**Don't chase perfection.** Compound until quality is high, then ship.

## Anti-Patterns

### ❌ Analysis Paralysis
```
[Iterate on design 10 times without building anything]
```
**Fix:** Design → Build → Review. Don't design in a vacuum.

### ❌ Ignoring Reviews
```
[Spawn 3 reviewers, ignore all their feedback]
```
**Fix:** If you're not going to act on reviews, don't request them.

### ❌ Endless Refinement
```
[Refine code 5 times for marginal improvements]
```
**Fix:** Define "good enough" criteria upfront.

### ❌ No Learning Capture
```
[Build great thing, forget all lessons next project]
```
**Fix:** Always capture learnings in the right files.

## Tools for Compounding

### File Structure
```
projects/[name]/
├── brief.md              # Original requirements
├── architecture.md       # Design (may have v1, v2, v3)
├── src/                  # Implementation
│   ├── core/
│   └── tests/
├── reviews/              # Review outputs
│   ├── code.md
│   ├── security.md
│   └── ux.md
└── learnings.md          # What we discovered
```

### Version Control
Use git to track iterations:
```
git commit -m "feat: initial implementation"
git commit -m "refactor: address code review feedback"
git commit -m "security: fix injection vulnerability"
git commit -m "perf: optimize query performance"
```

### Review Templates
Standard questions for each review type:

**Code Review:**
- Correctness: Does it work?
- Clarity: Is it readable?
- Maintainability: Can future-you modify it?
- Performance: Any obvious bottlenecks?

**Security Review:**
- OWASP Top 10 vulnerabilities?
- Input validation?
- Authentication/authorization?
- Data exposure?

**UX Review:**
- User flow intuitive?
- Error messages helpful?
- Loading states clear?
- Accessibility considered?

## Compound Engineering in Practice

### Example: API Endpoint

**Round 1: Quick Implementation**
```typescript
app.get('/users/:id', (req, res) => {
  const user = db.getUser(req.params.id);
  res.json(user);
});
```

**Review:**
- No error handling
- No input validation
- No auth check
- SQL injection risk
- No rate limiting

**Round 2: Harden**
```typescript
app.get('/users/:id', authenticate, rateLimit, (req, res) => {
  const userId = validateUserId(req.params.id);
  const user = await db.getUser(userId);
  
  if (!user) return res.status(404).json({ error: 'User not found' });
  if (!canAccess(req.user, user)) return res.status(403).json({ error: 'Forbidden' });
  
  res.json(sanitizeUser(user));
});
```

**Review:**
- Much better, but could be clearer
- Error handling could be centralized
- Validation could be middleware

**Round 3: Polish**
```typescript
app.get('/users/:id',
  authenticate,
  rateLimit,
  validateParams(userIdSchema),
  authorize('user:read'),
  async (req, res) => {
    const user = await db.getUser(req.params.id);
    res.json(sanitizeUser(user));
  }
);
```

**Result:** Clean, secure, maintainable.

### Example: System Design

**Round 1: Naive**
```
User → API → Database
```

**Review:**
- No caching
- No error recovery
- No scalability

**Round 2: Practical**
```
User → API → Cache → Database
            ↓
        Error Logger
```

**Review:**
- Better, but what about auth?
- What about rate limiting?
- What about background jobs?

**Round 3: Production-Ready**
```
User → CDN → Load Balancer
              ↓
         [API Cluster]
         ↓     ↓     ↓
       Cache  Queue  DB
         ↓     ↓     ↓
    [Workers] [Monitoring]
```

**Result:** Scalable, resilient, observable.

## Integration with Other Skills

**Compound Engineering + Orchestration:**
Use multiple agents for each review phase.

**Compound Engineering + Continuous Learning:**
Capture patterns discovered during compounding.

**Compound Engineering + Proactive Agent:**
Proactively suggest areas for refinement.

## Remember

**Good code is built, not born.**

The first version is rarely the best version. Compound engineering gives you:
- Higher quality output
- Fewer bugs in production
- Better long-term maintainability
- Continuous skill improvement

The AI makes iteration fast enough to be worth it.

Use that leverage.

---

*Build. Review. Improve. Repeat. Ship.*
