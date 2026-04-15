# MEMORY.md - Curated Long-Term Memory

**Purpose:** Distilled wisdom, significant events, and things that matter across sessions.

**IMPORTANT:** Only load in main private session (direct chats). Never load in group contexts.

## About Logmover

- Name: Logmover
- Location: Frisco, TX (DFW area)
- Timezone: America/Chicago
- Typical weather: Warm, TX climate

## About Wukong (Me)

- Name: Wukong
- Creature: AI assistant
- Vibe: Helpful, resourceful, playful
- Emoji: 🐒

## Key Preferences

(To be filled in as I learn more)

## Important Context

- Using MiniMax M2.5 model
- Workspace at /home/logmover/.openclaw/workspace
- Host: Geekom XT13 Pro

## Security Audit Findings (Apr 1, 2026)

- No firewall installed (ufw/firewalld absent)
- SSH exposed on all interfaces
- CUPS (port 631) exposed — should review if unused
- Tailscale serve enabled
- GCP project 315394173472 needs Generative Language API enabled (blocking QMD/memory search)
- OpenAI Codex OAuth refresh failed — model auth broken
- Risk profile not yet determined — user hasn't selected a posture

## Three-Tier Memory System

Based on Ray Fernando's research:

- **Tier 1** (expensive): AGENTS.md, SOUL.md, USER.md, MEMORY.md — loaded every turn
- **Tier 2** (cheap): memory/*.md files — searchable on demand via QMD, zero tokens until needed
- **Tier 3** (free): Any file on disk — read when needed

**Key principle:** Never delete information — move to searchable memory files instead.

## Project Notes

### OpenClaw Setup

- OpenClaw 2026.2.26
- Gateway running locally on port 18789
- Telegram + WhatsApp enabled
- QMD backend enabled (experimental, needs SQLite)
- Models: MiniMax-M2.5 (default), Gemini 3 Pro, Gemini 2.5 Flash Lite

### Spiceworks Automation

- Cloud help desk (free plan — no API)
- Need to implement: 72-hour reminder for tickets waiting on user
- Options: Email-based automation or browser scraping

## Lessons Learned

- Memory time is baked in at session start — use session_status for current time
- QMD requires SQLite to be installed
- Heartbeat checks need approval — may skip if denied
- Google Generative Language API must be enabled for memory search (QMD embeddings) - project 315394193472 needs API enabled
- OpenAI Codex OAuth token refresh can fail - may need re-authentication
- Heartbeat cannot run exec commands requiring approval — heartbeat context doesn't support exec approvals, causing timeouts on memory file updates and scheduled checks
- GCP API (Generative Language) must be enabled for QMD/memory search to work

## TODO

- [ ] Set up exec allowlist policy (heartbeat blocked 2+ days — cron can't approve exec)
- [ ] Enable GCP Generative Language API (project 315394193472) — unblocks memory search/QMD
- [ ] Set up Spiceworks reminder automation
- [ ] Create morning brief / dream cycle
- [ ] Optimize QMD setup
- [ ] Install Obsidian (downloaded, needs sudo install)
- [ ] Re-authenticate OpenAI Codex OAuth
- [ ] Address security audit findings (firewall, SSH/CUPS exposure, risk profile)
