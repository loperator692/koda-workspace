# CREDENTIALS - Setup Status Tracker

**Purpose:** Track what's configured so I don't ask for the same credentials twice.

## Email (Himalaya)
- ✅ Gmail: clint.poduska@gmail.com
  - Config: `~/.config/himalaya/config.toml`
  - App password: stored in config
  - Set up: 2026-02-19
  - Status: Working ✅
  
- ✅ iCloud: loperator@icloud.com
  - Config: `~/.config/himalaya/config.toml`
  - App password: stored in config (same as CalDAV)
  - Set up: 2026-02-19
  - Status: Working ✅

## Calendar (vdirsyncer + khal)
- ✅ iCloud CalDAV: loperator@icloud.com
  - Config: `~/.config/vdirsyncer/config` + `~/.config/khal/config`
  - App password: stored in vdirsyncer config (same as email)
  - Set up: 2026-02-21
  - Status: Working ✅
  - Note: Used in morning briefing for location detection

- ⬜ Google Calendar: TODO
  - Needs OAuth2 setup (more complex than app password)
  - Low priority

## API Keys (in openclaw.json env)
- ✅ GEMINI_API_KEY
- ✅ OPENAI_API_KEY
- ✅ ELEVENLABS_API_KEY
- ✅ GROQ_API_KEY (implicit via OpenRouter)
- ✅ OPENROUTER_API_KEY (implicit)

## SSH Keys
- ✅ Unraid: `~/.ssh/unraid_key` → root@100.123.234.55
- ⬜ Mac: Remote Login not enabled yet

## Services Pending Setup
- ⬜ Home Assistant: Token needed (URL confirmed: http://172.17.0.1:8123)
- ⬜ Find My iPhone API: Not needed (using calendar instead)

---

**Rule:** Before asking for ANY credential, check this file + actual config files first.
