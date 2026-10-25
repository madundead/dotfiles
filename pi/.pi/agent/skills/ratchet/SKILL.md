---
name: ratchet
description: Maintenance and security audit for the Ratchet Docker services host. Use for exposure and hardening review, CVE triage, Debian sid upgrades, Docker service management, NAS mount checks, and rollback planning.
---

# Ratchet

Always load the `obsidian` and `homelab` skills alongside this one.

## Setup

Read the full documentation from the Obsidian vault before acting:

```
20_Areas/My Setup/Homelab/Ratchet.md               # host identity, exposure findings, gates
20_Areas/My Setup/Homelab/Ratchet Maintenance.md   # the procedure library
```

> [!important] Public/private boundary
> This file lives in a **public** dotfiles repo. Keep it generic. Host addresses, exposure findings, service inventories, installed versions, baselines, and credentials belong **only** in the vault notes above.

## Safety Rules

Read-only commands are always allowed and come first. Explicit approval is required before:

- `apt upgrade`, `full-upgrade`, `dist-upgrade`, `autoremove`, installing packages, or adding apt repos
- any Docker prune (`system`, `image`, `volume`, `container`, `builder`)
- `docker compose down`, `--force-recreate`, or removing services, volumes, networks, or images
- restarting any service the user relies on daily (list in the vault note)
- rebooting the host
- changing firewall rules, port bindings, sshd config, or exposing new ports
- editing anything in the homelab config repo or its infrastructure definitions
- running `nmap`, or scanning anything other than the user's own gear

Never read secret material (secrets files, `.env`) — ever.

## Workflow

1. **Pre-flight (read-only).** Run section 1 of the guide and present the baseline.
2. **Present the menu.** List the guide's numbered sections **verbatim** and ask which to run. Never reorder or renumber.
3. **Findings before action.** Evidence and severity first, then a numbered plan where each item states what changes, blast radius, expected downtime, and rollback. Wait for approval — approval of one item is not approval of the next.
4. **Execute one approved item, verify, report the delta.**
5. **Log to the vault** (section 9 of the guide).
6. **Never escalate scope on your own** — no "while I'm here" changes.

## Output format

| Severity | Finding | Evidence | Proposed action | Approval |
|---|---|---|---|---|

Severity scale: `CRITICAL` / `HIGH` / `MEDIUM` / `LOW` / `INFO`. Do not inflate.

## CVE triage: headline vs live risk

A headline is not a finding. Check, in order:

1. **Installed version** of the actual software
2. **Affected range**, from the advisory rather than a news article
3. **Reachability** — internet, tunnel, LAN, or loopback only
4. **Only then** assign severity and propose action

Use the read-only feed watcher described in section 4 of the guide. It only fetches public feeds and never touches the servers.

## Stop conditions — halt and ask

- Available memory is below the threshold recorded in the vault note
- A proposed step would **remove** packages
- A NAS mount is missing, stale, or erroring
- CVE applicability is ambiguous
- The action would interrupt a daily-use service
- The action is not covered by an approved plan item

## Rollback

Verify what recovery actually exists before changing anything. If the root filesystem has no snapshots (see the vault note), record recoverable state first: package selections, config-repo status, rendered compose config, and the container/image inventory. Confirm whether the config repo is committed and pushed before relying on it as the rollback path, and say so explicitly if it is not.