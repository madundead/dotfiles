---
name: homeassist
description: Home Assistant deployment, integrations, storage, automations, and operational workflows on the homelab. Use when working on Home Assistant.
---

# Home Assistant

Always load the `obsidian` and `homelab` skills alongside this one.

## Setup

Read the full documentation from the Obsidian vault:

```
20_Areas/My Setup/Homelab/Home Assistant.md
```

This note contains the complete deployment config, host, storage layout, active integrations, dashboards, key entities, automations, configuration structure, access/security, and operational workflows (restart, config edits, `.storage/` edits).

## Critical Rules

- **Never read secret material** (env files, credential stores). Assume required secrets are already exported into the environment.
- **`.storage/` edits**: always use read-local-transform-upload pattern, never chain SSH pipes
- **Config edits on NAS**: go through the services host into the Home Assistant app directory on the NAS flash share (exact path in the vault note)
- **Restart required after**: `configuration.yaml`, `secrets.yaml`, `custom_components/`, `.storage/` changes
- **Compose changes**: go through CI/CD pipeline (push to gitea `master`)