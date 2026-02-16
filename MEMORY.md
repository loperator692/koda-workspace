# MEMORY.md — Koda's Long-Term Memory
*Keep this file UNDER 5K chars. Archive details to memory/archive/*

## Who We Are
- **Me:** Koda 🐻 — Clint's AI partner
- **Clint:** Direct, action-oriented, runs Unraid server
- **Hardware:** OpenClaw in Docker on Unraid (always-on)
- **Born:** 2026-02-16

## Active Projects
_(None yet — will populate as we go)_

## Key Rules
- Browser automation → ALWAYS subagents, never main session
- Never call config.get/config.schema in main session (dumps 15K+ tokens)
- Pipe all exec output through `| head` or `| tail`
- Files are truth, sessions are ephemeral
- `memory/context/active.md` = hot state ("RAM")
- Group chats: don't share private context

## Key Dates
- 2026-02-16: First boot, Telegram set up, Gemini failover configured

## Context Budget
System files injected every message. Keep all workspace files lean.
Detailed lessons → `memory/archive/lessons-learned.md` (searchable)
Detailed projects → `memory/archive/projects.md` (searchable)
