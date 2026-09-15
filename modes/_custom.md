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
- Job-source order: search the employer's career site first, then the employer's Greenhouse database (`greenhouse.io` / Greenhouse API). Use third-party job boards only as a last-resort reference, never as the primary application URL.
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
- Never fabricate platform scale, customer impact, production status, or authorship. Describe the work as an independently built AI-enabled production platform/private cloud and use it as evidence of systems thinking, observability, data-grounded diagnosis, reversible changes, failure recovery, auditability, and verification.
- Baseline CV selection is mandatory before creating any application submission documents. Use the following decision workflow:
  1. Classify the JD by its primary hiring outcome, not by isolated keywords. Choose `CV/cv-strategic-programs-ai-operations.md` for strategic programs, enterprise transformation, strategy and operations, operating-model, AI operations, platform operations, or technology Chief of Staff roles.
  2. Choose `CV/cv-technical-program-manager-ai-infrastructure.md` when the JD centers on technical program management, AI infrastructure, platform engineering/operations, cloud transformation, reliability programs, developer platforms, systems integration, or engineering delivery.
  3. Choose `CV/cv-workforce-strategy-total-rewards.md` for Total Rewards, compensation, benefits, workforce strategy/planning, people analytics, HR transformation, employee programs, or HR operations roles.
  4. For healthcare operations, clinical operations, interoperability, or population-health roles, start with the strategic-programs variant; switch to the workforce variant only when the role is primarily a People/HR function, and switch to the technical variant only when infrastructure/platform delivery is the stated center of gravity.
  5. If two lanes are plausible, score the JD's responsibilities: select the variant matching the majority of core outcomes and required qualifications. Do not blend variants casually; preserve one coherent narrative.
  6. If the role is a true People/HRBP/Total Rewards position, the HR-specific rules below override the general selection and the workforce variant is the default. Suppress the platform section unless AI, systems, automation, analytics, or technical operations are explicitly central.
  7. Record the selected variant in the generated submission document metadata or opening note (for example, `Baseline: CV/cv-technical-program-manager-ai-infrastructure.md`) so the package is auditable.
  8. Tailor only after selecting the baseline. Keep every claim grounded in `cv.md`, the selected variant, `article-digest.md`, `config/profile.yml`, and the JD. Never copy technical-project language into a People/HR package merely to fill space.
  9. Always generate the resume and cover letter from the same selected narrative. If the role changes materially during evaluation, re-run selection rather than patching a mismatched package.
  10. Include the employer's exact target role title once near the top of every tailored resume (for example, `Target Role: Project Manager, Consumer Products - Maternal Care`). This is a positioning label only; never alter historical employment titles.
  11. After selecting the baseline, extract the JD's highest-value ATS terms: target title, primary outcomes, required systems, methods, domain terms, and seniority signals. Map each included term to documented evidence in the CV, profile, article digest, project files, or the JD.
  12. Distinguish direct evidence from transferable evidence. Use direct language for documented experience, including the user-provided domain experience recorded in `modes/_profile.md` (T-Mobile consumer hardware launches; Warrior Body Spa packaging, retail, and DTC operations; KSW industrial design; Wellstar maternal-care products; Harvard/Warrior supply-chain and contract-manufacturing experience). Use phrases such as `relevant transferable experience` where a JD requirement is adjacent but not directly held. Never convert a transferable capability into a false domain claim.
  13. Rank evidence by relevance to the employer's desired outcome. Lead with the strongest matching metrics, responsibilities, systems, and domain experience; suppress valid but distracting content when it weakens the target narrative.
  14. Run a final ATS-and-evidence gate before creating submission documents: verify exact target-title presence, meaningful keyword coverage, source support for every claim, preserved verified metrics and credentials, explicit exclusions for unsupported requirements, and readable two-page formatting when feasible.
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
- **CV variant and ATS workflow for submission packages:** (a) read the complete JD and extract the role's primary outcomes, exact target title, function, seniority, required systems, methods, and domain terms; (b) classify it into Strategic Programs/AI Operations, Technical TPM/AI Infrastructure, or Workforce Strategy/Total Rewards; (c) select exactly one baseline variant using the decision rules above; (d) map each included ATS term to direct or transferable evidence; (e) tailor summary, competencies, bullets, and project emphasis to that lane; (f) include the exact target title near the header without changing historical job titles; (g) run the ATS-and-evidence gate and factual/source check against the canonical CV and profile; (h) write the selected baseline filename and target title into the package notes; and (i) create the Markdown resume and cover letter only after those checks pass. A package is not complete if its resume and cover letter use different baseline narratives or if unsupported claims remain.
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
