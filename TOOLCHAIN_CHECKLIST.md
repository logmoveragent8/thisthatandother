# Codex + Obsidian Vault Toolchain Checklist

## Required

- [ ] OpenClaw session access (Codex runtime)
- [ ] Filesystem access to vault roots
- [ ] `git` installed and configured (`user.name`, `user.email`)
- [ ] `ripgrep` (`rg`) installed for precision search
- [ ] Bash available for automation scripts

## Recommended

- [ ] Python 3 (for richer index generation if needed)
- [ ] Optional embedding/vector search backend for discovery
- [ ] Cron/systemd timer for scheduled index refresh and inbox triage

## Vault Layout (per vault)

```text
<vault>/
├── 00_inbox/
├── 01_thinking/ or 01_work/
├── 02_reference/
├── 03_creating/
├── 04_published/
├── 05_archive/
└── 06_system/
    ├── AGENT.md
    ├── INDEX.md
    ├── MOCs/
    └── templates/
```

## Operating Policy

- Precision-first linking (conservative)
- Auto-write enabled
- Auto-synthesis enabled
- Always orient first: `INDEX.md` -> MOCs -> target notes
- Commit each task batch with clear messages

## Command Checklist

```bash
# Verify tools
command -v git
command -v rg
command -v bash

# Bootstrap a vault
bash scripts/bootstrap_codex_vault.sh /path/to/vault thinking
bash scripts/bootstrap_codex_vault.sh /path/to/vault work

# Rebuild index (inside vault root)
bash 06_system/rebuild_index.sh

# Typical git flow
git add -A
git commit -m "vault(index): rebuild index and update links"
```
