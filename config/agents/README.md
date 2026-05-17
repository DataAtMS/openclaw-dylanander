# agents/: multi-agent registry

The directory of every sub-agent running off this workspace. Each sub-agent has its own AGENTS.md, SOUL.md, IDENTITY.md, memory namespace, and skill list.

## Why multi-agent

A single agent doing four businesses leaks context. The agent that just drafted a personal newsletter is wrong for triaging a B2B SaaS client renewal. Same model, same workspace, wrong head-state.

Sub-agents give you separate head-states without separate workspaces. Each one inherits the workspace root (AGENTS, MEMORY, TOOLS) and overlays its own files. The main agent delegates; specialists own their lane.

## Registry

| Agent      | Role                                  | Channel(s)                       | Iron law of the agent                           |
| ---------- | ------------------------------------- | -------------------------------- | ----------------------------------------------- |
| `main`     | Primary EA. Runs everything by default | Telegram (DM), Slack DM, webchat | All emails go from the EA, draft-and-approve   |
| `content`  | Newsletter + long-form writing         | Telegram (`@<content_bot>`), webchat | Voice = the brand's, not the EA's              |
| `<brand>-ops` | Brand-specific ops (ecom, etc.)     | Slack (#<brand>-ops)             | Draft + approve before any external action      |
| `<coding>` | Channel-bound ACP harness for coding  | Editor / coding-agent channel    | Codebase-specific conventions; no cross-repo edits |

Add a row when you spawn a new sub-agent. Delete a row when you retire one. Keep this table truthful.

## File layout per agent

```
agents/<name>/
├── AGENTS.md         agent-specific working conventions (overrides root)
├── SOUL.md           agent-specific persona (overrides root)
├── IDENTITY.md       name, role, vibe, emoji
├── MEMORY.md         (optional) agent-specific durable facts
└── skills/           (optional) agent-specific skills not shared with main
```

The agent loads workspace-root files first, then overlays its own. Closer wins.

## How the main agent delegates

When the main agent recognizes a task that belongs to a specialist:

1. Identify the right sub-agent from the registry.
2. Spawn or message that sub-agent with a clean context (not the full main-agent transcript unless needed).
3. Wait for completion (push-based; the runtime auto-announces when the sub-agent is done).
4. Take the result, validate it against the user's actual intent, and surface it back.

Sub-agents are tools, not autonomous decision-makers. The main agent owns the user-facing relationship.

## Iron laws across agents

Some iron laws are workspace-wide (no em dashes, no hedging, all times in principal's TZ). Those live in the root `MEMORY.md` and inherit to every sub-agent.

Some iron laws are agent-specific (the content agent uses the brand's voice, not the EA's). Those live in `agents/<name>/AGENTS.md` and only apply to that sub-agent.

## Voice leak prevention

Sub-agents must not bleed into each other. Practical rules:

- Each sub-agent has its own IDENTITY (name, voice). The content agent is not the EA.
- Each sub-agent reads its own SOUL.md on session start, not the root one.
- Cross-agent context-sharing happens through files (memory, threads, dossiers), not through transcript handoff.
- When a sub-agent writes to MEMORY.md, it prefixes the entry with its name (so future-main can see who wrote what).

## When to spawn a new sub-agent

Spawn a new sub-agent when:

- A channel needs a distinct persona (e.g. a brand's customer-facing bot)
- A workflow needs a distinct toolkit not shared with main
- A task type recurs often enough to justify dedicated context (e.g. coding, content)
- You want to firewall sensitive context from the main agent (e.g. portfolio company confidential data)

Do NOT spawn a new sub-agent for:

- A one-off task (use a subagent invocation instead)
- A different model (just switch the model on the existing agent)
- A different prompt-engineering tweak (update the existing agent's SOUL/AGENTS)
