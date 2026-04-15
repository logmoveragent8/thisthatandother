# OpenClaw Filesystem Map (This Machine)

Generated for: `logmover-XT13`

---

## 1) Global runtime/state (`~/.openclaw`)

```text
~/.openclaw/
├── openclaw.json                  # Primary OpenClaw config (gateway/models/tools/channels)
├── openclaw.json.bak*             # Config backups
├── update-check.json              # Update check cache/metadata
├── exec-approvals.json            # Runtime exec approval state
│
├── agents/
│   └── main/                      # Main agent runtime/session artifacts
│
├── canvas/
│   └── index.html                 # Canvas host page
│
├── completions/                   # Shell completion scripts
│   ├── openclaw.bash
│   ├── openclaw.zsh
│   ├── openclaw.fish
│   └── openclaw.ps1
│
├── credentials/                   # Channel/provider credential artifacts
│   ├── telegram-default-allowFrom.json
│   ├── telegram-pairing.json
│   └── whatsapp/...               # WhatsApp credential/session subdir
│
├── cron/
│   ├── jobs.json                  # Cron job definitions
│   ├── jobs.json.bak              # Cron backup
│   └── runs/                      # Per-job run logs (JSONL)
│
├── delivery-queue/
│   └── failed/                    # Failed queued outbound deliveries
│
├── devices/
│   ├── paired.json                # Approved paired devices/nodes
│   └── pending.json               # Pending pairing requests
│
├── identity/
│   ├── device.json                # Local device identity
│   └── device-auth.json           # Device auth token/material
│
├── logs/
│   └── config-audit.jsonl         # Config audit trail
│
├── media/
│   └── inbound/                   # Inbound media cache/storage
│
├── memory/
│   └── main.sqlite                # Memory index DB
│
└── telegram/
    └── update-offset-default.json # Telegram update offset checkpoint
```

---

## 2) Workspace (`~/.openclaw/workspace`)

```text
~/.openclaw/workspace/
├── AGENTS.md                      # Startup + operating rules
├── SOUL.md                        # Persona/voice/behavior
├── USER.md                        # User profile/context
├── IDENTITY.md                    # Assistant identity (name/vibe/emoji)
├── HEARTBEAT.md                   # Heartbeat task instructions
├── TOOLS.md                       # Local environment notes
├── MEMORY.md                      # Curated long-term memory
├── BOOTSTRAP.md                   # Initial bootstrap guide (if still present)
│
├── openclaw.json                  # Workspace-scoped config copy
├── openclaw.json.bak*             # Config backups
├── update-check.json              # Workspace update metadata cache
│
├── openclaw-architecture-report.md    # Detailed architecture report
├── openclaw-architecture-diagram.md   # Mermaid architecture diagrams
├── openclaw-filesystem-map.md         # This file
│
├── memory/
│   ├── YYYY-MM-DD.md              # Daily memory logs
│   ├── conventions.md             # Memory writing conventions
│   └── heartbeats.md              # Heartbeat memory notes
│
├── resources/
│   ├── index.md                   # Resource topic index
│   ├── user.md                    # Durable user facts
│   ├── tacit.md                   # Preferences/habits/tacit knowledge
│   └── capabilities.md            # Assistant capability notes
│
├── areas/                         # Ongoing responsibility areas
├── projects/                      # Active project work
├── archive/                       # Archived/completed material
├── references/                    # External/imported reference docs
├── scripts/                       # Local helper scripts
│
├── agents/
│   └── main/
│       ├── agent/                 # Agent-scoped data
│       └── sessions/              # Session/transcript artifacts
│
├── cron/
│   ├── jobs.json                  # Workspace cron definitions
│   └── jobs.json.bak
│
├── devices/
│   ├── paired.json                # Workspace mirror of device pairing
│   └── pending.json
│
├── identity/
│   ├── device.json
│   └── device-auth.json
│
├── logs/
│   └── config-audit.jsonl
│
├── canvas/
│   └── index.html
│
├── completions/
│   ├── openclaw.bash
│   ├── openclaw.zsh
│   ├── openclaw.fish
│   └── openclaw.ps1
│
├── .openclaw/
│   └── workspace-state.json       # Workspace runtime metadata
│
├── .pi/                           # Local runtime/app metadata
└── .git/                          # Git repository data
```

---

## 3) OpenClaw documentation install (read-only package docs)

```text
~/.npm-global/lib/node_modules/openclaw/docs/
├── concepts/                      # Architecture, memory, core concepts
├── gateway/                       # Gateway protocol/config/security/troubleshooting
├── channels/                      # Channel integration docs
├── tools/                         # Tool behavior/policy docs
├── automation/                    # Cron/heartbeat/hooks docs
├── cli/                           # CLI command reference
├── web/                           # Control UI/Web docs
└── ...
```

---

## Notes

- `~/.openclaw` is the canonical runtime/state area.
- `~/.openclaw/workspace` is the human-editable operating workspace.
- Some files appear in both places due to workspace mirrors/sync patterns.
