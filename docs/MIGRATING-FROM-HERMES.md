# MIGRATING-FROM-HERMES.md

The actual migration story. From a single-agent assistant to a multi-agent operating system.

## What Hermes is

Hermes is Nous Research's open-source single-agent assistant. MIT license, install on a server, connects to Telegram. Tagline: "the agent that grows with you." Real product, real team, real users.

The pattern: one persistent agent with file-based memory, skill system, /rollback checkpoints, self-optimizing prompts. Everything you'd want for one person doing one job with one voice.

## Why I migrated off

Not because Hermes is bad. Because one agent isn't an operating system.

The specific friction points after running Hermes for ~6 weeks on a real multi-business workload:

1. **Voice leak.** The agent that drafted a B2B renewal email kept the same crisp-deck voice when drafting a personal newsletter. One persona stretched across two distinct audiences. Sub-optimal for both.

2. **Context bleed.** The agent referenced a confidential portfolio-company metric in a public-facing draft. One memory store, no firewall.

3. **Priority collapse.** Every Slack ping landed with the same urgency as a six-figure renewal. No P0/P1/P2/P3 lanes. No weekday-only SLAs. Either everything was urgent or nothing was.

4. **Channel monoculture.** Telegram-first was great for mobile, but the agent treated Slack the same way it treated Telegram, which is wrong. Slack needs team-facing direct posts. Telegram needs personal-bot draft-and-approve. The single agent couldn't hold two channel postures.

5. **No specialist sub-agents.** The agent was a generalist, full stop. No content sub-agent for newsletter drafts. No brand-ops sub-agent for ecom. No coding sub-agent for the codebase. The generalist did everything 70% as well as a specialist would have, and 100% of the work went through one head-state.

## The migration trigger

Specific date: May 6, 2026. I had been running Hermes plus parallel OpenClaw sessions for about two weeks, testing whether OpenClaw could carry the same load. On May 6, the answer was yes, and I literally typed: *"If everything openclaw-related is working, then kill hermes completely."*

That's the migration. Receipts.

## What I moved (and what I left)

### Moved 1:1

- Iron laws (verbatim, into `MEMORY.md` with `🚨 IRON LAW:` headings and date stamps)
- People dossiers (into `brain/people/<name>.md`)
- Company state (into `brain/companies/<name>.md`)
- Standing facts about businesses, family, health (into `MEMORY.md` sections 3-5)

### Moved with structural changes

- The todo list. Was a flat list in Hermes; became `threads/threads.md` with P0/P1/P2/P3 lanes, business prefixes, time estimates, weekday-only SLAs.
- Memory layout. Was one big file in Hermes; became `memory/YYYY-MM-DD.md` (daily logs) + `MEMORY.md` (curated) + `brain/` (per-entity dossiers).
- Heartbeats. Was "ping every N minutes" in Hermes; became a rotating-check protocol (inbox / calendar / threads / mentions / weather) with timestamps in `memory/heartbeat-state.json`.

### Left behind on purpose

- The single-agent assumption. The OpenClaw setup is multi-agent from day one. Main + content + brand-ops + coding harness, each with its own SOUL / AGENTS / IDENTITY / memory namespace.
- /rollback as a primary safety net. OpenClaw's safer-by-default defaults (read-only skill install, draft-and-approve for external sends) plus normal git on the workspace covered the same surface with less friction.
- Self-optimizing prompts as a feature. The iron-law format already gives you durable behavioral contract; the prompt below it can drift.

## What changed in voice / behavior after the migration

Quantitatively, hard to say; nobody publishes a Hermes-vs-OpenClaw benchmark and I'm not running one. Qualitatively, four shifts:

1. **No more voice leak between brand and EA.** The content agent writes in the brand's voice. The EA writes in the EA voice. They never collide, because they never share a session.

2. **Threads file became the morning anchor.** First thing every day, agent surfaces P0 count and asks me to name 1-3 I'll close today. By default the day starts with a closeable list, not an open inbox.

3. **Heartbeats stopped being noise.** Silent-by-default plus rotating checks means I hear from the agent when there's signal. The "all clear every 30 minutes" pattern is gone.

4. **Sub-agents started compounding.** The content agent now writes the newsletter in voice version 6, not version 1. Brand-ops agent reads the ecom dashboard in 20 seconds because the SKILL.md got tightened over 3 iterations.

## What I'd do differently

Two things.

**Migrate iron laws first, everything else second.** I tried to move the whole workspace state in parallel and ended up double-keeping for two weeks longer than I needed to. Iron laws are 80% of the operator-feel of the agent. Move those, get the new agent's voice right, then move the rest at leisure.

**Spawn sub-agents earlier.** I ran main-only for ~10 days before standing up the content sub-agent. The content sub-agent should have been there day 1 because the voice difference between EA and brand is the most expensive context-bleed pattern. Don't wait to feel the pain; spawn the specialist preemptively.

## Should you migrate?

You probably shouldn't migrate off Hermes if:

- You're running one business with one voice
- You're happy with single-agent context
- You don't want to maintain a multi-agent registry

You probably should migrate if:

- Two or more businesses with distinct voices
- Three or more channels with distinct postures
- You want priority lanes with weekday-only SLAs
- You want the threads file as the operating brain
- You want specialist sub-agents that compound

If the second list describes you, install this kit and start there. The migration story is in the file structure; you don't have to invent it from scratch.

## License of the lesson

Free. The migration receipts are public. The kit is MIT. Fork, modify, redistribute.
