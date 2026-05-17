# Dylan Ander's OpenClaw 🦞

The operating system for running multiple companies from a phone.

```bash
curl -sSL https://openclaw.dylanander.com/install.sh | bash
```

Free. MIT licensed. Read-only default. Drops everything into a `dylan-ander-openclaw/` subfolder inside your existing OpenClaw workspace. Nothing of yours gets overwritten.

## What this is

A sanitized snapshot of the actual config running across four businesses from a single phone. Multi-agent, multi-business, multi-channel. Iron laws. Cache-boundary memory. Threads as protocol.

This is the operator-at-scale version of the pattern. If [Nik Sharma's Operator Kit](https://openclaw.nik.co) is the discipline layer for a single agent, this kit is the org chart and SLA system on top of it. The two stack.

## What you get

```
dylan-ander-openclaw/
├── AGENTS.md            workspace conventions
├── SOUL.md              operator persona
├── IDENTITY.md          who the agent is
├── USER.md              who the human is
├── MEMORY.md            long-term memory with iron-law format
├── TOOLS.md             wired-tools catalog
├── HEARTBEAT.md         proactivity rules
├── threads/threads.md   P0/P1/P2/P3 priority lanes
├── memory/              daily logs + archive rotation
├── journal/             bed/wake/feel/day schema
├── agents/              multi-agent registry (main + content sub-agent)
├── skills/              custom skill structure
└── docs/                architecture, migration, multi-business setup
```

## Install modes

```bash
# Default. Drops reference materials into dylan-ander-openclaw/. Touches nothing else.
curl -sSL https://openclaw.dylanander.com/install.sh | bash

# Adds optional scaffolding (memory/archive, journal, brain/ folders).
curl -sSL https://openclaw.dylanander.com/install.sh | bash -s -- --mode=additive

# Brand-new workspaces only. Writes full templates at workspace root.
curl -sSL https://openclaw.dylanander.com/install.sh | bash -s -- --mode=fresh
```

## Prerequisites

You need OpenClaw already installed at `~/.openclaw/workspace/`. If you don't have it, install OpenClaw first: https://github.com/openclaw/openclaw

## License

MIT. Fork, modify, redistribute. Credit appreciated but not required.

## Credits

Modeled on the install pattern Nik Sharma shipped at [openclaw.nik.co](https://openclaw.nik.co). Different content, same safety-first scaffolding philosophy.

## Links

- [openclaw.dylanander.com](https://openclaw.dylanander.com)
- [dylanander.com](https://dylanander.com)
- [heatmap.com](https://heatmap.com)
