#!/usr/bin/env bash
# Dylan Ander's OpenClaw installer.
#
# USAGE:
#   curl -sSL https://openclaw.dylanander.com/install.sh | bash
#       → default: "learn" mode. Downloads the kit into a new
#         /dylan-ander-openclaw/ subfolder. Your existing SOUL.md,
#         USER.md, AGENTS.md, MEMORY.md are NEVER touched.
#
#   curl -sSL https://openclaw.dylanander.com/install.sh | bash -s -- --mode additive
#       → "additive": learn mode + optional empty scaffolding for
#         memory/, journal/, threads/, brain/.
#
#   curl -sSL https://openclaw.dylanander.com/install.sh | bash -s -- --mode fresh
#       → "fresh": brand-new workspaces only. Writes full templates
#         to the workspace root. Existing files are preserved and
#         new versions land alongside with a .new suffix.
#
#   curl -sSL https://openclaw.dylanander.com/install.sh | bash -s -- --dest /custom/path
#       → override install destination (defaults to ~/.openclaw/workspace).
#
# DESIGN PRINCIPLE: your workspace is yours. This kit adds a reference
# folder by default. Your agent reads it and proposes adopting specific
# patterns. Nothing overwrites your identity, memory, or conventions silently.

set -e

BASE_URL="${BASE_URL:-https://openclaw.dylanander.com}"
DEST="${HOME}/.openclaw/workspace"
MODE="learn"

while [ $# -gt 0 ]; do
  case "$1" in
    --dest) DEST="$2"; shift 2 ;;
    --dest=*) DEST="${1#*=}"; shift ;;
    --mode) MODE="$2"; shift 2 ;;
    --mode=*) MODE="${1#*=}"; shift ;;
    *) shift ;;
  esac
done

case "$MODE" in
  learn|additive|fresh) ;;
  *) echo "error: --mode must be one of: learn | additive | fresh"; exit 1 ;;
esac

KIT_DIR="${DEST}/dylan-ander-openclaw"

echo ""
echo "▸ Dylan Ander's OpenClaw installer"
echo "  Mode:        ${MODE}"
echo "  Destination: ${DEST}"
if [ "$MODE" != "fresh" ]; then
  echo "  Kit subfolder: ${KIT_DIR}"
  echo "  Your existing SOUL.md / USER.md / AGENTS.md / MEMORY.md will NOT be touched."
fi
echo ""

fetch_into() {
  local rel_url="$1"
  local dest_abs="$2"
  local label="$3"
  mkdir -p "$(dirname "${dest_abs}")"
  if curl -sSL --fail "${BASE_URL}${rel_url}" -o "${dest_abs}" 2>/dev/null; then
    echo "  + ${label}"
    return 0
  else
    echo "  ✗ ${label} (fetch failed, skipped)"
    return 1
  fi
}

# Core files that land identically in learn / additive / fresh.
CORE_FILES=(
  "/config/AGENTS.md|AGENTS"
  "/config/SOUL.md|SOUL"
  "/config/IDENTITY.md|IDENTITY"
  "/config/USER.md|USER"
  "/config/MEMORY.md|MEMORY"
  "/config/TOOLS.md|TOOLS"
  "/config/HEARTBEAT.md|HEARTBEAT"
  "/config/threads/threads.md|threads/threads.md"
  "/config/memory/README.md|memory/README.md"
  "/config/journal/README.md|journal/README.md"
  "/config/agents/README.md|agents/README.md"
  "/config/agents/main/AGENTS.md|agents/main/AGENTS.md"
  "/config/agents/content/AGENTS.md|agents/content/AGENTS.md"
  "/config/skills/README.md|skills/README.md"
  "/docs/ARCHITECTURE.md|docs/ARCHITECTURE.md"
  "/docs/MIGRATING-FROM-HERMES.md|docs/MIGRATING-FROM-HERMES.md"
  "/docs/MULTI-BUSINESS-SETUP.md|docs/MULTI-BUSINESS-SETUP.md"
  "/README.md|README.md"
  # Nik Sharma's Operator Kit, bundled with attribution. MIT licensed.
  # Canonical home: https://openclaw.nik.co
  "/nik/README.md|nik/README.md"
  "/nik/MANUAL.md|nik/MANUAL.md"
  "/nik/LIFE-SKILLS.md|nik/LIFE-SKILLS.md"
)

case "$MODE" in

  learn)
    mkdir -p "${KIT_DIR}"
    echo "Installing reference materials into ${KIT_DIR}/ ..."
    for entry in "${CORE_FILES[@]}"; do
      src="${entry%%|*}"
      rel="${entry#*|}"
      # Use .example.md naming for the six template files at root so it's
      # obvious they're reference material, not replacements.
      case "$rel" in
        AGENTS|SOUL|IDENTITY|USER|MEMORY|TOOLS|HEARTBEAT)
          fetch_into "${src}" "${KIT_DIR}/${rel}.example.md" "${rel}.example.md"
          ;;
        *)
          fetch_into "${src}" "${KIT_DIR}/${rel}" "${rel}"
          ;;
      esac
    done
    echo ""
    cat <<EOF
