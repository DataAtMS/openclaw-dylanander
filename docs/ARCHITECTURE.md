# ARCHITECTURE.md: Dylan Ander's OpenClaw

The full architecture. Read this first.

## The one-sentence thesis

A single-agent assistant is great for one person doing one job. To run multiple businesses across multiple channels with multiple specialists, you need an operating system, not an assistant. This kit is that operating system, scaffolded.

## The three layers

1. **OpenClaw runtime:** the agent host. Models, tools, channels, memory.
2. **Discipline layer:** what makes one agent reliable. Iron-law memory format, ship-don't-plan discipline, QA-before-done. ([Nik Sharma's Operator Kit](https://openclaw.nik.co) is the canonical reference for this layer.)
3. **Operating system layer:** what makes a multi-agent setup an actual ops backbone. Multi-agent registry, multi-business memory firewall, multi-channel rules, threads protocol. **This kit is that layer.**

The three layers stack. You can run OpenClaw without Nik's kit and without this one. You can run OpenClaw plus Nik's kit. Or all three. The right answer depends on how many businesses you're running and how many channels you're answering.

## The architecture diff

### Single agent (e.g. Hermes)

- One agent
- One memory store
- One Telegram bot
- One persona
- One human

Works great until you have two businesses with two different voices. Then the voice leaks, the context bleeds, and you're patching prompts forever.

### Single agent with discipline layer (OpenClaw + Nik's kit)

- One agent, sharpened
- Iron-law-formatted memory that survives compaction
- Daily logs → curated long-term memory
- Per-person dossiers
- Ship-don't-plan discipline
- QA-before-done

Works great for one operator doing serious work in one or two domains. Where it starts to fray: the moment you want one persona for client work and a different persona for the brand, the single SOUL file can't carry both without compromise.

### Operating system layer (this kit, on top of the above)

- Multi-agent registry: `main` + specialists, each with their own SOUL / AGENTS / MEMORY / channels
- Per-business memory firewall: every memory and thread tagged with a business prefix
- Per-channel rules: email is draft-and-approve from the EA, Slack is team-facing direct posting, Telegram is mobile-direct, etc.
- Threads protocol: P0/P1/P2/P3 with weekday-only SLAs and auto-demote rules
- Wired-tools catalog: TOOLS.md with one section per service, credentials path, common ops
- Heartbeats with rotating checks instead of "all clear" spam
- Business-prefix shorthand baked into the agent's vocabulary

## The core files

### Root files (inherit to every sub-agent)

- `AGENTS.md`: session startup, memory discipline, red lines, threads protocol overview, channel rules
- `SOUL.md`: the primary EA's voice
- `IDENTITY.md`: name, vibe, emoji
- `USER.md`: who the human is
- `MEMORY.md`: long-term curated memory with iron-law format
- `TOOLS.md`: wired-tools catalog
- `HEARTBEAT.md`: proactivity rules

### Workspace directories

- `threads/`: open loops with priority lanes
- `memory/`: daily logs + archive rotation
- `journal/`: bed/wake/feel/day schema
- `brain/people/`: per-person dossiers
- `brain/companies/`: per-company dossiers
- `agents/`: multi-agent registry (main + specialists)
- `skills/`: custom skills
- `docs/`: this folder

## Multi-agent registry

The `agents/` directory holds one folder per sub-agent. Each sub-agent inherits the root files and overlays its own. Closer wins.

Default registry:

| Agent     | Role                            | Channel                  |
| --------- | ------------------------------- | ------------------------ |
| `main`    | Primary EA                      | Telegram DM, Slack DM    |
| `content` | Newsletter + long-form writing  | Content Telegram bot     |

You add sub-agents as needs grow. A brand might warrant a `<brand>-ops` agent for ecom. A codebase might warrant a coding agent bound to your editor.

The main agent owns the user-facing relationship. Sub-agents are tools that the main agent invokes. Sub-agents return results; the main agent surfaces them.

## Multi-business memory firewall

Every memory entry, thread, and brain page is tagged with a business prefix (MS, JB, HM, DA, LTM, TECH, PERSONAL, OC).

When the agent reasons inside one business context, it pulls only the entries tagged with that prefix plus the workspace-wide iron laws. Cross-business contamination becomes structurally hard, not just behaviorally discouraged.

The prefix lives:

- In thread descriptions: `**MS:** renewal deck for <client>`
- In daily log headers: `## <business> · <topic>`
- In brain page paths: `brain/companies/<business>.md`
- In sub-agent registry rows

## Multi-channel rules

Channels are not interchangeable. The agent treats each one with explicit defaults.

| Channel    | Default stance                                     |
| ---------- | -------------------------------------------------- |
| Email      | Draft-and-approve. Sent from EA, never principal. |
| Slack      | Team-facing. Direct posts OK; DMs need approval.  |
| Telegram   | Mobile-direct. Bot routes to sub-agent.           |
| iMessage   | Personal. Approval for outbound.                  |
| Discord    | Group context. React more than reply.             |
| Webchat    | Main agent home. Most expansive context.          |

## Threads as protocol

`threads/threads.md` is not a todo list. It's a protocol.

- Every open loop has a business prefix, priority, description, time estimate.
- P0 has a 48-hour weekday SLA.
- P0 nudges at 24h, auto-demotes at 48h.
- Projects (>4h, multi-session) are P1; the next concrete step is P0.
- `/task <message>` is the natural-language API for updating the file.
- Closing is the win. Most threads die at P1 or P2.

## Iron-law memory format

The format is the product.

```
### 🚨 IRON LAW: <rule statement> (set YYYY-MM-DD)
<rule body>
DO NOT: <bad example>
DO: <good example>
<why it matters>
```

The 🚨 prefix is a visual tripwire. Iron laws survive compaction, survive prompt-engineering changes, and survive model upgrades. They are the durable behavioral contract between the principal and every agent in the workspace.

## Heartbeats with signal, not spam

Heartbeats poll the agent periodically. The agent either has signal to share or stays silent (`HEARTBEAT_OK`).

Rotating checks (inbox / calendar / threads / mentions / weather) are timestamped in `memory/heartbeat-state.json` so the agent doesn't double-check the same surface twice in a row.

A heartbeat that fires "all clear" trains the human to mute the bot. Silence is the default; signal is the exception.

## Skills as compound assets

Skills live in `skills/`. Each is a folder with a `SKILL.md`. The agent selects at most one skill per reply based on the description block.

Skills compound. Version 1 is a sketch. Version 5 is why the agent ships in 10 minutes what used to take 2 hours.

## What this kit is not

- **Not a model.** It's templates and conventions on top of whatever runtime you're using.
- **Not skills.** It's the scaffold; you bring or write the skills that extend the agent's capabilities.
- **Not a SaaS.** Free, MIT, runs entirely in your workspace.
- **Not competing with Nik's kit.** They stack. Read Nik's first for the discipline layer; this one extends it.

## What this kit is

A working snapshot of the patterns that survived contact with running multiple businesses through agents on a phone. Sanitized. Free. Yours to modify.
