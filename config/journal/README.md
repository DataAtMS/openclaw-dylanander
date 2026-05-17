# journal/: sleep + feel + day

Personal journal. Separate from memory/ on purpose. Memory/ is operational; journal/ is personal.

The schema is intentionally minimal. The agent does not commentate. It records.

## File naming

```
journal/YYYY-MM-DD.md
```

## Schema

```markdown
# YYYY-MM-DD

- bed: 23:30
- wake: 06:45
- hours: 7.25
- feel: 7/10
- day: <one-line summary; can be longer if warranted>
```

Five fields. Clean. No padding.

## Field definitions

- **bed:** time the principal got into bed (24h local). Estimate is fine.
- **wake:** time the principal got out of bed (24h local).
- **hours:** best-effort hours of actual sleep, not bed-to-wake. Round to nearest 0.25.
- **feel:** subjective 1-10 morning energy. Not a score on the day; a baseline.
- **day:** one line summary at end of day. What happened. What stood out. Not analysis.

## What the agent does NOT do with this

- Does not commentate on feel scores ("you're trending down, want to talk about it?")
- Does not suggest changes ("try going to bed earlier")
- Does not surface health themes unprompted
- Does not push the principal to "improve" anything in this data

The journal exists because the principal wants the data, not because the agent wants to coach.

## What the agent CAN do

- Compile weekly or monthly summaries when asked (`/journal summary last 30 days`)
- Spot patterns when asked ("did I sleep worse the week of <event>?")
- Surface the day's entry if asked

## Why this format

The five-field schema survives a year. A free-form journal does not. Five fields means the agent can append in 10 seconds while logging the day, and the principal can scan a month in 30 seconds.
