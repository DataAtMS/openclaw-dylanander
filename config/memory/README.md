# memory/: daily logs

Raw notes of what happened. Append-only during the day. Promote distilled learnings to `MEMORY.md` weekly.

## File naming

```
memory/YYYY-MM-DD.md
```

One file per day. Created on first write of the day.

## Format

```markdown
# YYYY-MM-DD

## Morning brief
- P0s on the plate: ...
- Top P1 to close today: ...

## <Topic / time>: short headline
- What happened
- What got decided
- What to remember

## <Next topic>
- ...
```

Loose structure. Headlines are for grep. Bullets are for skim.

## What goes here vs MEMORY.md

| Goes in `memory/YYYY-MM-DD.md`                    | Goes in `MEMORY.md`                              |
| ------------------------------------------------- | ------------------------------------------------ |
| Raw log of conversations and decisions            | Iron laws (durable behavioral rules)             |
| One-off facts that may or may not matter later    | Durable facts about businesses, people, tools    |
| Notes from a single meeting                       | Patterns that recurred across multiple meetings  |
| Today's mood / context                            | Stable preferences / hard rules                  |
| "Reminded principal about <X>"                    | "Principal cares about <X> in general"           |

The daily file is the inbox. MEMORY.md is the curated long-term store.

## Archive rotation

When a daily file is older than ~30 days and nothing in it has been promoted:

```bash
mv memory/2025-12-XX.md memory/archive/
```

Archived files stay searchable via grep but don't load by default.

## Promotion workflow

During a heartbeat or weekly sweep:

1. Read the last 7 days of `memory/`
2. Look for: new iron laws, new durable facts, new people, new tools, recurring patterns
3. Update MEMORY.md, brain/people/, brain/companies/, or TOOLS.md as appropriate
4. Leave the daily file as-is (it's the raw source of truth)

## What never goes in here

- Secrets, credentials, API keys (those live in `~/.openclaw/credentials/`)
- Long verbatim email threads (link to the message ID instead)
- Third-party confidential information without explicit permission

## Why this matters

You wake up fresh every session. The daily file is the bridge between yesterday-you and today-you. Without it, the workspace forgets everything below the level of iron laws. Write things down.
