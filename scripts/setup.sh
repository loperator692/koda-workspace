#!/bin/bash
# setup.sh — Run this after a container rebuild to restore Koda's environment
# Idempotent: safe to run multiple times
set -e

echo "=== Koda Setup Script ==="
echo "Restoring environment after container rebuild..."
echo ""

# ── 1. Himalaya (email CLI) ───────────────────────────────────────────────────
echo "[1/3] Installing Himalaya..."
if ! command -v himalaya &>/dev/null; then
  curl -sSL https://raw.githubusercontent.com/pimalaya/himalaya/master/install.sh | sh
  echo "✅ Himalaya installed: $(himalaya --version | head -1)"
else
  echo "✅ Himalaya already installed: $(himalaya --version | head -1)"
fi

# ── 2. Himalaya config ────────────────────────────────────────────────────────
echo ""
echo "[2/3] Writing Himalaya config..."
mkdir -p ~/.config/himalaya

cat > ~/.config/himalaya/config.toml << 'EOF'
[accounts.gmail]
default = true
email = "clint.poduska@gmail.com"
display-name = "Clint Poduska"
downloads-dir = "/root/Downloads"
backend.type = "imap"
backend.host = "imap.gmail.com"
backend.port = 993
backend.login = "clint.poduska@gmail.com"
backend.encryption.type = "tls"
backend.auth.type = "password"
backend.auth.command = "echo soodngrchtkjdmxs"
message.send.backend.type = "smtp"
message.send.backend.host = "smtp.gmail.com"
message.send.backend.port = 465
message.send.backend.login = "clint.poduska@gmail.com"
message.send.backend.encryption.type = "tls"
message.send.backend.auth.type = "password"
message.send.backend.auth.command = "echo soodngrchtkjdmxs"

[accounts.icloud]
email = "loperator@icloud.com"
display-name = "Clint (iCloud)"
downloads-dir = "/root/Downloads"
backend.type = "imap"
backend.host = "imap.mail.me.com"
backend.port = 993
backend.login = "loperator@icloud.com"
backend.encryption.type = "tls"
backend.auth.type = "password"
backend.auth.command = "echo amrgmpirmazjroow"
message.send.backend.type = "smtp"
message.send.backend.host = "smtp.mail.me.com"
message.send.backend.port = 587
message.send.backend.login = "loperator@icloud.com"
message.send.backend.encryption.type = "start-tls"
message.send.backend.auth.type = "password"
message.send.backend.auth.command = "echo amrgmpirmazjroow"
EOF

# Quick connectivity test
echo "Testing Gmail..."
if himalaya envelope list --page-size 1 &>/dev/null; then
  echo "✅ Gmail connected"
else
  echo "⚠️  Gmail test failed — app password may need rotation"
fi

echo "Testing iCloud..."
if himalaya envelope list --account icloud --page-size 1 &>/dev/null; then
  echo "✅ iCloud connected"
else
  echo "⚠️  iCloud test failed — app password may need rotation"
fi

# ── 3. SSH keys (Unraid) ──────────────────────────────────────────────────────
echo ""
echo "[3/3] SSH key check..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ -f ~/.ssh/unraid_key ]; then
  echo "✅ Unraid SSH key already present"
else
  echo "⚠️  Unraid SSH key missing (~/.ssh/unraid_key)"
  echo "   Run: ssh-keygen -t ed25519 -f ~/.ssh/unraid_key"
  echo "   Then: ssh-copy-id -i ~/.ssh/unraid_key root@100.123.234.55"
fi

echo ""
echo "=== Setup complete! ==="
echo "If any ⚠️  warnings appeared, address them before the morning briefing."
