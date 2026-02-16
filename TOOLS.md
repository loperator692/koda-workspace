# TOOLS.md - Local Notes & Routing

## 🚦 ROUTING TABLE (Check First!)

**Web content — cascade:**
1. `web_fetch` → 2. `browser` tool → 3. Tell user

**Research tasks:** spawn subagent (don't burn main session context)
**Browser automation:** ALWAYS spawn subagent
**File search:** `memory_search` first, then `exec grep`

---

## Environment
- **Platform:** Unraid (Docker container)
- **No CLI access:** Cannot run `openclaw` commands directly — edit config files + restart container
- **Config location:** `/root/.openclaw/openclaw.json`
- **Gateway tools** (cron/nodes/gateway): use `gatewayToken="koda-local-gateway"` + `gatewayUrl="ws://127.0.0.1:18789"`

## Models
- **Primary:** anthropic/claude-opus-4-6
- **Fallback 1:** google/gemini-2.5-pro (free)
- **Fallback 2:** google/gemini-2.5-flash (free)

## Channels
- **Telegram:** Connected and paired

## Tailscale
- Unraid host: `plextopia` — `100.123.234.55` — `plextopia.spangled-mine.ts.net`
- Accessible from container via host's Tailscale (no Tailscale needed inside container)
- Note: `100.123.234.55` routes to Nextcloud (not Unraid UI directly)

## Machines (via Tailscale)
| Machine | IP | SSH | Notes |
|---|---|---|---|
| casper-1 | 100.70.201.31 | ✅ port 22 open | Windows VM |
| clintons-macbook-pro-1 | 100.65.123.28 | ❌ Remote Login off | Enable in System Settings → Sharing |
| plextopia (Unraid) | 100.123.234.55 | TBD | Routes to Nextcloud on port 80 |
| Sparky (iPhone) | TBD | N/A | OpenClaw nodes for camera/location |

## TTS
- Built-in `tts` tool available
- Preferred voice: <!-- TBD -->

---

_Add tools as they're installed. Keep this lean._
