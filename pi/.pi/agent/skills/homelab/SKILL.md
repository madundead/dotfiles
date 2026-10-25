---
name: homelab
description: Home network topology, server inventory, and Docker service management. Use when working on the homelab, server infrastructure, Docker services, Cloudflare, or networking.
---

# Homelab

Always load the `obsidian` skill alongside this one.

## Setup

Read the full documentation from the Obsidian vault:

```
20_Areas/My Setup/Homelab/Homelab Topology.md
```

This note contains the complete topology, server inventory with IPs/roles, Docker Compose structure, CI/CD and deploy workflows, architecture standards, and operational workflows.

## Critical Rules

- **Never read secret material** (env files, credential stores). Assume required secrets are already exported into the environment.
- **Keep the vault note current**: when making architectural or infrastructure changes, update `20_Areas/My Setup/Homelab/Homelab Topology.md` so the topology and inventory stay accurate.
