# TOOLS.md: Wired-tools catalog

The "what's wired and how do I call it" cheat sheet. Grep this when uncertain.

Format per service: name, status, credentials path, primary CLI/method, base URL, common ops, owner notes.

Credentials live in `~/.openclaw/credentials/<service>.env` by convention. Never commit them. Never paste them into chat unless asked.

---

## Google Workspace ✅ wired (template)

- **Service:** Gmail, Calendar, Drive, Contacts, Docs, Sheets, Tasks, People
- **Credentials:** OAuth tokens in `gog` CLI keychain (managed by `gog` itself, not a flat file)
- **Method:** `gog` CLI
- **Auth:** Per-account, selected via `-a <email>` flag

**Authed accounts (example):**
- `assistant@<domain>` (the EA's account; sends mail)
- `principal@<domain>` (the principal's primary; "keeper" if other companies sell)
- `principal@<agency-domain>` (client-facing)

**Common ops:**
```bash
# Email
gog gmail messages list "in:inbox" -a principal@<domain> --max=10 -p
gog gmail messages list "from:peter -older_than:7d" -a principal@<agency-domain> -p

# Calendar
gog calendar list -a principal@<agency-domain> --from "2026-01-01" --to "2026-01-02" --max=30 -p
gog calendar list -a principal@<domain> --tomorrow -p

# Drive
gog drive ls --query "name contains 'foo'" -a principal@<domain> -p
gog drive download <FILE_ID> -a assistant@<domain> --output /path/to/save

# Docs
gog docs read <DOC_ID> -a <email>
```

**Known gotchas:**
- Filter creation requires `gmail.settings.basic` scope.
- `--time-min` / `--time-max` on calendar may throw 404; use `--from` / `--to` or `--tomorrow`.

---

## Newsletter platform (e.g. Beehiiv) ✅ wired (template)

- **Service:** Beehiiv (or your platform)
- **Credentials:** `~/.openclaw/credentials/newsletter.env`
- **Method:** REST API via `curl`
- **Base URL:** `https://api.beehiiv.com/v2`
- **Auth header:** `Authorization: Bearer $NEWSLETTER_API_KEY`

**Publications (example):**
- Personal newsletter: `pub_<id>` (~30K subs)
- Company newsletter: `pub_<id>` (separate revenue line)

**Common ops:**
```bash
source ~/.openclaw/credentials/newsletter.env
PUB_ID="pub_<id>"

# Recent posts with stats
curl -s -H "Authorization: Bearer $NEWSLETTER_API_KEY" \
  "https://api.beehiiv.com/v2/publications/$PUB_ID/posts?limit=10&order_by=publish_date&direction=desc&expand=stats"

# Subscribers by status
curl -s -H "Authorization: Bearer $NEWSLETTER_API_KEY" \
  "https://api.beehiiv.com/v2/publications/$PUB_ID/subscriptions?limit=100&status=invalid"

# Delete a subscription
curl -X DELETE -H "Authorization: Bearer $NEWSLETTER_API_KEY" \
  "https://api.beehiiv.com/v2/publications/$PUB_ID/subscriptions/$SUB_ID"
```

**Notes:**
- Posts API may not return email body content; pull from the public web URL if you need it.

---

## Project management (e.g. Monday.com) ✅ wired (template)

- **Service:** Monday.com (or Linear / ClickUp / Notion)
- **Credentials:** `~/.openclaw/credentials/monday.env`
- **Method:** GraphQL API via `curl` (or Python helper)
- **Endpoint:** `https://api.monday.com/v2`
- **Auth header:** `Authorization: $MONDAY_API_TOKEN`

**Key boards (example):**
- `<board_id>`: Tasks (general)
- `<board_id>`: Accounts / Clients
- `<board_id>`: Billing & Payments
- `<board_id>`: Tools & Subscriptions

**Common ops:**
```bash
source ~/.openclaw/credentials/monday.env

# Who am I + account
curl -s -X POST -H "Authorization: $MONDAY_API_TOKEN" -H "Content-Type: application/json" \
  -d '{"query":"{ me { name email account { id name } } }"}' \
  https://api.monday.com/v2

# List items on a board
curl -s -X POST -H "Authorization: $MONDAY_API_TOKEN" -H "Content-Type: application/json" \
  -d '{"query":"{ boards(ids: <board_id>) { items_page(limit: 25) { items { id name column_values { id text value } } } } }"}' \
  https://api.monday.com/v2
```

**Default destination for new tasks:**
- Board: `Tasks` (`<id>`)
- Group: `MASTER TASKS` (`group_title`)
- Use this unless the principal specifies otherwise.

**Team Monday user IDs:**
- `<Name>`: `<id>` (`<email>`)
- `<Name>`: `<id>` (`<email>`)

**Tasks board key columns:**
- `name`: item name
- `person`: assignee
- `dropdown_<slug>`: Brand (one column-value per business prefix)
- `color_<slug>`: Priority (P0 / P1 / P2 / P3)
- `status`: In progress / Completed / Stuck / Day to Day / Needs Review
- `date4`: Due Date (YYYY-MM-DD)

**Create-item pattern (use Python, not heredoc: GraphQL string escaping is brittle):**
```python
import json, os, urllib.request
TOKEN = os.environ["MONDAY_API_TOKEN"]
def gql(q):
    req = urllib.request.Request("https://api.monday.com/v2",
        data=json.dumps({"query": q}).encode(),
        headers={"Authorization": TOKEN, "Content-Type": "application/json"}, method="POST")
    return json.loads(urllib.request.urlopen(req).read())

column_values = {
    "person": {"personsAndTeams": [{"id": <user_id>, "kind": "person"}]},
    "color_<slug>": {"label": "P0"},
    "status": {"label": "In progress"},
    "date4": {"date": "2026-01-01"},
}
cv = json.dumps(json.dumps(column_values))
q = f'''mutation {{ create_item(board_id: <board_id>, group_id: "group_title", item_name: "Task name", column_values: {cv}) {{ id name }} }}'''
print(gql(q))
```

**Notes:**
- Treat the token as a production credential.
- Rate limit: API has complexity budget per minute; batch reads when possible.

---

## Email marketing (e.g. Klaviyo) ✅ wired (template)

- **Service:** Klaviyo (or Sendgrid / Postmark)
- **Account:** <brand>
- **Credentials:** `~/.openclaw/credentials/klaviyo-<brand>.env`
- **Method:** REST API via `curl`
- **Base URL:** `https://a.klaviyo.com/api`
- **Auth header:** `Authorization: Klaviyo-API-Key $KLAVIYO_<BRAND>_API_KEY`

**Common ops:**
```bash
source ~/.openclaw/credentials/klaviyo-<brand>.env

curl -s -H "Authorization: Klaviyo-API-Key $KLAVIYO_API_KEY" \
  -H "revision: 2023-12-15" \
  "https://a.klaviyo.com/api/lists/"
```

---

## Telegram ✅ wired (template)

- **Service:** Telegram Bot API
- **Credentials:** OpenClaw config (`~/.openclaw/openclaw.json`)
- **Method:** OpenClaw native channel; Bot API directly via `curl` for verification
- **Bots:**
  - `@<main_bot>` (token: `<token>`) → routes to `main` agent
  - `@<content_bot>` (token: `<token>`) → routes to `content` agent

**Direct API check:**
```bash
curl -s "https://api.telegram.org/bot<TOKEN>/getMe" | python3 -m json.tool
```

**Settings:**
- Set `linkPreview: false` so URLs stay text-only.

---

## Web search ✅ wired

- **Service:** Brave Search API (or whatever your runtime provides)
- **Credentials:** OpenClaw config
- **Method:** Native `web_search` tool

---

## Audio transcription ✅ wired

- **Service:** OpenAI Whisper (or local Whisper)
- **Credentials:** OpenClaw config (skill-level)
- **Method:** Native skill

---

## LLM API ✅ wired

- **Service:** Anthropic / OpenAI / your provider
- **Credentials:** OpenClaw auth profile
- **Method:** OpenClaw runtime-managed
- **Active model:** `<provider>/<model>` (this conversation); default `<provider>/<default-model>`

---

## Slack ✅ wired (template)

- **Service:** Slack workspace(s)
- **Credentials:** Bot tokens in OpenClaw config per workspace
- **Method:** OpenClaw native skill / Bot API
- **Workspaces wired:** `<workspace-1>`, `<workspace-2>`

---

## Analytics (GA4 / GSC) ✅ wired (template)

- **Service:** Google Analytics 4 + Search Console
- **Auth:** One partner Google account covers all client properties (set up by domain admin)
- **Method:** `gog` CLI or direct API
- **Properties wired:** see `brain/companies/<name>.md` for the property ID per client

---

## Payments / billing (e.g. Stripe) ✅ wired (template)

- **Service:** Stripe
- **Credentials:** `~/.openclaw/credentials/stripe-<account>.env`
- **Method:** REST API via `curl` or Stripe CLI
- **Accounts:** one per legal entity
- **Common ops:** MRR pull, churn report, invoice creation, refund

---

## Ecommerce (e.g. Shopify) ✅ wired (template)

- **Service:** Shopify Admin API
- **Credentials:** `~/.openclaw/credentials/shopify-<brand>.env`
- **Method:** REST + GraphQL
- **Common ops:** order lookup, product update, customer search, discount creation

---

## GitHub ✅ wired (template)

- **Service:** GitHub
- **Credentials:** `gh` CLI auth (per-account)
- **Method:** `gh` CLI
- **Accounts:** `<your-handle>`, `<org-handle>`

---

## Hosting / DNS / tunneling (template)

- **Service:** Vercel, Cloudflare, GoDaddy, Cloudflare Tunnel
- **Common ops:** DNS record add/update (preserve existing records: `setHosts`-style APIs are destructive), tunnel start/stop, deploy status

---

## Custom OpenClaw API (template)

- **Endpoint:** `http://<local-ip>:<port>` for local-network access
- **Public:** Cloudflare Tunnel route at `https://<subdomain>.<your-domain>`
- **Use:** lets other agents / scripts call OpenClaw without owning the workspace directly

---

## Adding a new tool

When you wire a new tool:

1. Add a section here with the format above.
2. Drop credentials in `~/.openclaw/credentials/<service>.env`.
3. Add a `brain/tools/<service>.md` page only if it warrants deep notes; otherwise just live in this file.
4. Update the relevant skill if one exists, or write a new one in `skills/`.
5. Log the addition to `memory/YYYY-MM-DD.md`.
