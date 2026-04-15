# HEARTBEAT.md

This file is for your proactive checks during heartbeats.

- **Check for urgent emails (if configured)**
- **Review upcoming calendar events (if configured)**
- **Check for social media mentions (if configured)**
- **Brief weather check (if relevant)**
- **Check OpenClaw update status (safe check)** (`openclaw update status`)

**EVERY HEARTBEAT:** Check if today's memory file exists and is up to date.
- File: 'memory/YYYY-MM-DD.md'
- Create if missing, update if stale (last update > 1 hours ago)
- IMPORTANT: Out of all current sessions, log a summary of what has been discussed and done.
Include all neccessary information and leave out fluff.  Don't dupicate yourself.
- IMPORTANT: Out of all current sessions, identify if there were any significant new thoughts, decidsions, opinions, lessons learned that need to be remembered and put into your longterm memory in MEMORY.md.  Do this only when significant.
- Use **change-only logging** in daily meory: log only new errors, recoverries, manual interventions (skip repetitive "all good" boilerplate)
- Add exactly one brief **EOD summary line** capturing the day's heartbeat output

## Nightly Review (1 AM)

When triggered by `nightly-review` system event:

1. Read today's `memory/YYYY-MM-DD.md`
2. Read recent memory files (last 3 days)
3. **Extract important info** to appropriate layer:
   - New facts → `resources/user.md`
   - Preferences/habits → `resources/tacit.md`
   - Project updates → `projects/`
   - Area status changes → `areas/`
4. Update `resources/index.md` with any new topics
5. Move completed projects to `archive/`
6. Summarize to user if anything important
