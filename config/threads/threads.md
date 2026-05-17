# Threads: open loops

The personal operating brain. Mirror anything team-facing into your PM tool (Monday / Linear) with audience-appropriate framing.

## How this works

- `/task` → show the list (P0/P1/P2/P3 only; do NOT include Recently Closed)
- `/task <free text>` → agent updates based on what you said (open, close, bump, log time, status)
- **Format:** every thread has **business prefix + priority + description + time estimate**. No other lanes.
- **Time estimates in parentheses** next to every task: `(15m)`, `(45m)`, `(2h)`, `(4h)`, `(half-day)`, `(full-day)`. Round sensibly. If genuinely unknown, mark `(?)`.

## Priority rules

- **P0 SLA is weekdays only.** 48-hour personal SLA counts business days (Mon-Fri). Weekends don't burn the clock unless the principal signals heads-down weekend grind mode.
- **P0** 🔥: On the principal's plate right now. 48-hour weekday SLA from add date. Could be 30 min or 4 hours of work. If a P0 hits 48h of business time without closing, auto-demotes to P1 unless re-committed with a hard date. No cap on count; the 48h SLA is the discipline.
- **P1** 🎯: This week's primary work. Actively progressing, not on the 48h clock.
- **P2** 📅: Should land this month.
- **P3** 💭: Future thought; promote when it becomes "this week."

Closing is the win. Most threads die at P1 or P2.

### P0 hygiene

- A weekday (typically Tuesday) = backlog day with no client meetings: use them to clear P0/P1 chores.
- Morning brief surfaces P0s and asks the principal to name 1-3 they'll close today.
- Day 2 of any P0 (T+24h): agent nudges with status check.
- Day 3 (T+48h): auto-demote to P1 unless re-committed.
- Projects (>4hr work, multi-session) are NOT P0: they live in P1 with the next concrete task extracted to P0.

## Shorthand

### Business prefixes

Each operator picks their own. Examples below; replace with yours.

- **MS** = main agency / services arm
- **DA** = personal brand
- **JB** = ecom side project
- **HM** = portfolio company / SaaS
- **LTM** = personal creative project (book, music, etc.)
- **TECH** = cross-cutting infra / tooling
- **RV** = investment / VC activity
- **PERSONAL** = home, health, family logistics
- **OC** = OpenClaw / agent infrastructure itself

### Client prefixes (under MS)

- **<CLIENT_A>** ($XK). <one-line context>
- **<CLIENT_B>** ($XK). <one-line context>

---

## P0: MINE (drop everything)

> Live items here. Real format:

- **MS:** Renewal deck for <client> (4h) (added 2026-01-12)
- **TECH:** Wire credentials health-check cron (2h) (added 2026-01-13)
- **PERSONAL:** RSVP to <event> by Friday (15m) (added 2026-01-15)

## P0: DELEGATED (team)

- **MS:** <team member>: onboarding doc for <new client> (delegated 2026-01-12, tracked on Monday)

## P1: this week's primary work

- **MS:** Onboarding playbook v1: pre-kickoff email + form, kickoff agenda, week-1 sprint, day-30 milestone
- **MS:** <Client> retention review: pull GA4, identify top 3 expansion angles
- **TECH:** Build credentials health-check cron: weekly test of all wired API tokens, alert before expiry
- **OC:** Marketing skills library: CRO.md, SEO.md, GEO.md, PaidAds.md, Email.md, Reddit.md
- **PERSONAL:** Taxes + QuickBooks: late filing reconciliation
- **<BRAND>:** Newsletter cadence: lock to weekly Tuesday 10am ET send

## P2: this month

- **TECH:** Mac Studio for self-hosted LLM/agent infra (research + buy)
- **MS:** Productize the audit deliverable: standard report template + Looker / GA4 dashboard
- **OC:** Per-channel agents: spawn a Slack-only specialist for ops triage
- **DA:** Newsletter relaunch: paid tier ($X/mo or $Y/yr), founding-member rate for first 500

## P3: future thought

- **LTM:** Book outline draft (long horizon)
- **MS:** White-label of the audit tool for partner agencies
- **TECH:** Multi-region deploy of the OpenClaw API

---

## How the agent uses this

- On `/task`, show the list above. Do not include closed items.
- On `/task <message>`, infer the change: add, close, bump priority, change time estimate, mark delegated.
- On a heartbeat: scan P0 for any that hit 24h or 48h. Nudge or auto-demote per the rules.
- On session start in a main context: surface P0 count and the top 1-2 P1s.

## Recently Closed (rolling 7 days, archived weekly to `memory/closed-threads.md`)

- 2026-01-10: **MS:** sent renewal deck to <client>
- 2026-01-11: **TECH:** re-authed `<account>` for gog CLI
