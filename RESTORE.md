# OpenClaw Restore Guide

## Quick Restore (if machine is lost)

### 1. Reinstall OpenClaw
```bash
npm install -g openclaw
openclaw init
```

### 2. Restore from GitHub (workspace + memory)
```bash
cd ~/.openclaw
git clone https://github.com/logmoveragent8/wukong.git workspace
```

### 3. Restore full backup (config, credentials, agents)
```bash
cd ~/.openclaw/backups
tar -xzf openclow-backup-2026-03-08_14-39.tar.gz -C ~
```

### 4. Restart OpenClaw
```bash
openclaw gateway restart
```

## Backup Locations
- **Daily (workspace only):** GitHub - https://github.com/logmoveragent8/wukong
- **Weekly (full):** `~/.openclaw/backups/`

## What's in Full Backup
- `openclaw.json` - Main config
- `credentials/` - API keys, tokens
- `agents/` - Agent configs
- `workspace/` - Your files
- `memory/` - Long-term memory
- `telegram/` - Telegram session
- `identity/` - Identity files
- `canvas/` - Canvas data
- `media/` - Media files

## What's NOT Backed Up
- Logs
- Delivery queue (temporary)
- Exec approvals (regenerated)
