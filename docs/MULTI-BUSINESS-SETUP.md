# MULTI-BUSINESS-SETUP.md

How to partition multiple businesses inside one workspace without context bleed.

## The core problem

You run more than one business. They share you. They do not share each other. The agent that sees your inbox sees all four inboxes; the agent that drafts your newsletter has access to your portfolio company's confidential metrics. Without explicit partitioning, the agent will eventually:

- Reference one business in another's surface
- Apply one voice to another's audience
- Treat one priority as another's
- Surface confidential data in a public draft

The partition has to be structural, not just a prompt instruction. This doc is the structural pattern.

## The four-layer partition

### Layer 1: Business prefix as protocol

Every workspace artifact gets a business prefix. The prefix lives in the filename, the heading, the thread description, or the brain page path.

Example prefixes:

- **MS** = main agency
- **DA** = personal brand
- **JB** = ecom side
- **HM** = portfolio company / SaaS
- **LTM** = personal creative
- **TECH** = cross-cutting infra
- **PERSONAL** = home / family / health logistics
- **OC** = OpenClaw / agent infra

You pick yours. Keep them under 5 characters. Use them religiously.

### Layer 2: Per-business brain pages

```
brain/companies/<business>.md
```

One file per business. Contains:

- One-paragraph identity (what the business is)
- Revenue / stage / size
- Key people (with `brain/people/<name>.md` links)
- Tools wired specifically for this business (Klaviyo account, Shopify store, GA4 property)
- Iron laws specific to this business (e.g. "Never cross-pollinate with brand X")
- Current state / open loops
- Confidentiality posture (public, semi-public, NDA-bound)

When the agent reasons inside business X, it loads `brain/companies/<X>.md` plus workspace-wide memory. It does not load other companies' brain pages.

### Layer 3: Per-business sub-agents (when warranted)

Most operators don't need a separate sub-agent per business. They need:

- One main EA covering everything
- One content sub-agent covering brand voice (which is its own business in a partitioning sense)
- Optionally one ops sub-agent per business that has its own ops surface (e.g. an ecom brand with daily ad-spend / Klaviyo / inventory work)

Spawn a per-business ops sub-agent when:

- That business has a distinct daily ops cadence (not just occasional touch)
- That business has confidential data you want firewalled from the main agent
- That business has a distinct external-facing voice (e.g. a customer-facing bot)

### Layer 4: Per-business channel routing

Channels go business-specific where it makes sense:

- Slack workspace per business (or per agency-vs-portfolio split)
- Telegram bot per voice (main EA bot, content bot, customer-facing brand bot)
- Email account per business (EA address per legal entity)
- Webhook destinations per business

The runtime config maps each channel to the right sub-agent. The agent never has to guess which business context to load.

## Memory hygiene in a multi-business workspace

### What goes in workspace-root MEMORY.md

- Iron laws that apply across all businesses (no em dashes, draft-and-approve, etc.)
- People who span multiple businesses (the principal's partner, the EA, accountants, lawyers)
- Cross-business workflow rules (how the threads file works, how heartbeats work)

### What goes in `brain/companies/<business>.md`

- Business-specific state (revenue, clients, team, tools)
- Business-specific iron laws ("never reply to <competitor> employees without legal review")
- Business-specific people (clients, contractors, vendors)
- Business-specific channels (Slack workspace ID, Telegram bot handle, Klaviyo account)

### What goes in `memory/YYYY-MM-DD.md`

- Raw daily log, organized by business with H2 headings using the prefix:
  ```
  ## MS · renewal call with <client>
  ...
  ## JB · ad spend rebalance
  ...
  ## PERSONAL · doctor appt scheduled
  ```

### What never lives in a shared file

- Confidential portfolio-company data (lives in `brain/companies/<HM>.md` and is firewalled from cross-business sub-agents)
- Client NDA material (lives in `brain/companies/<MS>/clients/<client>.md` with explicit access notes)
- Personal medical / financial detail (lives in `brain/personal/` with `_private` suffix on files that shouldn't load by default)

## Priority lanes across businesses

The threads file is workspace-wide. Every P0 across every business lives in the same P0 section. Why: priority is a function of the operator's time, not the business. A $24K renewal P0 outranks an ecom shipping P0 regardless of business, because the operator only has one calendar.

The format makes the business visible at a glance:

```
## P0: MINE (drop everything)

- **<CO1>:** Renewal deck for <client> (4h) (added 2026-01-12)
- **<CO2>:** Inventory PO needs sign-off by Friday (15m) (added 2026-01-14)
- **<CO3>:** Board prep doc for Tuesday (3h) (added 2026-01-14)
```

The principal scans by prefix; the agent reasons by priority.

## Cross-business "rolling-up" decisions

Some decisions span all businesses (weekly time-allocation, end-of-quarter capital allocation, annual goal-setting). For these the agent assembles cross-business context explicitly:

- Loads workspace-root MEMORY
- Loads each `brain/companies/<business>.md`
- Loads the relevant threads sections per business
- Loads the relevant calendar / inbox slices per business

This is the only context in which cross-business reasoning is allowed. Day-to-day work stays inside one business at a time.

## Sub-agent invocation pattern

When the main agent needs business-specific work done:

1. Identify the business prefix and the sub-agent that owns it (per `agents/README.md` registry)
2. Spawn / message the sub-agent with:
   - The task brief
   - The business prefix
   - Any relevant context (without confidential cross-business detail)
3. Receive the result and surface it back to the principal

The main agent owns user-facing relationship. Sub-agents are tools.

## What goes wrong if you skip this

Skip business prefixes: every grep returns mixed-business results.

Skip per-business brain pages: the agent re-derives business context every session.

Skip per-business sub-agents: voice leak between brand and EA.

Skip per-business channel routing: the agent has to guess which business context applies to every inbound message, gets it wrong 10% of the time, and 10% of the time over 30 messages a day is a leak per week.

## The minimum viable multi-business setup

If you're starting from a single-agent setup and want to partition without rewriting everything:

1. Add business prefixes to every thread in `threads/threads.md`. One afternoon's work.
2. Create one `brain/companies/<business>.md` per business with a single-paragraph identity and one-line iron law. One day's work.
3. Spawn ONE sub-agent (probably content) with its own SOUL.md. Half a day.
4. Add per-channel rules to AGENTS.md. One hour.

Total: about two days of structural work. Pays back in the first cross-business near-miss you avoid.
