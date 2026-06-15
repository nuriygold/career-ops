# `career-ops` -> VoltOps Integration Brief (Repo-Aligned)

This brief adapts the VoltOps integration plan to the actual operating rules of the `career-ops` repository. It resolves three conflicts in the earlier brief:

1. Tracker writes must preserve the repo's TSV + merge flow
2. User-layer files are not globally immutable in `career-ops`, but they must not be mutated by ordinary VoltOps job operations
3. Artifact naming must respect the repo's current numbered report/output conventions unless a deliberate migration is approved

The goal is to integrate `career-ops` as a first-class VoltOps agent without creating parallel state, bypassing repo governance, or forcing a new naming model that breaks existing scripts.

---

## 1. Executive Summary

`career-ops` should become a VoltOps domain agent through a thin adapter around the existing repo, not a rewrite. VoltOps should own orchestration, scheduling, triggers, notifications, and ecosystem-level workflows. `career-ops` should remain the domain owner for job evaluation, resume and cover-letter generation, tracker mutation, reports, and candidate-specific job-search logic.

The integration must preserve three repo-native invariants:

- new tracker rows are added through `batch/tracker-additions/*.tsv` and `merge-tracker.mjs`, not by direct row insertion into `data/applications.md`
- user-specific customization lives in `config/profile.yml`, `modes/_profile.md`, `article-digest.md`, and related user-layer files
- reports and artifacts follow the current repo naming and tracking model unless a formal migration is introduced

Done correctly, VoltOps gets a stable job-search domain agent with explicit contracts and governance. Done poorly, it creates duplicate state, inconsistent artifacts, and policy drift between VoltOps and the repo.

---

## 2. Recommended Architecture

**Topology: hybrid event-driven + hub-and-spoke**

VoltOps remains the hub. `career-ops` is a spoke domain service exposed through a VoltAgent server. Other agents interact with it only through tool calls, workflow execution, or semantic events.

```text
VoltOps Console / Hub
      |
      |- Scheduler / Cron
      |- Notifications
      |- Cross-agent routing
      |
      -> career-ops VoltAgent adapter
            |- evaluate_job
            |- generate_resume
            |- generate_cover_letter
            |- update_tracker
            |- summarize_pipeline
            |- later: scan_portals, draft_application_answers, follow_up
            |
            -> existing career-ops repo logic
               |- cv.md
               |- config/profile.yml
               |- modes/_profile.md
               |- article-digest.md
               |- reports/
               |- output/
               |- batch/tracker-additions/
               |- merge-tracker.mjs
```

**Boundary rule:** no agent outside the `career-ops` VoltAgent adapter may write directly to:

- `batch/tracker-additions/*`
- `data/applications.md`
- `reports/*`
- `output/*`
- `data/follow-ups.md`

The adapter is the only allowed mutation path into those assets.

---

## 3. Resolved Conflicts

### Conflict 1: Tracker ownership vs repo tracker flow

### Original brief

> `career-ops` is the only process allowed to write to `data/applications.md`

### Actual repo behavior

Per [CLAUDE.md](/Users/aaliyathewarrior/Organized/Repositories/career-ops/CLAUDE.md:314) and [modes/_shared.md](/Users/aaliyathewarrior/Organized/Repositories/career-ops/modes/_shared.md:114):

- never add new tracker entries directly to `data/applications.md`
- write tracker additions to `batch/tracker-additions/*.tsv`
- run `merge-tracker.mjs` to merge additions and avoid duplication
- direct edits to `applications.md` are allowed only for updating existing rows, such as status or notes

### Adapted rule

`career-ops` remains the sole **domain owner** of tracker state, but VoltOps must respect the repo's internal mutation mechanism:

- **create new tracker entries:** write TSV additions through the adapter, then run `merge-tracker.mjs`
- **update existing tracker rows:** allowed through the adapter using repo-safe update logic
- **public API rule:** all tracker mutations must go through `update_tracker`
- **internal implementation rule:** `update_tracker` must use the existing TSV + merge flow for inserts, and repo-safe update logic for status/note changes

### Practical implication

VoltOps should think of `data/applications.md` as a derived canonical artifact managed by `career-ops`, not as a table to mutate directly.

---

### Conflict 2: User-layer mutability vs VoltOps runtime behavior

### Original brief

> `career-ops` may never mutate user-controlled config files (`cv.md`, `config/profile.yml`, `modes/_profile.md`)

### Actual repo behavior

`career-ops` explicitly uses user-layer files for personalization and ongoing learning. Per [CLAUDE.md](/Users/aaliyathewarrior/Organized/Repositories/career-ops/CLAUDE.md:23) and [DATA_CONTRACT.md](/Users/aaliyathewarrior/Organized/Repositories/career-ops/DATA_CONTRACT.md:7):

- user-specific customization belongs in `config/profile.yml`, `modes/_profile.md`, `article-digest.md`, and `portals.yml`
- after evaluations, the system may update user-specific framing and proof points there when requested or when running profile customization flows

### Adapted rule

For VoltOps integration, distinguish between **job operations** and **profile operations**:

