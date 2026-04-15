# OpenClaw Gateway

- Status: Running on Geekom XT13 Pro
- Paired with Telegram (user 7433176972)
- Platform: Ubuntu 24.04

## Issues to Track
- Install hangs at end but works after reboot
- Gateway can go down completely; requires reboot to recover
- Memory search database is disabled
- Scheduled heartbeat runs repeatedly terminated `openclaw update` with SIGTERM

## Current Mitigation
- Heartbeat now uses a safe check: `openclaw update status` (no service restart)

## Recent Updates (Mar 2026)
- Built a practical troubleshooting workflow for OpenClaw incidents (triage → isolate layers → reproduce → logs-first diagnosis).
- Confirmed system lag/root cause was USB receiver path interference (resolved by moving Logitech dongle to a different port).
- Added local docs in workspace:
  - `openclaw-architecture-report.md`
  - `openclaw-architecture-diagram.md`
  - `openclaw-filesystem-map.md`
- Update check currently reports **2026.3.2 available** (`openclaw update status`).
- Config doctor warning: Telegram and WhatsApp group policies are `allowlist` with empty allowlists, so group messages are currently dropped.
- Mar 4 recheck: status unchanged — latest stable remains **2026.3.2 available** and group allowlist warnings are still active.
- Mar 5 recheck: status unchanged — latest stable remains **2026.3.2 available** and group allowlist warnings are still active.
- Mar 6 recheck: status unchanged — latest stable remains **2026.3.2 available** and group allowlist warnings are still active.
- Mar 7 recheck: status unchanged — latest stable remains **2026.3.2 available** and group allowlist warnings are still active.
- Mar 8 recheck: status unchanged — latest stable remains **2026.3.2 available** and group allowlist warnings are still active.

## Commands
- `openclaw gateway status`
- `openclaw gateway restart`
- `openclaw update status`
