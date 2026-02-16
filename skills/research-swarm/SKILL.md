# Research Swarm Skill

## When to Use
- Deep research requiring multiple angles
- Competitive analysis
- Technical comparisons across many options
- Any research task that would benefit from parallel investigation

## When NOT to Use
- Quick factual lookups (just use web_search directly)
- Single-source tasks
- Time-sensitive queries (swarms take 2-5 minutes)

## How It Works
Spawn multiple researcher subagents in parallel, each with a specific angle. Collect results, synthesize.

## Quick Start

```
# Spawn 3 parallel researchers
sessions_spawn task="Read /root/.openclaw/workspace/agents/researcher.md. Research: [TOPIC] - focus on [ANGLE 1]. Return: key findings + sources."
sessions_spawn task="Read /root/.openclaw/workspace/agents/researcher.md. Research: [TOPIC] - focus on [ANGLE 2]. Return: key findings + sources."
sessions_spawn task="Read /root/.openclaw/workspace/agents/researcher.md. Research: [TOPIC] - focus on [ANGLE 3]. Return: key findings + sources."
```

Then synthesize results when all three return.

## Notes
- Stagger spawns 30s apart if hitting rate limits
- Each agent should have a distinct, non-overlapping angle
- Synthesis is your job — don't spawn a 4th agent for that
