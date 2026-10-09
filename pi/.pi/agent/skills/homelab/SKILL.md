---
name: homelab
description: Home network topology, server inventory, and Docker service management. Use when working on the homelab, server infrastructure, Docker services, Cloudflare, or networking.
---

# Homelab

Always load the `obsidian` skill alongside this one.

## Setup

Read the full documentation from the Obsidian vault:

```
99_System/Agent/Skills/Homelab.md
```

This note contains the complete topology, server inventory with IPs/roles, Docker Compose structure, CI/CD and deploy workflows, architecture standards, and operational workflows.

## Critical Rules

- **Never read `secrets.sh`** (Syncthing file). Assume necessary secrets are exported from it.