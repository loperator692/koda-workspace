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
| clintons-macbook-pro-1 | 100.65.123.28 | ✅ loperator@100.65.123.28 | macOS Darwin 21.6.0 (x86_64) |
| plextopia (Unraid) | 100.123.234.55 | ✅ root@100.123.234.55 | SSH key installed at ~/.ssh/unraid_key |
| Sparky (iPhone) | TBD | N/A | OpenClaw nodes for camera/location |

## Unraid SSH
- Host: root@100.123.234.55
- Key: ~/.ssh/unraid_key (installed)
- Usage: `ssh -i ~/.ssh/unraid_key root@100.123.234.55 "command"`

## Email (Himalaya v1.1.0)
- Binary: `/usr/local/bin/himalaya`
- Config: `~/.config/himalaya/config.toml`
- Accounts: `gmail` (default), `icloud`
- Gmail: clint.poduska@gmail.com
- iCloud: loperator@icloud.com
- Usage: `himalaya envelope list` / `himalaya envelope list --account icloud`

## Calendar (vdirsyncer + khal)
- Sync: `vdirsyncer sync icloud_cal` (syncs iCloud CalDAV locally)
- View: `khal list` (upcoming events)
- Local store: `~/.local/share/calendars/icloud/`
- Calendars: Clinton (home), Parenting, Family, Melissa, Workday
- Config: `~/.config/vdirsyncer/config` + `~/.config/khal/config`
- Note: Google Calendar needs OAuth2 setup (TODO)

## Home Assistant
- URL: http://172.17.0.1:8123 (confirmed running, needs token)
- Token: TODO — Clint needs to provide Long-Lived Access Token

## TTS
- Built-in `tts` tool available
- Preferred voice: <!-- TBD — ask Clint: built-in vs ElevenLabs? -->

---

_Add tools as they're installed. Keep this lean._
