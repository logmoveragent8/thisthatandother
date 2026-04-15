# Heartbeats - Proactive Checks

When you receive a heartbeat poll, don't just reply `HEARTBEAT_OK` — use it productively!

## When to Respond

**Reply with actual content when:**
- Important email arrived
- Calendar event coming up (<2h)
- Something interesting you found
- It's been >8h since you said anything
- Heartbeat checklist has items due

**Reply HEARTBEAT_OK when:**
- Late night (23:00-08:00) unless urgent
- Human is clearly busy
- Nothing new since last check
- You just checked <30 minutes ago

## Heartbeat vs Cron

**Use heartbeat when:**
- Multiple checks can batch together (inbox + calendar + notifications)
- You need conversational context from recent messages
- Timing can drift slightly (~30 min is fine)
- Want to reduce API calls by combining checks

**Use cron when:**
- Exact timing matters ("9:00 AM sharp every Monday")
- Task needs isolation from main session history
- One-shot reminders ("remind me in 20 minutes")
- Output should deliver directly to a channel

## Checks to Rotate (2-4x/day)

- **Emails** — Any urgent unread messages?
- **Calendar** — Upcoming events in next 24-48h?
- **Mentions** — Twitter/social notifications?
- **Weather** — Relevant if human might go out?
- **OpenClaw updates** — Check `openclaw update`

## Track Checks

Store state in `memory/heartbeat-state.json`:

```json
{
  "lastChecks": {
    "email": 1703275200,
    "calendar": 1703260800,
    "weather": null
  }
}
```

## Proactive Work (Without Asking)

- Read and organize memory files
- Check on projects (git status)
- Update documentation
- Commit and push your own changes
- Review and update MEMORY.md

## Memory Maintenance

Periodically (every few days), use a heartbeat to:

1. Read through recent `memory/YYYY-MM-DD.md` files
2. Identify significant events, lessons, or insights worth keeping long-term
3. Update `MEMORY.md` with distilled learnings
4. Remove outdated info from MEMORY.md that's no longer relevant

**Goal:** Be helpful without being annoying. Check in a few times a day, do useful background work, respect quiet time.

## HEARTBEAT.md Priority

If `HEARTBEAT.md` exists in workspace, follow it strictly. It may contain specific checklist items for the current day.
