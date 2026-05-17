# Nik Sharma's Operator Kit (bundled here for convenience)

This folder is **not Dylan's content**. The two files here come from Nik Sharma's Operator Kit at [openclaw.nik.co](https://openclaw.nik.co):

- **MANUAL.md** (3,000 words): the operating manual. Memory architecture, reasoning, shipping discipline, communication, tooling. The philosophy layer.
- **LIFE-SKILLS.md** (15,652 words, 322 lessons across 25 categories): the practical layer. Every lesson came from a real failure or win, fingerprint-stripped, generic enough to work for any setup.

## Why these files are in this kit

Dylan's kit is the multi-agent OS layer. Nik's kit is the discipline layer underneath. They stack. This kit started from Nik's structure (file naming convention, iron-law concept, install pattern). Including his canonical files here means you get both layers in one install.

## License

Nik's files are **MIT licensed** and explicitly redistributable. Dylan's kit is also MIT licensed. Both layers are free, forkable, redistributable, with attribution.

The canonical home for Nik's files is **[openclaw.nik.co](https://openclaw.nik.co)**. If you want the absolute latest version, fetch directly from his site.

## How to read these

1. Read **MANUAL.md** first. ~10 minutes. It's the philosophy.
2. Skim **LIFE-SKILLS.md** end to end once. Don't try to absorb all 322 lessons. Get a feel for the surface area.
3. When your agent hits a situation that maps to a lesson, return to it.

## Updating these files

These bundled copies are versioned with this kit. To get Nik's latest:

```bash
curl -fsSL https://openclaw.nik.co/MANUAL.md -o nik/MANUAL.md
curl -fsSL https://openclaw.nik.co/LIFE-SKILLS.md -o nik/LIFE-SKILLS.md
```

Or run Nik's installer directly to pull his full kit at the canonical source:

```bash
curl -fsSL https://openclaw.nik.co/install.sh | bash
```

## Credit

Every iron-law-formatted line in Dylan's MEMORY.md template owes its design to Nik's work. The cache-boundary memory architecture, threads-as-protocol, and multi-agent registry are Dylan's additions on top of that foundation. The two layers are honest siblings.

— Bundled with permission and attribution. MIT. 2026.
