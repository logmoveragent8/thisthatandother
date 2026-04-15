# OpenClaw Architecture — Visual Diagram

## System context (high-level)

```mermaid
flowchart TB
  U[User / Operator] --> C[Chat Surfaces\nWebChat / Telegram / WhatsApp / Discord / Slack / etc.]
  C --> G[OpenClaw Gateway\nControl Plane + Messaging Hub + Automation Host]

  A[CLI / Control UI / Automations] --> G
  N[Paired Nodes\nmacOS / iOS / Android / headless] <-->|WS role=node| G

  G --> R[Agent Runtime\nSessions + Subagents + ACP Dispatch]
  R --> M[Model Providers\nOpenAI / Gemini / others]
  R --> T[Tooling Layer\nfs/runtime/web/ui/messaging/nodes]

  T --> H[Host OS\nFiles + Processes + Browser + Network]
  T --> N

  R --> MEM[Memory Layer\nMEMORY.md + memory/*.md\nsemantic index/search]
  G --> S[(State Store\n~/.openclaw\nsessions, cron, logs, channel state)]

  G --> W[Web Surfaces\nControl UI + Canvas/A2UI host]
```

## Component architecture (detailed)

```mermaid
flowchart LR
  subgraph Clients[Clients & Entry Points]
    CLI[OpenClaw CLI]
    UI[Control UI]
    WC[WebChat]
    CH[Channel Adapters\nWhatsApp/Telegram/Discord/etc.]
    HO[Hooks/Webhooks]
  end

  subgraph Gateway[Gateway (single long-running daemon)]
    WS[WebSocket Protocol\nconnect/req/res/event]
    AUTH[Auth + Pairing + Device Trust]
    ROUTE[Session Routing + Idempotency]
    EVT[Event Bus\nchat/agent/health/presence/cron]
    HTTP[HTTP Server\nUI + APIs + Canvas routes]
    AUTO[Automation Engine\nHeartbeat + Cron + Wakeups]
    CHM[Channel Manager\naccount/session ownership]
  end

  subgraph Runtime[Agent Runtime]
    SES[Session Manager\nmain/thread/isolated]
    ORCH[Orchestration\nsubagents + ACP runtime]
    TOOLSEL[Tool Policy\nallow/deny/profile/by-provider]
    EXEC[Turn Executor\nmodel loop + tool calling]
  end

  subgraph Tools[Tool Capability Plane]
    FS[FS Tools\nread/write/edit/apply_patch]
    RT[Runtime Tools\nexec/process]
    WEB[Web Tools\nweb_search/web_fetch]
    BRS[Browser/Canvas Tools]
    MSG[Message Tool]
    NOD[Nodes Tool]
    CRN[Cron/Gateway Tools]
    MEMT[Memory Tools\nmemory_search/memory_get]
  end

  subgraph Data[Persistence & Knowledge]
    ST[(Gateway State\nlogs, sessions, cron runs, channel state)]
    WM[(Workspace Files\nMEMORY.md + memory/*.md)]
    IDX[(Memory Index\nbuiltin or QMD)]
  end

  subgraph External[External Systems]
    LLM[Model Providers]
    OS[Host OS + Browser + Network]
    DEV[Paired Nodes]
    CHAT[External Chat Platforms]
  end

  CLI --> WS
  UI --> HTTP
  WC --> WS
  CH <--> CHM
  HO --> HTTP

  WS --> AUTH --> ROUTE --> SES
  ROUTE --> EVT
  AUTO --> EVT
  CHM --> EVT

  SES --> ORCH --> EXEC
  EXEC --> LLM
  EXEC --> TOOLSEL --> FS
  TOOLSEL --> RT
  TOOLSEL --> WEB
  TOOLSEL --> BRS
  TOOLSEL --> MSG
  TOOLSEL --> NOD
  TOOLSEL --> CRN
  TOOLSEL --> MEMT

  FS --> OS
  RT --> OS
  WEB --> OS
  BRS --> OS
  NOD --> DEV
  MSG --> CHAT
  CRN --> AUTO

  MEMT --> WM
  MEMT --> IDX
  AUTO --> ST
  EVT --> ST
  CHM --> ST
  SES --> ST

  CHM <--> CHAT
```

## End-to-end message flow

```mermaid
sequenceDiagram
  participant User
  participant Channel as Channel Surface
  participant Gateway
  participant Runtime as Agent Runtime
  participant Model as Model Provider
  participant Tool as Tools/Host/Node

  User->>Channel: Send message
  Channel->>Gateway: Inbound event
  Gateway->>Runtime: Route to session
  Runtime->>Model: Generate + decide tools
  Model-->>Runtime: Tool call(s) / tokens
  Runtime->>Tool: Execute typed tool(s)
  Tool-->>Runtime: Results
  Runtime->>Model: Continue/finalize
  Model-->>Runtime: Final answer
  Runtime-->>Gateway: Outbound response payload
  Gateway-->>Channel: Send response
  Channel-->>User: Delivered message

  Gateway->>Gateway: Persist logs/session state
```

## Automation flow (cron + heartbeat)

```mermaid
flowchart TB
  CJ[Cron Job Trigger] --> MODE{Session Target?}
  MODE -->|main| SE[Enqueue system event]
  MODE -->|isolated| IR[Run isolated session cron:jobId]

  SE --> WAKE{wakeMode}
  WAKE -->|now| HB[Immediate heartbeat run]
  WAKE -->|next-heartbeat| Q[Wait for scheduled heartbeat]

  HB --> MAIN[Main session turn]
  Q --> MAIN

  IR --> DEL{delivery.mode}
  DEL -->|announce| ANN[Send summary to chat target]
  DEL -->|webhook| WH[POST finished payload to webhook URL]
  DEL -->|none| NOP[No outbound delivery]
```

## Security boundary map

```mermaid
flowchart LR
  subgraph TrustedHost[Gateway Host Boundary]
    G[Gateway]
    R[Runtime]
    D[(State + Workspace)]
  end

  subgraph SemiTrusted[Controlled Connections]
    C[Clients/UI]
    N[Paired Nodes]
  end

  subgraph External[External Providers]
    P[Chat Platforms]
    L[LLM Providers]
  end

  C -->|Auth + Pairing + Origin checks| G
  N -->|Role=node + Pair approval| G
  G -->|Provider auth creds| P
  R -->|Model auth creds| L
  G --> D
  R --> D
```
