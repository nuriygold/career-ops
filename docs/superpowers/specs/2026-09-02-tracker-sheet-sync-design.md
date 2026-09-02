# Tracker–Google Sheets Sync Design

## Goal

Keep the canonical `data/applications.md` tracker mirrored in the connected Google Sheet without changing the Sheet's Dashboard, Definitions, or Open Action Items tabs.

## Source of truth

`data/applications.md` remains canonical. Google Sheets is a derived, human-friendly mirror. Sheet edits are detected as drift and reported; they are not silently imported over canonical tracker data.

## Interface

- `node tracker-sync.mjs push` publishes the markdown application table.
- `node tracker-sync.mjs check` compares the canonical projection with the configured Sheet range and returns a non-zero exit code on drift.
- `node tracker-sync.mjs watch --interval 60` checks repeatedly and reports drift; `--repair` pushes the canonical projection after each check.
- `merge-tracker.mjs` and `set-status.mjs` call a non-blocking push after successful writes when `CAREER_OPS_SHEETS_SYNC=1`.

## Configuration

Configuration comes from environment or `.env`:

- `GOOGLE_SHEETS_CLIENT_ID`
- `GOOGLE_SHEETS_CLIENT_SECRET`
- `GOOGLE_SHEETS_REFRESH_TOKEN`
- `GOOGLE_SHEETS_TRACKER_URL` (defaults to the user's configured tracker URL in `modes/_custom.md` when available)
- `GOOGLE_SHEETS_TRACKER_TAB` (defaults to `applications-tracker-2026-08-07`)
- `GOOGLE_SHEETS_TRACKER_RANGE` (defaults to `A1:J`)
- `CAREER_OPS_SHEETS_SYNC=1` to enable automatic post-write push

## Projection

The application table columns are `#`, `Date`, `Company`, `Role`, `Score`, `Status`, `Report`, `Follow-up`, `Notes`. The legacy PDF column is omitted, and `Follow-up` is derived from notes as `Drafted` or `Sent`. Stable tracker numbers identify rows; row position is never used as identity.

## Safety

The client uses OAuth refresh-token exchange and Google Sheets REST APIs with `fetch`; no API key is embedded. Pushes use a bounded application-table range and a values update, preserving other tabs. Network/auth failures are surfaced and never reported as successful syncs. Automatic pushes are best-effort so a tracker write is not rolled back because Google is unavailable; the command output records the failure.

## Verification

Unit tests cover projection, follow-up derivation, configuration parsing, row identity, drift detection, and command planning without network calls. An integration check is run when Sheet OAuth credentials are configured.
