# skill-audit — Security Audit Checklist

## When to Use
- Before installing any external skill from ClawHub or other sources
- When reviewing skills shared by other users
- Periodic security audits of installed skills

## When NOT to Use
- Skills you wrote yourself (but still review them!)
- Official OpenClaw skills from the core distribution

## Security Checklist

### 1. Source Review
- [ ] **Origin verified** — Known author or trusted source?
- [ ] **Recent activity** — Last updated within 6 months?
- [ ] **Community trust** — Reviews, stars, or vouches from trusted users?

### 2. Code Inspection
- [ ] **Read all scripts** — Scan every `.sh`, `.js`, `.py`, `.ts` file
- [ ] **No hardcoded credentials** — API keys, tokens, passwords in plain text?
- [ ] **No obfuscation** — Base64 blobs, packed code, eval() chains?
- [ ] **Network calls audited** — What external services does it contact?
- [ ] **File system access** — Does it read/write outside its skill directory?

### 3. Permissions & Scope
- [ ] **Minimal permissions** — Does it ask for more access than needed?
- [ ] **Sandboxable** — Can it run in an isolated session?
- [ ] **Data exfiltration risk** — Could it leak sensitive files or credentials?

### 4. Dependencies
- [ ] **NPM/PyPI packages reviewed** — Check `package.json`, `requirements.txt`
- [ ] **Known vulnerabilities** — Run `npm audit` or `pip-audit`
- [ ] **Pinned versions** — Are dependencies locked to specific versions?

### 5. Execution Model
- [ ] **How it runs** — Direct exec? Spawns subagents? Calls external APIs?
- [ ] **Error handling** — Does it fail gracefully or leave artifacts?
- [ ] **Logging** — What gets logged and where?

## Red Flags 🚩

**STOP and investigate if you see:**
- Requests for SSH keys, API tokens, or passwords
- Curl/wget to unknown domains
- Base64-encoded payloads
- `eval()`, `exec()`, or dynamic code execution
- Writes to `~/.ssh/`, `/etc/`, or other system directories
- Network calls without clear documentation
- Minified or obfuscated JavaScript/Python
- Auto-updates without user approval

## Installation Safety

### Safe Install Process
1. Clone/download to a temporary review directory first
2. Read SKILL.md and all referenced files
3. Run this checklist
4. Test in an isolated session with limited permissions
5. Monitor first few runs for unexpected behavior
6. Only then move to `~/clawd/skills/`

### Quarantine Testing
```bash
# Test in isolated directory
mkdir -p /tmp/skill-test
cd /tmp/skill-test
# Extract/clone skill here
# Read all files, run checklist
# Test with: sessions_spawn task="Test skill in /tmp/skill-test"
```

## Post-Install Monitoring

After installing a new skill:
- Check logs after first few uses
- Monitor network activity (if possible)
- Watch for unexpected file changes
- Review what data it accesses

## Reporting Issues

If you find security issues in a skill:
1. **Do not use it**
2. Document the issue
3. Notify the author (if known)
4. Warn the community (ClawHub, Discord)
5. Remove from your system

## Trusted Sources

Maintain a list of trusted skill authors:
- Official OpenClaw team
- Verified community contributors
- Skills you've personally audited

## Remember

**Skills run with YOUR permissions.** A malicious skill can:
- Read your files
- Access your APIs
- Send your data anywhere
- Modify your system

**When in doubt, don't install it.**

---

*Security is not paranoia. It's due diligence.*
