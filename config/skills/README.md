# skills/: custom skill structure

Skills are reusable capabilities the agent loads on demand. They live here when they're specific to this workspace. Generic skills live in your OpenClaw extension directories.

## Skill format

Each skill is a folder containing a `SKILL.md`:

```
skills/<skill-name>/
└── SKILL.md
```

`SKILL.md` follows this structure:

```markdown
---
name: <skill-name>
description: One-paragraph description of when to use this skill. Optimized for the agent's mandatory-skills selector; be specific about the trigger conditions.
location: ~/.openclaw/workspace/skills/<skill-name>/SKILL.md
---

# <skill-name>

## When to use

Concrete trigger conditions. Be specific about what kind of task this skill applies to.

## Steps

1. Step one
2. Step two
3. Step three

## Examples

Concrete examples of inputs and outputs.

## Gotchas

Things to watch out for. Lessons learned from real failures.
```

## How the agent picks a skill

At session start, the runtime injects an `<available_skills>` block with each skill's name, description, and location. The agent:

1. Scans `<description>` entries on every reply
2. If exactly one skill clearly applies, reads its SKILL.md and follows it
3. If multiple could apply, picks the most specific one
4. If none clearly apply, does not read any SKILL.md

Constraints:
- Never read more than one skill up front
- Only read after selecting

## When to write a skill vs a brain page vs a TOOLS entry

| Need                                       | Goes here                                |
| ------------------------------------------ | ---------------------------------------- |
| "How do I call this API?"                  | `TOOLS.md` section                       |
| "How do I do this multi-step workflow?"    | `skills/<name>/SKILL.md`                 |
| "What do I know about this person/company?" | `brain/people/` or `brain/companies/`    |
| "What's the durable rule?"                 | `MEMORY.md` (iron law if behavior-shaping) |

## Suggested workspace skills to consider

Most operators end up wanting these. Build them as needed:

- **`weekly-rollup`:** pull metrics from each business and assemble the weekly numbers report
- **`client-onboarding`:** the full new-client kickoff sequence (kickoff email, agenda, week-1 sprint, day-30 milestone)
- **`renewal-prep`:** pull the data for a renewal conversation (engagement metrics, wins shipped, expansion angles)
- **`newsletter-publish`:** full publish workflow (final QA pass, Beehiiv upload, social cross-post, archive)
- **`email-triage`:** bulk inbox sort with default reply drafts for common patterns
- **`heartbeat-rotate`:** the rotating-check pattern from HEARTBEAT.md, formalized

Start with one. Build the next when the pattern recurs three times.

## Rate-limit hygiene

When a skill drives external API writes (Monday, Beehiiv, Klaviyo, Stripe), assume rate limits. Prefer fewer larger writes. Avoid tight one-item loops. Serialize bursts. Respect 429 / Retry-After.

## Updating skills

When you learn something new while running a skill:

1. Update the relevant SKILL.md with the new step or gotcha
2. Log the update to today's `memory/YYYY-MM-DD.md`
3. If the lesson is iron-law-worthy (a behavior that should NEVER change), promote to MEMORY.md

Skills compound over time. The first version of a skill is a sketch; version 5 is the reason your agent ships in 10 minutes what used to take 2 hours.
