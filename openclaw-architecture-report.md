# OpenClaw Architecture Report

## Executive summary

OpenClaw is built around a **single long-running Gateway process** that acts as:

1. **Control plane** (WebSocket RPC/events for clients and tools)
2. **Messaging hub** (channel adapters such as WhatsApp/Telegram/Discord/etc.)
3. **Automation runtime** (cron, heartbeats, hooks, wakeups)
4. **Agent orchestration layer** (sessions, subagents, ACP runtime dispatch)
5. **Web host** (Control UI, WebChat surfaces, canvas/A2UI hosting)

Most components connect to this Gateway over a typed protocol; the Gateway owns stateful channel sessions and routes all events/messages/tool invocations.

---

## 1) High-level architecture

### Core topology

- **Gateway (daemon)** runs on one host (recommended one per host for normal use).
- **Clients** connect via WebSocket:
  - CLI
  - Web Control UI
  - WebChat
  - Automations and operators
- **Nodes** (macOS/iOS/Android/headless) also connect via WebSocket as `role: node`.
- **Providers/channels** are maintained by Gateway adapters (WhatsApp, Telegram, Discord, Slack, etc.).
- **Agent runtime** executes model turns and tool calls.
- **Workspace + memory** on disk provide durable continuity.

### Architectural invariants

- First WS frame must be `connect` (handshake required).
- Side-effecting methods use idempotency semantics to support safe retry.
- Events are streaming/push-based and not guaranteed replayed after missed gaps.
- Gateway auth (token/password and optional Tailscale identity mode) guards remote access.

---

## 2) Gateway: responsibilities and internal role

The Gateway is OpenClaw’s central operating system.

### Functional responsibilities

- Maintains live channel connections and account/session state.
- Hosts typed WebSocket RPC + server-push event stream.
- Validates protocol payloads against schemas.
- Emits operational and domain events (`agent`, `chat`, `presence`, `health`, `heartbeat`, `cron`, `shutdown`, etc.).
- Hosts HTTP surfaces on the same port as WS (default 18789):
  - Control UI
  - WebChat-facing endpoints
  - Canvas host routes (`/__openclaw__/canvas/`, `/__openclaw__/a2ui/`)
  - Optional webhooks and compatible APIs (when enabled)

### Operational behavior

- Default bind is loopback; non-loopback binds require auth.
- Supports service supervision (systemd/launchd) and in-process restart paths.
- Supports config hot-reload/restart policies (`off`, `hot`, `restart`, `hybrid`).

---

## 3) Protocol and connection model

### Transport

- **WebSocket JSON frames**
- Request/response + event streaming model:
  - Request: `{type:"req", id, method, params}`
  - Response: `{type:"res", id, ok, payload|error}`
  - Event: `{type:"event", event, payload, seq?, stateVersion?}`

### Lifecycle

1. Client sends `connect` (must be first frame).
2. Gateway authenticates + pairs/trust-validates device identity.
3. Gateway responds with startup snapshot (`hello-ok` style health/presence/context).
4. Runtime proceeds with command requests and async streamed events.

### Device trust/pairing

- Device identity is presented on connect.
- New/non-trusted devices can require approval.
- Local connect paths can be auto-trusted by policy for same-host UX.
- Non-local connects still require explicit trust + auth policy compliance.

---

## 4) Messaging channel subsystem

OpenClaw supports multi-channel communication through adapters, all anchored to Gateway.

### Examples of channels

- WhatsApp (Baileys)
- Telegram (grammY/Bot API)
- Discord
- Slack
- Signal
- iMessage/BlueBubbles
- IRC, Matrix, Google Chat, Teams, etc. (including plugin-based channels)

### Channel subsystem functions

- Account onboarding and status/probe operations
- Transport-specific send/receive normalization
- Capabilities and permissions probing
- Channel routing and multi-account dispatch
- Channel-level logs and troubleshooting surfaces

### Important design note

Gateway is the single owner of stateful channel sessions (notably WhatsApp session ownership), preventing split-brain behavior.

---

## 5) Agent runtime and orchestration

OpenClaw’s conversational intelligence runs as **sessions** managed by Gateway.

### Session model

- Main/direct sessions
- Thread-bound sessions (e.g., Discord thread workflows)
- Spawned sub-agent sessions
- ACP runtime sessions (external coding harness workflows)

### Orchestration capabilities

- Session listing/history/targeted messaging
- Spawn modes:
  - one-shot (`run`)
  - persistent thread/session (`session`)
- Completion announcements and best-effort delivery
- Timeout and run-control options

### Result

OpenClaw supports both interactive chat and delegated async work without leaving the same control plane.

---

## 6) Tooling layer (agent capability plane)

OpenClaw exposes first-class typed tools to the agent runtime.

### Core tool domains

- **FS/editing**: `read`, `write`, `edit`, `apply_patch`
- **Runtime/process**: `exec`, `process`
- **Web**: `web_search`, `web_fetch`
- **UI automation**: `browser`, `canvas`
- **Device integration**: `nodes`
- **Messaging actions**: `message`
- **Automation ops**: `cron`, `gateway`
- **Session orchestration**: session tools (`sessions_*`, `session_status`)
- **Memory retrieval**: `memory_search`, `memory_get`

### Policy controls

- Global tool allow/deny
- Tool profiles (`minimal`, `coding`, `messaging`, `full`)
- Provider/model-specific restrictions
- Group shortcuts (`group:fs`, `group:runtime`, etc.)
- Loop-detection protections for repetitive no-progress tool patterns

