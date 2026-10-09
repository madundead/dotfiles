---
name: power
description: Home solar/inverter/battery system management. Use when working on solar, inverter (Solis S6), batteries (Pylontech US5000), power setup, energy management, or Modbus diagnostics.
---

# Power (Solar / Inverter / Battery)

Always load the `obsidian` skill alongside this one.

## Setup

Read the full documentation from the Obsidian vault:

```
20_Areas/My Setup/Hardware/Power.md
```

This note contains:
- Hardware specs (inverter, batteries, panels)
- Register bit mappings (authoritative source inline)
- Load & grid architecture
- Home Assistant integration details
- Key entity references
- Safety rules for agent operations
- Datasheet links stored in `99_System/Assets/`
- Access & diagnostics information

## Safety Rules

- **Never write to Modbus registers** without explicit user confirmation after presenting the planned change and value.
- **Never connect directly to the inverter** -- only query through Home Assistant's stored state or through the user.
- Always start diagnostics with the read-only state query in the Access & Diagnostics section.

Full safety rules and access details are in the vault note.