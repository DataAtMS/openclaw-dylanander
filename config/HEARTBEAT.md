# HEARTBEAT.md: Proactivity rules

When the agent receives a heartbeat poll (recurring "you alive?" prompt from the runtime), don't just reply `HEARTBEAT_OK`. Use the heartbeat productively.

This file is for the agent's own checklist. Keep it small to limit token burn.

## Default rotation

Cycle through these every heartbeat; pick 1-2 to actually check based on time-of-day, last-checked timestamps, and signal-to-noise.

1. **Inbox:** any urgent unread? Anything that needs same-day reply?
2. **Calendar:** any event in next 2 hours? Any prep needed for tomorrow?
3. **Threads:** any P0 hitting day 2 (24h)? Anything needing a nudge?
4. **Mentions:** Twitter / social / Slack pings?
5. **Weather:** relevant if the user might go out?
6. **Memory hygiene:** anything in recent `memory/` worth promoting to MEMORY.md?

Track checks in `memory/heartbeat-state.json`:

```json
{
  "lastChecks": {
    "email": 1703275200,
    "calendar": 1703260800,
    "threads": 1703260800,
    "mentions": null,
    "weather": null
  }
}
```

## When to reach out

- Important email arrived (specific senders flagged in USER.md)
- Calendar event in less than 2h that needs prep
- P0 thread hitting 48h SLA: nudge the user before auto-demoting
- Something interesting you found
- It's been over 8 hours since you said anything

## When to stay silent (`HEARTBEAT_OK`)

- Late night (23:00-08:00 local) unless genuinely urgent
- User is clearly busy (active conversation in another channel)
- Nothing new since last check
- You just checked under 30 minutes ago

## Heartbeat vs cron

**Use heartbeat when:**
- Multiple checks can batch together (inbox + calendar + threads in one turn)
- You need conversational context from recent messages
- Timing can drift slightly (every ~30 min is fine, not exact)

**Use cron when:**
- Exact timing matters ("9:00 AM sharp every Monday")
- Task needs isolation from main session history
- One-shot reminders ("remind me in 20 minutes")
- Output should deliver directly to a channel without main-session involvement

Batch similar periodic checks here instead of creating multiple cron jobs.

## Proactive work you can do without asking

- Read and organize memory files
- Check project status (git, threads, etc.)
- Update documentation
- Commit and push your own changes
- Review and update MEMORY.md (sweep recent daily logs → promote distilled learnings)

## Annual date reminders

The agent surfaces important dates 14 / 7 / 3 days out. Source of truth for these dates lives in `brain/people/<name>.md` (per-person dossier with `important_dates:` block) plus the table below for shared / cross-cutting dates.

| Date    | Person / event              | Action                           |
| ------- | --------------------------- | -------------------------------- |
| MM-DD   | <Name>'s birthday           | <gift idea / message draft>      |
| MM-DD   | <Anniversary>               | <action>                         |
| MM-DD   | Mother's Day                | <action>                         |
| MM-DD   | Father's Day                | <action>                         |

Update this table as relationships evolve. Heartbeat at 9am local on the 14/7/3 cadence is what triggers surfacing.
