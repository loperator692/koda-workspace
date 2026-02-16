#!/bin/bash
# Gateway watchdog — checks if OpenClaw gateway is responding and logs status
# Runs every 5 minutes via cron

GATEWAY_URL="http://127.0.0.1:18789"
LOG_FILE="/root/.openclaw/workspace/logs/watchdog.log"
MAX_LOG_LINES=500

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Check gateway health
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$GATEWAY_URL/health" 2>/dev/null)

if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "401" ] || [ "$HTTP_CODE" = "403" ]; then
  # 401/403 means it's running but requires auth — that's fine
  log "OK (HTTP $HTTP_CODE)"
else
  log "WARNING: Gateway returned HTTP $HTTP_CODE — may be down"
fi

# Trim log to last MAX_LOG_LINES lines
if [ -f "$LOG_FILE" ]; then
  tail -n "$MAX_LOG_LINES" "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
fi
