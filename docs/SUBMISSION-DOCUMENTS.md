# Submission Documents Protocol

This document defines the expected workflow for creating employer-facing submission materials inside `career-ops`.

It exists for both humans and agents. If Claude, Codex, or another agent is asked to help with a role-specific application package, this is the protocol to follow.

## Purpose

`career-ops` does not stop at role evaluation and resume generation.

For strong-fit roles, it can also produce a submission package that may include:

- a tailored resume
- a job evaluation report
- a role-specific presentation deck
- a public static deck URL
- optional appendix artifacts such as a resume snapshot or supporting screenshots

The goal is not to create documents for every role. The goal is to create a tighter, higher-signal package for roles where extra context materially improves candidacy.

## Qualification Rule

Submission documents should only be created when at least one of these is true:

1. The role is a strong fit.
Usually:
- evaluation score is `>= 4.0/5`, or
- the user explicitly wants to pursue the role despite a lower score.

2. The role benefits from narrative proof beyond a resume.
Common examples:
- strategy
- operations
- program management
- AI transformation
- applied AI leadership
- partner strategy
- GTM operations
- executive or director-level roles

3. The user explicitly asks for a submission package.

If the role is weak-fit and the user has not overridden the recommendation, do not create a full submission package.

## Canonical Output Locations

### Working assets

Use `submission documents/` for role-specific working materials such as:

- slide outlines
- screenshots
- temporary role-specific markdown decks
- exported slide-support artifacts
- PPTX drafts when needed

Examples already in use:

- `submission documents/intuit-business-operations-strategy-services-homelab-presentation.md`
- `submission documents/intuit-commercial-partner-strategy-ops-homelab-presentation.md`
- `submission documents/01-today-overview.png`

### Final resume artifacts

Use `output/` for generated resume deliverables:

- tailored HTML resume
- tailored PDF resume

### Reports

Use `reports/` for the role evaluation and reasoning record.

### Templates

Use `templates/` for reusable deck or resume templates, not for one-off role drafts.

## Required Package Components

For a strong-fit role, the default package is:

1. `Evaluation report`
Location:
- `reports/{num}-{company-slug}-{date}.md`

2. `Tailored resume HTML`
Location:
- `output/{resume-name}.html`

3. `Tailored resume PDF`
Location:
- `output/{resume-name}.pdf`

Optional components:

4. `Role-specific deck`
Use when the role is strategy, operations, leadership, AI systems, or otherwise benefits from a portfolio-style explanation.

5. `Public deck URL`
Use when the user asks for a shareable link or when the deck is meant for outreach or application support.

6. `Appendix artifacts`
Examples:
- resume snapshot slide
- architecture diagram
- workflow trace
- observability screenshot

## Deck Creation Protocol

When a presentation deck is warranted, do not rebuild from zero if an existing role family already exists.

Use:

- `templates/presentation-role-deck-template.html`
- `templates/presentation-role-deck-template.md`

### Role families currently supported

1. `Business Operations / Strategy`
Optimize for:
- operating cadence
- visibility
- accountability
- issue diagnosis
- repeatable execution
- escalation discipline
- strategy-to-execution translation

2. `Partner Strategy / GTM`
Optimize for:
- fragmented partner signals
- pipeline visibility
- partner ownership
- adoption blockers
- GTM rhythm
- measurable partner outcomes

### Slides that usually change

- `Slide 1` title / positioning
- `Slide 2` operating problem
- `Slide 3` system-to-role translation
- `Slide 6` workflow example
- `Slide 8` impact framing
- `Slide 10` employer relevance

### Slides that usually stay stable

- `Slide 4` architecture
- `Slide 7` observability / resilience
- `Slide 11` resume appendix structure
- `Slide 12` backup appendix structure

## Static HTML Deck Workflow

For no-watermark public sharing, prefer static HTML decks when possible.

Recommended flow:

1. Create or copy a role-specific HTML deck from the template.
2. Save the working file locally.
3. Publish it as a static site.
4. Keep the public alias stable when updating the same deck.

Current examples:

- business ops deck:
  - `https://aaliya-bashir-bus-ops.vercel.app`
- partner strategy deck:
  - `https://aaliya-bashir-partner-strategy.vercel.app`

## Canva Workflow

Use Canva when the user specifically wants:

- live collaborative editing
- design-first editing
- easy drag-and-drop updates
- shareable presentation links inside Canva

Important:

- Local files on your machine are not directly usable by Canva unless uploaded as Canva assets.
- If using Canva, screenshots and resume images need to be uploaded into Canva first.
- Always confirm draft edits before committing the Canva transaction.

## Resume Appendix Protocol

If the deck is used in an application or intro context, the final slides may include:

- `Appendix: Resume Snapshot`
- `Appendix: Supporting Artifact`

Do not leave appendix slides unlabeled.
Do not use a random screenshot-only slide without context.

## Naming Guidance

Prefer explicit filenames that encode company, role family, and date.

Examples:

- `cv-aaliya-bashir-intuit-business-operations-strategy-services-2026-06-14.html`
- `aaliya-bashir-intuit-jd2-v2.html`
- `aaliya-bashir-partner-strategy.html`

## Agent Rules

If an agent is working in the application pipeline:

1. Do not create a full submission package for every role by default.
2. Recommend against full package creation for weak-fit roles unless the user overrides.
3. Never submit the application on the user’s behalf.
4. Keep tracker/report/resume/deck outputs in their canonical locations.
5. Prefer reusing the deck template rather than inventing a new structure each time.
6. Make the role narrative explicit:
   - what operating problem matters
   - what the system proves
   - why the candidate is relevant
7. For public sharing, prefer static HTML deployment when the user wants a no-watermark URL.

## Minimum End State For A Strong-Fit Application

At minimum, a strong-fit application package should leave behind:

- report in `reports/`
- tailored resume HTML in `output/`
- tailored resume PDF in `output/`

If a deck is created, also leave behind:

- role-specific working assets in `submission documents/`
- reusable template updates in `templates/` only if the change is broadly reusable
- public deck URL if published