- **ordinary job operations** (`evaluate_job`, `generate_resume`, `generate_cover_letter`, `scan_portals`, `update_tracker`) must treat `cv.md`, `config/profile.yml`, `modes/_profile.md`, and `article-digest.md` as read-only inputs
- **explicit profile operations** may update user-layer files, but only in dedicated workflows such as:
  - onboarding
  - profile update
  - proof-point refinement
  - user-approved personalization sync

### Practical implication

The spawned VoltOps agent should not silently learn into user-layer files during normal runtime. If you want adaptive personalization in VoltOps, expose it as a separate, explicit workflow with user approval.

---

### Conflict 3: Proposed `job_<id>` artifact naming vs current repo numbering

### Original brief

> `reports/job_<jobId>_evaluation.md`
> `output/job_<jobId>_resume_v<N>.pdf`

### Actual repo behavior

Current repo conventions use sequential report numbers and company/date slugs. Per [CLAUDE.md](/Users/aaliyathewarrior/Organized/Repositories/career-ops/CLAUDE.md:67) and batch instructions:

- reports: `{###}-{company-slug}-{YYYY-MM-DD}.md`
- PDFs: `output/cv-{candidate}-{company}-{YYYY-MM-DD}.pdf`
- tracker rows link to numbered report artifacts

### Adapted rule

Do not force a new external naming convention onto the repo in Phase 1.

Instead:

- VoltOps may use an external `jobId` in API contracts and events
- the `career-ops` adapter must map `jobId` to repo-native artifact names internally
- tool responses may include both:
  - `jobId` for VoltOps
  - `reportPath` / `pdfPath` using repo-native filenames

### Practical implication

If you ever want a `job_<id>` artifact scheme, make it a formal repo migration later. For Phase 1, preserve compatibility with current scripts, tracker links, and report numbering.

---

## 4. Updated Agent Contract

### Name

`career-ops`

### Purpose

Domain agent for job-search operations: evaluate roles, generate tailored documents, maintain application state, and support follow-up workflows without executing real-world applications.

### Authority

- Read:
  - `cv.md`
  - `config/profile.yml`
  - `modes/_profile.md`
  - `article-digest.md`
  - `portals.yml`
  - repo templates and modes
- Write:
  - `batch/tracker-additions/*`
  - `reports/*`
  - `output/*`
  - `data/applications.md` only through repo-safe merge/update logic
  - `data/follow-ups.md` through repo-owned follow-up logic
- May call:
  - scheduler agent
  - notification agent
  - research agent

### Hard guardrails

- never submit an application
- never invent skills or experience
- never create a parallel tracker outside repo-owned tracker files
- never mutate user-layer files during ordinary job operations
- require explicit human approval before any state transition representing a real-world application action

### Success criteria

- evaluations remain traceable to source inputs
- generated artifacts are policy-checked before writing
- tracker state remains single-source and deduplicated
- VoltOps integrations use stable contracts without bypassing repo governance

---

## 5. Phase 1 Tool Surface

Build only the minimal wrapper first:

- `evaluate_job`
- `generate_resume`
- `generate_cover_letter`
- `update_tracker`
- `summarize_pipeline`

Do **not** start with Cron, notifications, or approval workflows until these five tools work manually.

### Public contract rule

All tool contracts may expose stable VoltOps IDs, but all file paths returned must be **repo-relative logical paths**, never absolute host paths.

Example:

```json
{
  "jobId": "job_123",
  "reportPath": "reports/004-mercury-2026-05-25.md",
  "pdfPath": "output/cv-aaliya-bashir-mercury-2026-05-25.pdf"
}
```

---

## 6. Phase 1 Governance Rules

### Resume and cover-letter generation

Before writing any artifact:

- cross-check generated claims against `cv.md`
- if a claim cannot be supported, remove it or fail the operation
- return a structured `policy_violation` error on failure

### Tracker updates

- inserts must use `batch/tracker-additions/*.tsv` + `merge-tracker.mjs`
- updates to existing rows must use repo-safe mutation logic
- retries must be idempotent and must not create duplicate entries

### User-layer files

During Phase 1:

- `cv.md`, `config/profile.yml`, `modes/_profile.md`, and `article-digest.md` are read-only
- any future mutation capability must be introduced as a separate approved workflow

---

## 7. Updated Phase Plan

### Phase 1: repo-aligned wrapper

- create VoltAgent adapter around the five core tools
- preserve repo-native tracker and artifact conventions
- implement hallucination check
- prove end-to-end manual flow with one real JD

### Phase 2: orchestration

- add workflow composition
- add human approval suspend/resume
- add notification and scheduler handoffs

### Phase 3: scheduling and production hardening

- add Cron-triggered `scan_portals`
- add observability, red-team tests, and stale-job handling
- document event schema and long-term migration options if naming/contract changes are desired

---

## 8. Final Recommendation

Treat `career-ops` as a wrapped domain engine, not as a greenfield VoltOps service.

Phase 1 should preserve:

- tracker insertion via TSV + merge
- user-layer files as ordinary read-only inputs
- repo-native report/PDF naming

That gives VoltOps a stable spawn of `career-ops` without breaking the repo's core operating assumptions.