---

## 7) Automation subsystem (heartbeat, cron, hooks)

### Heartbeats

- Periodic system prompts/checks for proactive tasks.
- Can process queued system events in main context.

### Cron scheduler

- Runs inside Gateway and persists jobs in state storage.
- Schedule types:
  - one-shot timestamp (`at`)
  - interval (`every`)
  - cron expression (`cron`, optional timezone)
- Execution modes:
  - **main session** system event path
  - **isolated** dedicated run path (`cron:<jobId>`)
- Delivery modes:
  - `announce`
  - `webhook`
  - `none`

### Hooks/webhooks

- Event-driven integration points for external automations and inbound triggers.

---

## 8) Memory and persistence architecture

OpenClaw memory is file-backed and retrieval-augmented.

### Storage model

- Workspace markdown as source of truth
- Typical tiers:
  - daily logs (`memory/YYYY-MM-DD.md`)
  - curated long-term memory (`MEMORY.md`)

### Retrieval model

- `memory_search`: semantic lookup of indexed snippets
- `memory_get`: targeted file/line reads
- Backend options include built-in indexing and optional QMD sidecar
- Vector and hybrid search options (provider-based or local embeddings)

### Session continuity

- Session transcripts and durable files are persisted under state/workspace paths.
- Compaction workflows can trigger memory-flush behavior before context compression.

---

## 9) Nodes and device-extension architecture

Nodes extend OpenClaw beyond the gateway host.

### Node model

- Connect as `role: node` over same WS control plane.
- Advertise capabilities and command permissions.
- Support device operations (depending on node type and granted permissions):
  - notifications
  - command execution
  - camera snapshots/clips
  - screen recording
  - location retrieval
  - canvas rendering and A2UI

### Security posture

- Pairing/approval gate for new node identities
- Capability-bound invocation through typed commands

---

## 10) Web surfaces and remote access

### Web surfaces

- Control UI served by Gateway HTTP server
- WebChat as user-facing conversational surface
- Optional base-path support for reverse-proxy deployments

### Remote patterns

- Preferred: Tailscale/VPN
- Common fallback: SSH local tunnel to loopback gateway
- Non-loopback web access should enforce strict auth + origin controls

---

## 11) Model/provider layer

### Functions

- Default model resolution and aliasing
- Fallback chain configuration
- Provider auth profile management
- Capability/status probing

### Architectural role

The model layer is pluggable and externalized; Gateway/runtime orchestrates requests while providers supply generation/embedding capability.

---

## 12) Security model (practical view)

Key controls across architecture:

- Gateway auth required for remote/non-loopback usage
- Device pairing and trust tokens
- Origin restrictions for web surfaces
- Tool policy gating and sandbox/elevated controls
- Session visibility boundaries and scoped orchestration
- No implicit direct-channel fallback when Gateway is unavailable

---

## 13) Reliability and operations

### Observability surfaces

- `openclaw status` / `openclaw gateway status`
- Gateway logs (`openclaw logs`)
- Channel logs (`openclaw channels logs`)
- Cron run history (`openclaw cron runs` and run logs)

### Lifecycle controls

- install/start/stop/restart for supervised service modes
- deep probe commands and doctor workflows
- multi-gateway support for isolation (with separate config/state/ports)

---

## 14) End-to-end request flow (reference)

1. User message arrives on a channel (or WebChat).
2. Gateway adapter normalizes inbound event and routes to session.
3. Agent runtime invokes model and tools as needed.
4. Tool actions execute (local host, node, browser/canvas, web, memory, etc.).
5. Agent response is streamed back through Gateway.
6. Channel adapter formats/sends outbound message.
7. Session transcript and relevant state are persisted.
8. Optional automation follow-ups (cron/heartbeat/hooks) continue asynchronously.

---

## 15) Component inventory (concise)

- **Gateway daemon**: central router, protocol endpoint, channel owner, automation host
- **Channel adapters**: provider integrations for chat platforms
- **Agent runtime**: session execution, model turns, tool calling
- **Tool layer**: typed capabilities across FS/runtime/web/UI/device/messaging
- **Memory layer**: markdown memory + semantic retrieval/indexing
- **Automation layer**: heartbeat scheduler, cron jobs, hooks/webhooks
- **Node framework**: paired remote/local device capability extension
- **Web surfaces**: Control UI, WebChat, canvas host
- **Model/provider layer**: LLM + embedding provider auth/selection/fallback
- **State/workspace storage**: durable logs, sessions, cron data, memory files

---

## 16) Practical architecture takeaways

- Treat Gateway as the single source of runtime truth.
- Keep one gateway per host unless you intentionally isolate.
- Debug by layer: gateway health → channel status → session/tool execution.
- Protect remote exposure with auth, origin constraints, and controlled bind modes.
- Use isolated cron/subagent sessions for noisy background tasks.
- Persist critical context to memory files; do not rely on transient context windows.

---

## Source basis

This report is synthesized from OpenClaw local documentation, primarily:

- `docs/concepts/architecture.md`
- `docs/gateway/index.md`
- `docs/gateway/network-model.md`
- `docs/channels/index.md`
- `docs/tools/index.md`
- `docs/concepts/memory.md`
- `docs/automation/cron-jobs.md`
- `docs/cli/models.md`
- `docs/web/index.md`
