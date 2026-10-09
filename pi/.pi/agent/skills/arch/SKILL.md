---
name: arch
description: Arch Linux system maintenance, package management, Btrfs health, and AUR security. Use when working on system updates, package audits, filesystem checks, or troubleshooting Arch Linux.
---

# Arch Linux

Always load the `obsidian` skill alongside this one.

## Setup

Read the full maintenance guide from the Obsidian vault:

```
20_Areas/My Setup/Software/OS/Arch Linux Maintenance.md
```

This note contains:
- Boot diagnostics and expected benign errors
- System upgrade procedure (with AUR)
- Package & cache hygiene (orphans, paccache)
- Btrfs filesystem health checks (stats, scrub)
- Log and service auditing (systemctl, journalctl)
- SSD TRIM and mirrorlist optimization
- AUR supply-chain security scanning
- Package audit and cleanup workflow
- CVE scanning with arch-audit

## Safety Rules

- **Never run `yay -Syu` or `sudo pacman -Syu`** without first checking Arch Linux news for manual interventions.
- **Always present the full plan** before running destructive commands (orphan removal, cache cleanup, package removal).
- Run diagnostics first (`journalctl -b0 -p3`, `systemctl --failed`, `btrfs device stats /`) before proposing changes.