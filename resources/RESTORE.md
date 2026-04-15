# OpenClaw Disaster Recovery Guide

**Last Updated:** 2026-03-08  
**Machine:** logmover-XT13 (Geekom XT13 Pro)  
**GitHub:** https://github.com/logmoveragent8/wukong

---

## Scenario 1: Machine Unreachable / Hardware Failure

### Prerequisites
- New machine or fresh Ubuntu install
- Internet connection
- GitHub access (account: logmoveragent8)

### Recovery Steps

#### Step 1: Install OpenClaw
```bash
# Install Node.js if not present
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install OpenClaw
npm install -g openclaw
```

#### Step 2: Initialize OpenClaw
```bash
openclaw init
# Follow prompts - use same configuration as before
```

#### Step 3: Restore from GitHub (Quickest)
```bash
cd ~/.openclaw
rm -rf workspace
git clone https://github.com/logmoveragent8/wukong.git workspace
```

#### Step 4: Restore Full Backup (If Available)
```bash
# If backup file exists locally or on USB
cd ~
tar -xzf /path/to/openclow-backup-YYYY-MM-DD_HH-MM.tar.gz
```

#### Step 5: Restore Credentials
```bash
# Copy credentials back (IMPORTANT for API access)
cp -r ~/backup/credentials ~/.openclaw/
```

#### Step 6: Start OpenClaw
```bash
openclaw gateway start
openclaw status
```

---

## Scenario 2: Clean Reinstall (No Backup File)

### If You Have GitHub Access Only

```bash
# 1. Install OpenClaw
npm install -g openclaw
openclaw init

# 2. Clone workspace
cd ~/.openclaw
git clone https://github.com/logmoveragent8/wukong.git workspace

# 3. Manually reconfigure:
# - channels (Telegram, WhatsApp)
# - model providers
# - any integrations
```

### What's Lost Without Full Backup
- Telegram session (will need to re-auth)
- WhatsApp session (will need to re-link)
- API credentials (must re-enter)
- Any custom agent configurations

---

## Scenario 3: Partial Restore (Single File/Directory)

### Restore Workspace Only
```bash
cd ~/.openclaw/workspace
git fetch origin
git reset --hard origin/master
```

### Restore Memory Only
```bash
cd ~/.openclaw/workspace/memory
git fetch origin
git reset --hard origin/master
```

### Restore Specific File
```bash
cd ~/.openclaw/workspace
git checkout origin/master -- path/to/file
```

---

## Backup Locations Reference

### Automatic Backups
| Type | Schedule | Location |
|------|----------|----------|
| Workspace (Git) | Daily 1 AM | github.com/logmoveragent8/wukong |
| Full Backup | Sun 2 AM | ~/.openclaw/backups/ |

### Manual Backup Commands
```bash
# Workspace only
~/.openclaw/backup-workspace.sh

# Full backup
~/.openclaw/backup-full.sh
```

---

## Configuration Reference

### OpenClaw Version
Check: `openclaw --version`

### Current Setup
- **Gateway Port:** 18789
- **Auth:** Token-based
- **Channels:** Telegram, WhatsApp
- **Default Model:** gemini-2.5-flash-lite (google-vertex)

### Environment
- **OS:** Ubuntu 24.04 (Noble)
- **Host:** logmover-XT13
- **Tailscale:** Enabled (serve mode)

---

## Emergency Contacts

- **GitHub:** logmoveragent8
- **Tailscale Network:** logmover-xt13 (100.92.182.120)

---

## Verification Checklist After Restore

- [ ] `openclaw status` shows gateway running
- [ ] Telegram bot responds
- [ ] WhatsApp linked and working
- [ ] Default model works (`openclaw models status`)
- [ ] Heartbeats active
- [ ] Memory files loaded correctly
- [ ] Tailscale connected (if needed)

---

## Notes

- Full backup (~3.5MB) includes everything except logs and temp files
- Backup script keeps last 7 full backups
- GitHub backup is incremental (only changes)
- Credentials folder is CRITICAL - keep separate backup if possible
