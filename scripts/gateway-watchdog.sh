#!/bin/bash
# Gateway Watchdog — Checks if OpenClaw gateway is responsive, restarts if needed
# Runs every 5 minutes via OpenClaw cron

GATEWAY_URL="ws://127.0.0.1:18789"
GATEWAY_TOKEN="A-oJaou-rPqXa4guByRYI1lhVnSfROfN2rSVJ-UsOFQ"
LOG_FILE="/root/.openclaw/workspace/logs/gateway-watchdog.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Ensure log directory exists
mkdir -p /root/.openclaw/workspace/logs

# Function to log messages
log() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Check if gateway process is running
if ! pgrep -f "openclaw.*gateway" > /dev/null; then
    log "ERROR: Gateway process not found"
    exit 1
fi

# Check if gateway is responsive (try to connect)
# Using curl to test WebSocket endpoint health
HTTP_URL="http://127.0.0.1:18789/health"
if curl -sf "$HTTP_URL" > /dev/null 2>&1; then
    log "OK: Gateway responsive"
    exit 0
else
    log "WARNING: Gateway not responsive at $HTTP_URL"
    # In Docker, we can't easily restart the gateway ourselves
    # Log the issue - Unraid/Docker should handle restarts
    exit 1
fi
