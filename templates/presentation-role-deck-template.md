# Role Deck Template

Reusable deck template derived from the two deployed variants:

- `Business Operations & Strategy - Services`
- `Commercial Partner Strategy & Operations`

Use the HTML master file:

- `templates/presentation-role-deck-template.html`

The template is intentionally content-tokenized. Edit the `{{TOKENS}}` directly or use them as find/replace targets in another workflow.

## Core Rule

Do not rebuild the deck from scratch for each role.

Keep the structure stable and only change:

1. the operating problem
2. the translation from system behavior to business value
3. the workflow example emphasis
4. the closing relevance to the target role

## Slide Map

1. `Title`
Purpose:
Lead with the role framing, not with “homelab” language.

2. `Role Problem`
Purpose:
Describe the operating failure mode the employer cares about.

3. `System Translation`
Purpose:
Translate the build into the type of operating system the role needs.

4. `Architecture`
Purpose:
Show the shape of the system without overloading the audience with implementation detail.

5. `Ownership`
Purpose:
Prove clear routing, decision rights, escalation logic, and execution discipline.

6. `Workflow Trace`
Purpose:
Show one end-to-end example that mirrors the target role’s work.

7. `Reliability`
Purpose:
Show observability, watchdogs, health logic, and resilience.

8. `Impact`
Purpose:
Translate technical mechanisms into business outcomes.

9. `Capability Translation`
Purpose:
State what this proves about Aaliya as an operator.

10. `Employer Relevance`
Purpose:
Tie the system directly to the target company and role.

11. `Resume Appendix`
Purpose:
Optional. Add a resume snapshot when the deck is being used in application or intro contexts.

12. `Backup Artifact`
Purpose:
Optional. Use for a second appendix artifact, not for a random screenshot.

## What Changes By Role

### Business Operations / Strategy roles

Push hardest on:

- operating cadence
- visibility
- accountability
- issue diagnosis
- repeatable execution
- escalation discipline
- turning ambiguity into systems

Best workflow examples:

- Shopify blocker detection
- watchdog / cron remediation
- intake to routed action

Best closing language:

- execution quality
- readiness
- resilience
- signal visibility
- strategy to execution

### Partner Strategy / GTM roles

Push hardest on:

- fragmented partner signals
- pipeline visibility
- adoption blockers
- GTM operating rhythm
- measurable partner outcomes
- partner ownership and escalation rules

Best workflow examples:

- partner-signal routing
- campaign / pipeline exception handling
- cross-functional revenue rhythm

Best closing language:

- ecosystem leverage
- co-sell clarity
- pipeline conversion
- adoption signal visibility
- GTM systems

## What Stays Stable

Usually keep these slides mostly intact:

- `Slide 4` architecture
- `Slide 7` observability
- `Slide 11` resume appendix structure
- `Slide 12` backup artifact structure

These are the highest-change slides:

- `Slide 1`
- `Slide 2`
- `Slide 3`
- `Slide 6`
- `Slide 8`
- `Slide 10`

## Editing Rules

- Keep paragraphs short. If a slide becomes a wall of text, rewrite it.
- Prefer 2-4 tight cards over one dense paragraph.
- Remove raw debug values unless they materially strengthen credibility.
- If a slide is for candidacy translation, first person is acceptable.
- If a slide is for system explanation, stay in neutral language.
- Business impact should come before technical mechanics for executive audiences.

## Suggested Token Fill Order

When adapting the deck for a new role, fill tokens in this order:

1. `TARGET_COMPANY`
2. `TARGET_FUNCTION`
3. `POSITIONING_LINE`
4. `OPERATING_PROBLEM_HEADLINE`
5. `PROBLEM_SHIFT_LINE`
6. `SLIDE3_*`
7. `SLIDE6_*`
8. `SLIDE8_*`
9. `CAP_*`
10. `SLIDE10_*`

## Recommended Workflow

1. Copy `templates/presentation-role-deck-template.html`
2. Rename it for the target role
3. Replace the top-level role tokens first
4. Rewrite slides `2`, `3`, `6`, `8`, and `10`
5. Add appendix assets last
6. Publish the edited HTML to Vercel if needed

## Starting Token Examples

### Business Operations / Strategy

- `TARGET_FUNCTION` -> `Business Operations & Strategy`
- `POSITIONING_LINE` -> `AI-Enabled Operating Systems`
- `PROBLEM_SHIFT_LINE` -> `from AI assistance to operational follow-through`

### Partner Strategy / GTM

- `TARGET_FUNCTION` -> `Commercial Partner Strategy & Operations`
- `POSITIONING_LINE` -> `GTM Systems & Revenue Operations`
- `PROBLEM_SHIFT_LINE` -> `from partner activity to partner operating leverage`
