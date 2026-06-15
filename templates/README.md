# Templates

System-layer template files used by career-ops scripts and modes. These files are auto-updated when you run `npm run update` -- put user customizations in the user-layer files instead (see DATA_CONTRACT.md).

## Files

| File | Used By | Purpose |
|------|---------|---------|
| `cv-template.html` | `generate-pdf.mjs` | HTML/CSS template for ATS-optimized CV PDFs |
| `cv-template-executive-clean.html` | `generate-pdf.mjs` | Clean executive resume template with stronger hierarchy and ATS-safe styling |
| `presentation-role-deck-template.html` | manual deck editing / static publishing | Reusable 12-slide HTML deck template for role-specific presentation variants |
| `presentation-role-deck-template.md` | manual deck editing | Guide for adapting the presentation template by role without rebuilding structure |
| `portals.example.yml` | Onboarding | Example portal scanner configuration (copy to `portals.yml` to activate) |
| `states.yml` | `verify-pipeline.mjs`, `normalize-statuses.mjs`, `merge-tracker.mjs` | Canonical application states and their aliases |

### cv-template.html

The HTML template rendered by Playwright into PDF. Uses placeholder tokens (`{{NAME}}`, `{{SUMMARY_TEXT}}`, `{{EXPERIENCE}}`, etc.) that the PDF pipeline fills at generation time.

**Design:** Space Grotesk headings + DM Sans body, single-column ATS-safe layout, self-hosted fonts from `fonts/`.

**Customization:** Edit this file to change colors, spacing, or section order. The placeholder tokens are documented in `batch/batch-prompt.md` under "Template placeholders."

### cv-template-executive-clean.html

An alternate single-column template with stronger visual hierarchy: prominent name, lighter contact line, consistent section dividers, restrained typography, and compact recruiter-friendly scanning. Select it by setting `documents.resume_template: executive-clean` in `config/profile.yml`.

### presentation-role-deck-template.html

A reusable static HTML slide deck derived from the current business-operations and partner-strategy deck variants. Uses placeholder tokens such as `{{TARGET_FUNCTION}}`, `{{OPERATING_PROBLEM_HEADLINE}}`, and `{{SLIDE10_TITLE}}` so a new role-specific deck can be created by editing copy rather than redesigning slides.

### presentation-role-deck-template.md

Companion guide for the deck template. Explains which slides should stay stable, which slides should be rewritten for each role family, and how to adapt the deck for business-operations versus partner-strategy narratives.

### portals.example.yml

Pre-configured portal scanner with 45+ tracked companies and search queries. Contains title filters, company career page URLs, Greenhouse API endpoints, and WebSearch queries.

**To activate:** Copy to project root as `portals.yml` and customize `title_filter.positive` keywords for your target roles. Add or remove companies as needed.

### states.yml

Defines the 8 canonical application states (`Evaluated`, `Applied`, `Responded`, `Interview`, `Offer`, `Rejected`, `Discarded`, `SKIP`) with aliases for common variants. All pipeline scripts validate statuses against this file.

**Do not rename states** -- the dashboard and all scripts depend on these exact IDs. You can add aliases if you encounter new variants that should map to an existing state.
