# orchestration — Multi-Agent Coordination Patterns

## When to Use
- Task requires multiple specialized perspectives (code review + security audit)
- Parallel research needed (multiple sources, different angles)
- Complex workflows with distinct phases (plan → build → review → deploy)
- Main session context budget is tight

## When NOT to Use
- Simple single-step tasks
- When a single agent can complete it faster
- When coordination overhead exceeds task complexity

## Core Principles

### 1. One Brain, Many Hands
You spawn subagents, but YOU orchestrate. Think of it like a conductor with an orchestra.

### 2. Clear Handoffs
Each agent needs:
- **Clear input** — What to work on
- **Success criteria** — What "done" looks like
- **Context location** — Where to read background (files, not messages)

### 3. Stagger Spawns
**Critical:** Wait 30 seconds between spawns to avoid undici TLS connection bug.

```javascript
// Bad: All at once
sessions_spawn task="Agent 1 task"
sessions_spawn task="Agent 2 task"
sessions_spawn task="Agent 3 task"

// Good: Stagger with delays
sessions_spawn task="Agent 1 task"
// ... wait 30 seconds ...
sessions_spawn task="Agent 2 task"
// ... wait 30 seconds ...
sessions_spawn task="Agent 3 task"
```

### 4. File-Based Coordination
Agents communicate through files, not messages.

**Bad:** Agent A tries to message Agent B
**Good:** Agent A writes results to `projects/foo/analysis.md`, Agent B reads it

## Orchestration Patterns

### Pattern: Parallel Research
Multiple agents research different aspects of the same topic.

```
Spawn:
- Agent 1: "Research X from academic sources → projects/research/academic.md"
- Agent 2: "Research X from industry blogs → projects/research/industry.md"
- Agent 3: "Research X from community forums → projects/research/community.md"

Main agent:
- Wait for all three
- Synthesize findings from the three files
- Write final report
```

### Pattern: Sequential Pipeline
Each agent builds on the previous agent's output.

```
Phase 1: Architect
- "Read ~/clawd/agents/architect.md. Design system for [feature] → projects/foo/architecture.md"

Phase 2: Builder (after Phase 1 completes)
- "Read projects/foo/architecture.md. Implement core components → projects/foo/src/"

Phase 3: Reviewer (after Phase 2 completes)
- "Read ~/clawd/agents/code-reviewer.md. Review projects/foo/src/ → projects/foo/review.md"

Phase 4: Main agent
- Review findings, iterate or ship
```

### Pattern: Multi-Perspective Review
Get diverse opinions on a proposal.

```
Spawn simultaneously (stagger 30s apart):
- Security reviewer: "Audit for OWASP Top 10"
- Code reviewer: "Check maintainability, patterns"
- Architect: "Evaluate scalability, design coherence"
- User advocate: "Review from user experience perspective"

Main agent:
- Collect all reviews
- Identify conflicts and overlaps
- Make final decision
```

### Pattern: Research Swarm
Broad exploration of a complex topic.

```
Spawn 5-10 researchers with different angles:
- "Find recent papers on X"
- "Identify key practitioners discussing X"
- "Locate code examples demonstrating X"
- "Research historical context of X"
- "Find contrary viewpoints on X"

Main agent:
- Aggregate findings
- Identify patterns and gaps
- Write comprehensive synthesis
```

## Subagent Task Format

### Good Task Instructions
```
Read ~/clawd/agents/code-reviewer.md first.

Review the changes in projects/api-refactor/src/:
- Security: Check for injection vulnerabilities
- Performance: Flag N+1 queries, inefficient loops
- Maintainability: Assess code clarity and patterns

Write findings to projects/api-refactor/review-code.md

Success criteria:
- All files reviewed
- Issues categorized by severity
- Specific line numbers referenced
```

### Bad Task Instructions
```
Review the code and let me know what you think
```

**Why bad:**
- No context file to read
- Vague scope ("the code")
- No output location
- No success criteria
- No specialization guidance

## Tracking Subagents

### List Running Subagents
```
subagents action=list
```

### Steer a Subagent
```
subagents action=steer target="<session-key>" message="Focus on security issues only"
```

### Kill a Subagent
```
subagents action=kill target="<session-key>"
```

## Common Mistakes

### ❌ Spawning Without Stagger
**Problem:** TLS connection bug crashes multiple spawns
**Fix:** Wait 30 seconds between each spawn

### ❌ No Output Destination
**Problem:** Subagent delivers results via message, main session doesn't see it
**Fix:** Always specify: "Write results to [file-path]"

### ❌ Vague Instructions
**Problem:** Subagent asks clarifying questions, loses time
**Fix:** Include success criteria, context files, specific scope

### ❌ Ignoring Context Budget
**Problem:** Spawning in main session when you should spawn isolated agents
**Fix:** Main session orchestrates, subagents execute

### ❌ No Consolidation Phase
**Problem:** Spawn 5 agents, then forget to synthesize their outputs
**Fix:** Always plan the final synthesis step

## File Organization for Multi-Agent Work

```
projects/my-project/
├── brief.md              # Original task, context
├── architecture.md       # Architect's output
├── implementation/       # Builder's output
│   ├── src/
│   └── tests/
├── reviews/              # Reviewer outputs
│   ├── code-review.md
│   ├── security-audit.md
│   └── ux-review.md
└── synthesis.md          # Main agent's final consolidation
```

## Timing Considerations

### When to Use Subagents
- Task takes >5 minutes
- Main session context is filling up
- You need specialized perspectives
- Parallel work saves time

### When to Do It Yourself
- Task takes <2 minutes
- You already have the context loaded
- Spawning overhead exceeds task time
- Sequential steps with tight coupling

## Advanced: Focus Group Pattern

Spawn 12 personas (from `agents/focus-group/`) to test ideas:

```
For each persona in focus-group/:
  sessions_spawn task="Read agents/focus-group/[persona].md. Review [content] → feedback/[persona].md"

Main agent:
  Synthesize feedback/
  Identify common themes
  Highlight outlier perspectives
```

## Advanced: Swarm Intelligence

V2 multi-agent swarm from the guide:
- **Researcher** — Gathers data
- **List Builder** — Compiles targets
- **Outreach** — Executes communication
- **Analyst** — Synthesizes results

Each agent has a defined role, input/output contract, and coordination protocol.

## Orchestration Checklist

Before spawning subagents:
- [ ] Task is complex enough to justify coordination overhead
- [ ] Each agent has a clear, distinct role
- [ ] Output files are defined
- [ ] Context files are prepared
- [ ] Success criteria are explicit
- [ ] Stagger timing is planned (30s between spawns)
- [ ] Consolidation phase is designed

## Remember

**You are the conductor, not just another musician.**

Subagents execute. You:
- Define the strategy
- Assign the work
- Ensure coordination
- Synthesize results
- Make final decisions

Multi-agent workflows are powerful, but only when orchestrated deliberately.

---

*Many minds, one vision. That's orchestration.*
