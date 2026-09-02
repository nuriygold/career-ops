# Tracker–Google Sheets Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a markdown-canonical Google Sheets mirror with push, check, watch, and automatic post-write synchronization.

**Architecture:** Pure tracker projection and drift logic are separated from the Google REST client. The CLI loads canonical markdown rows, derives the Sheet application table, and uses OAuth refresh tokens to read/update only the configured application range. Existing tracker writers invoke an opt-in best-effort push after successful local writes.

**Tech Stack:** Node.js 18+ built-in `fetch`, Google OAuth 2.0 and Sheets v4 REST APIs, existing tracker parser/lock utilities, Node test scripts.

**Spec:** `docs/superpowers/specs/2026-09-02-tracker-sheet-sync-design.md`

## Global Constraints

- `data/applications.md` remains canonical.
- Sync only the configured application table range.
- Match by stable tracker number, never row position.
- Do not recreate the PDF column.
- Never claim success on auth/network failure.
- Automatic pushes are opt-in with `CAREER_OPS_SHEETS_SYNC=1` and best-effort.

### Task 1: Projection and drift core

**Files:** Create `tracker-sheet-sync-core.mjs`, `tracker-sheet-sync-core-tests.mjs`.

- [ ] Write tests first for markdown-row projection, derived follow-up, stable row identity, config defaults, and drift summaries.
- [ ] Run `node tracker-sheet-sync-core-tests.mjs` and confirm expected failure.
- [ ] Implement pure functions `projectTrackerRows`, `deriveFollowup`, `normalizeCell`, `indexByTrackerNumber`, and `compareProjections`.
- [ ] Run the tests and confirm they pass.

### Task 2: OAuth REST client and CLI

**Files:** Create `tracker-sync.mjs`, `tracker-sync-tests.mjs`; modify `package.json`.

- [ ] Write tests for safe command construction and missing-credential errors without making network calls.
- [ ] Implement refresh-token exchange, bounded Sheets reads/updates, `push`, `check`, and `watch` modes.
- [ ] Ensure `push` updates only the application range and preserves existing Sheet-only tabs.
- [ ] Run targeted and full tests.

### Task 3: Automatic writer integration

**Files:** Modify `merge-tracker.mjs`, `set-status.mjs`, `tracker-utils.mjs`; create `tracker-sync-hook.mjs` and tests.

- [ ] Write tests proving the hook is disabled by default, enabled by `CAREER_OPS_SHEETS_SYNC=1`, and does not throw when sync fails.
- [ ] Add a shared post-write hook after successful atomic tracker transactions.
- [ ] Run tracker and sync tests, then the existing pipeline verifier.

### Task 4: Documentation and verification

**Files:** Modify `README.md`, `docs/SCRIPTS.md`, `modes/_custom.md` only for the existing user preference/config reference if needed.

- [ ] Document OAuth setup, environment variables, commands, and markdown-canonical conflict behavior.
- [ ] Run the full test suite and a dry command check.
- [ ] Run a real push/check only if credentials are available; otherwise report the exact prerequisite.
