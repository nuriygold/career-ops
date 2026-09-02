# Custom Instructions -- career-ops

<!-- ============================================================
     THIS FILE IS YOURS. It will NEVER be auto-updated.

     Put your own house rules, custom workflows, and automations
     here -- anything you want the agent to ALWAYS do (or never do).

     This is for PROCEDURAL rules ("HOW I want things done").
     For WHO you are (archetypes, narrative, comp, negotiation),
     use modes/_profile.md instead. Keeping the two separate keeps
     each one readable.

     The agent reads this file alongside the system instructions;
     your rules here take precedence over the defaults, as long as
     they don't break the Data Contract (your files are never
     touched, and we never auto-submit an application for you).

     Because this is a user-layer file, anything you write here
     survives `node update-system.mjs`. Put customizations HERE,
     not in CLAUDE.md / modes/_shared.md / other system files --
     those get overwritten on update.
     ============================================================ -->

## House Rules

<!-- Rules the agent should always follow. Examples:
     - Always write evaluation summaries in British English.
     - Never include a photo in my CV (US / ATS-first market).
     - Cap each batch run at 20 listings unless I say otherwise.
     - If a report scores below 6, skip the cover letter. -->

- Google Sheets tracker URL: `https://docs.google.com/spreadsheets/d/1LmSKW1kaDdbcJWmC087w9W_-gGqCiwh-2TOmt9kXci0/edit?gid=758066596#gid=758066596`
- Treat the markdown tracker in `data/applications.md` as the source of truth unless I explicitly say the Google Sheet has newer data.
- Whenever I ask to update the tracker, update both `data/applications.md` and the connected Google Sheets tracker. If Google Sheets access or synchronization is unavailable, say so explicitly and do not claim the sheet was updated.
- For outbound application drafts and follow-up drafts, reference the canonical Markdown resume and cover letter documents; do not create or attach PDFs unless I explicitly request one.
- Always include the candidate phone number `+1-678-594-1031` in every submission resume and cover-letter document.
- When a follow-up draft is prepared but not yet sent, record it in the markdown tracker notes as `Follow-up drafted YYYY-MM-DD with Markdown resume and cover letter prepared.`
- In workbook and Google Sheets tracker views, surface follow-up state in a derived `Follow-up` column using `Drafted` and `Sent`. Do not add that as a canonical markdown source column unless I explicitly ask for a tracker schema change.
- The connected Google Sheets tracker intentionally omits the legacy `PDF` column and all PDF-generation/status fields from its application table, Dashboard, and Definitions. Do not recreate that attribute during future Sheet synchronization. PDF generation remains an on-demand repository capability only when explicitly requested.
- Do not generate, attach, or deliver resume PDFs. Markdown is the only resume deliverable unless I explicitly request a PDF in that message.
- For every user-verified job URL that proceeds to next steps, always create both an `output/*-resume.md` and a matching `output/*-cover-letter.md`. This applies even when a role is later recommended with caveats; do not silently omit either document.
- Treat the Markdown resume as the canonical source and keep it ATS-readable, complete, and factually grounded. Do not create PDF-only trims or preview PNGs.
- Match the formatting and information hierarchy of `/Users/aaliyathewarrior/Downloads/Aaliya Bashir Resume.pdf`: clean two-page executive resume, prominent name/contact header, clear section hierarchy, compact bullets, consistent company/role/date treatment, and restrained professional typography. Use that file as the visual reference when formatting is ambiguous.
- Resume structure must include, when relevant: Professional Summary, Core Strengths, Professional Experience, Education and Credentials, Technical Tools, and `ENGINEERING & SYSTEMS PROJECT`.
- `ENGINEERING & SYSTEMS PROJECT` is mandatory for verified roles where systems, technology, operations, analytics, transformation, infrastructure, AI, or process design are relevant. Use the canonical homelab proof points in `article-digest.md`; connect the project to the JD's relevant skills and accomplishments without implying enterprise production scale.
- Never fabricate homelab scale, customer impact, production status, or authorship. State it as a private AI-supported operations sandbox/homelab and use it as evidence of systems thinking, observability, data-grounded diagnosis, reversible changes, failure recovery, auditability, and verification.
- Cover letters are mandatory for every verified URL package. Keep them grounded in the JD and canonical source files, concise, and ready for user review. Never send or submit them.
- Qualification happens before packaging: do not create a resume or cover letter for an unqualified role. First confirm explicit Atlanta or 100% U.S.-remote location, seniority/function fit, compensation compatibility with the $200K floor, and a defensible CV match. If any gate fails, stop at qualification and report the reason.
- Do not save preview PNGs or preview folders in `output/`; clean up any temporary preview artifacts before closeout.
- For HR, People, Employee Success, Talent, Total Rewards, Compensation, Benefits, Workforce Planning, or People Analytics roles:
  - default to the HR-adjacent / business-partner narrative rather than the generic strategy/ops narrative
  - prefer language around workforce analytics, executive advisory, org support, talent-cycle support, stakeholder coaching, compensation/benefits context, and leadership decision support when those claims are truthfully supported by `cv.md`
  - suppress unrelated technical or project sections unless the JD explicitly makes them central to the role
  - treat unrelated AI/agentic/homelab/project material as excluded by default for these roles
  - use a hard negative filter: exclude plausible but distracting content that does not improve fit for a People-function reader
  - map bullets and summary language to the title semantics first, especially terms like HRBP, Employee Success, talent cycles, succession, workforce planning, compensation reviews, executive coaching, and org planning when the underlying experience can support adjacent phrasing truthfully
  - if multiple candidate narratives are possible, choose in this priority order for these roles: `people analytics / Total Rewards operator` -> `HR-adjacent business partner / executive advisor` -> `generic strategy / transformation operator`
  - do not reuse the generic `People strategy / chief-of-staff adjacent` pattern when the JD is a true HRBP / ESBP / talent partner role unless the JD itself is explicitly chief-of-staff-like
  - title semantics outrank reusable package patterns: optimize first for the actual JD language, not for whatever People-role template was used most recently
  - before finalizing any section, score it mentally for JD relevance:
    - `direct`: clearly strengthens fit for this People/HR role -> include
    - `adjacent`: useful but not central -> include only if space permits and it supports the main narrative
    - `distracting`: valid content but weakens the People/HR pitch -> exclude
  - selected project sections are excluded by default for these roles; only include one when the JD explicitly requires the same project domain and the project materially improves fit
  - grouped tools should reflect business-use relevance rather than a flat generic tool dump; when truthful, prefer categories that show analytics, business systems, collaboration/planning, and executive communication support
  - do not compress to a cleaner one-page story at the expense of HRBP specificity; preserve the bullets or phrasing that make the People-function fit explicit before trimming broader strategy/ops language
  - when choosing between a broader operator framing and a narrower HRBP framing, choose the narrower HRBP framing if it is truthfully supportable from `cv.md`
