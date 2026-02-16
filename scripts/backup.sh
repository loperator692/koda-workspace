#!/bin/bash
# Nightly workspace backup to GitHub
cd /root/.openclaw/workspace || exit 1

git add -A
git diff --cached --quiet && echo "Nothing to commit" && exit 0

git commit -m "Auto backup: $(date '+%Y-%m-%d %H:%M')"
git push origin master && echo "Backup pushed successfully" || echo "Backup push FAILED"