Learn mode install complete. Everything landed in:
  ${KIT_DIR}/

Nothing at your workspace root was modified.

Next step. tell your agent:

  Read dylan-ander-openclaw/docs/ARCHITECTURE.md end to end, then walk every
  file in dylan-ander-openclaw/. Identify every pattern our existing workspace
  does not already implement (multi-agent registry, threads priority lanes,
  memory cache boundary, iron-law format, business-prefix shorthand, weekday
  SLAs). Propose specific edits to our SOUL.md / USER.md / AGENTS.md /
  MEMORY.md one pattern at a time. Do not rewrite what we have. Only suggest
  incremental improvements with my approval.

Repo:  https://github.com/dylanander/dylan-ander-openclaw
Docs:  https://openclaw.dylanander.com
EOF
    ;;

  additive)
    mkdir -p "${KIT_DIR}" \
      "${DEST}/memory/archive" \
      "${DEST}/journal" \
      "${DEST}/threads" \
      "${DEST}/brain/people" \
      "${DEST}/brain/companies"
    echo "Installing reference materials into ${KIT_DIR}/ and scaffolding optional directories..."
    for entry in "${CORE_FILES[@]}"; do
      src="${entry%%|*}"
      rel="${entry#*|}"
      case "$rel" in
        AGENTS|SOUL|IDENTITY|USER|MEMORY|TOOLS|HEARTBEAT)
          fetch_into "${src}" "${KIT_DIR}/${rel}.example.md" "${rel}.example.md"
          ;;
        *)
          fetch_into "${src}" "${KIT_DIR}/${rel}" "${rel}"
          ;;
      esac
    done
    echo "  + created memory/archive/, journal/, threads/, brain/people/, brain/companies/"
    echo ""
    cat <<EOF
Additive install complete.

What was created:
  ${KIT_DIR}/                  (reference materials, read these)
  ${DEST}/memory/archive/      (for stale daily logs)
  ${DEST}/journal/             (bed/wake/feel/day schema)
  ${DEST}/threads/             (P0/P1/P2/P3 priority lanes)
  ${DEST}/brain/people/        (per-person dossiers)
  ${DEST}/brain/companies/     (per-company dossiers)

Nothing at the workspace root was modified.

Repo:  https://github.com/dylanander/dylan-ander-openclaw
Docs:  https://openclaw.dylanander.com
EOF
    ;;

  fresh)
    mkdir -p "${DEST}/memory/archive" "${DEST}/journal" "${DEST}/threads" \
      "${DEST}/agents/main" "${DEST}/agents/content" \
      "${DEST}/skills" "${DEST}/brain/people" "${DEST}/brain/companies" \
      "${DEST}/docs"
    echo "Fresh install. Writing to ${DEST}/."
    echo "(Any existing files are preserved: new versions land as *.new for manual review.)"
    echo ""

    INSTALLED=0
    SKIPPED=0

    for entry in "${CORE_FILES[@]}"; do
      src="${entry%%|*}"
      rel="${entry#*|}"
      case "$rel" in
        AGENTS|SOUL|IDENTITY|USER|MEMORY|TOOLS|HEARTBEAT)
          dest_rel="${rel}.md"
          ;;
        *)
          dest_rel="${rel}"
          ;;
      esac
      dest_abs="${DEST}/${dest_rel}"

      if [ -f "${dest_abs}" ]; then
        new_abs="${dest_abs}.new"
        if curl -sSL --fail "${BASE_URL}${src}" -o "${new_abs}.tmp" 2>/dev/null; then
          if cmp -s "${dest_abs}" "${new_abs}.tmp"; then
            rm -f "${new_abs}.tmp"
            echo "  ✓ ${dest_rel} (already identical)"
          else
            mv "${new_abs}.tmp" "${new_abs}"
            echo "  • ${dest_rel} (existing file kept; new version saved as ${dest_rel}.new)"
          fi
        else
          rm -f "${new_abs}.tmp" 2>/dev/null
          echo "  ✗ ${dest_rel} (fetch failed, skipped)"
        fi
        SKIPPED=$((SKIPPED+1))
      else
        if fetch_into "${src}" "${dest_abs}" "${dest_rel}"; then
          INSTALLED=$((INSTALLED+1))
        fi
      fi
    done

    echo ""
    echo "Fresh install: ${INSTALLED} files written, ${SKIPPED} preserved."
    echo ""
    cat <<EOF
Fresh install complete.

Next step. open ${DEST}/docs/ARCHITECTURE.md and read it end to end.
That document is the contract. Everything else is downstream of it.

Repo:  https://github.com/dylanander/dylan-ander-openclaw
Docs:  https://openclaw.dylanander.com
EOF
    ;;
esac

echo ""