- Historical reference note from the 2026-08-10 submitted resume set (not an instruction to generate PDFs):
  - `023`, `024`, `025`, and `026` used formatting-only changes relative to the generated MD resumes.
  - `022` was the only one that required render-only content trims in the submitted version: one Wellstar bullet removed, one Harvard bullet removed, one Warrior Body Spa bullet removed, the Selected Project blurb tightened, and one Core Strengths line reworded for wrap control.
  - Treat those as PDF-rendering differences only, not source-MD edits.

## Custom Workflows

<!-- Multi-step routines you run often, given a short name. Examples:
     - "weekly review": scan my saved portals, evaluate the new roles,
       then give me a one-paragraph summary of the top 3.
     - "prep <company>": pull the JD, generate STAR stories from
       article-digest.md, and draft 5 likely interview questions. -->

- When I provide a Google Sheets tracker URL, keep it on hand and surface it in tracker-related replies when useful.
- Do not use the repo-local branded resume builder or any PDF renderer unless I explicitly request a PDF in the current message.
- After an application is recorded as Submitted/Applied, automatically research the department head and relevant hiring-team contacts using public web sources and LinkedIn, then prepare an unsent Gmail draft addressed to the verified contact email addresses. Never send the draft automatically.
- If the job posting is directly associated with a specific person on LinkedIn, also draft a personalized LinkedIn message expressing interest in the role. Never send it automatically.
- Outreach drafts must use verified public contact details only, must not invent email addresses, and must never use em dashes.
- Never send or draft mail to a no-reply address, including ATS confirmation addresses such as `no-reply@ashbyhq.com`; these addresses are non-deliverable for outreach and cannot produce a response.
- When outreach involves multiple verified recipients, place recipients in BCC to reduce noise and improve the likelihood of individual responses. Use a direct To recipient only when one clear primary contact exists.
- Do not recommend or add roles unless they are based in Atlanta, including Atlanta hybrid/on-site roles, or explicitly 100% remote within the United States. Treat remote roles with ambiguous location, travel-heavy requirements, or conflicting office details as unverified and do not recommend them.

## Output Preferences

<!-- How you like results formatted. Examples:
     - Reports: lead with the score and the one-line verdict.
     - Show the per-step token breakdown after a batch run.
     - Save PDFs date-first: YYYY-MM-DD-company.pdf -->

(none yet -- add yours above)

## Off-Limits

<!-- Things the agent must never do for you. Examples:
     - Never auto-fill or submit an application without showing me first.
     - Never edit a system file to customize my setup -- put it here. -->

(none yet -- add yours above)
