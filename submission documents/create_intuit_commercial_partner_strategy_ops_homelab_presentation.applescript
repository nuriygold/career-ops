on joinList(theList, delim)
    set {oldTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, delim}
    set joined to theList as text
    set AppleScript's text item delimiters to oldTID
    return joined
end joinList

set outputPath to POSIX file "/Users/aaliyathewarrior/Organized/Repositories/career-ops/submission documents/Aaliya_Bashir_Intuit_Commercial_Partner_Strategy_Ops_Homelab.pptx"
using terms from application "Microsoft PowerPoint"
tell application id "com.microsoft.Powerpoint"
    activate
    set newPresentation to make new presentation
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Private AI Systems Sandbox"
    set subtitleLine to "A systems-thinking proof point for partner strategy, operating cadence, and executive-ready technical translation"
    set bulletItems to {"Shows how I structure complex systems into clear operating models", "Demonstrates executive-ready translation of technical ambiguity into practical decisions", "Highlights governance, visibility, and repeatable execution rather than deep engineering detail", "Best used as a supporting proof of AI-era operating judgment"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Why this matters for partner strategy"
    set subtitleLine to "Strong partner ecosystems need operating discipline behind the growth story"
    set bulletItems to {"Revenue partnerships need more than strategy; they need clear operating rhythms and accountability", "Complex execution benefits from visibility into dependencies, bottlenecks, and recovery paths", "The same systems mindset applies to partner planning, KPI reviews, and cross-functional coordination", "This project shows how I build clarity before scale"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Core problem explored"
    set subtitleLine to "High-value initiatives break down when the operating model is unclear"
    set bulletItems to {"AI workflows fail when routing, ownership, and visibility are weak", "Partner motions fail for similar reasons: unclear handoffs, poor signal quality, limited accountability", "Strong execution requires understanding where friction lives", "Better system design supports better strategic decisions"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "What the sandbox demonstrates"
    set subtitleLine to "Structured thinking across orchestration, visibility, and readiness"
    set bulletItems to {"Multi-step workflow design with clear dependencies", "Routing logic that supports consistent execution choices", "Runtime visibility through health checks, logs, and status signals", "Troubleshooting discipline focused on recovery and repeatability", "Executive-friendly framing of technical operating risk"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Operating model view"
    set subtitleLine to "A privacy-safe example of how I organize complexity into workable layers"
    set bulletItems to {"Structured intake instead of ad hoc requests", "Clear routing and decision logic rather than opaque execution", "Defined execution layers with separated responsibilities", "Visibility mechanisms for monitoring health and issues", "Administrative controls for validation and course correction"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Workflow example"
    set subtitleLine to "Turning an ambiguous request into a traceable execution path"
    set bulletItems to {"Request is translated into a defined task sequence", "Appropriate path is chosen based on the nature of the work", "Execution happens through coordinated layers rather than one-off improvisation", "Output returns with validation context and traceability", "Review is possible because the workflow is understandable end to end"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Relevance to commercial partner ops"
    set subtitleLine to "The same mindset supports KPI cadence, cross-functional accountability, and scale"
    set bulletItems to {"Operating cadence depends on consistent definitions, handoffs, and signals", "Executive reporting is stronger when systems are designed for visibility", "Cross-functional partner work benefits from explicit ownership and repeatable reviews", "Good abstraction reduces confusion as the business scales"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Troubleshooting and recovery"
    set subtitleLine to "Reliable execution depends on knowing how the system behaves under stress"
    set bulletItems to {"Used structured checks to validate readiness and responsiveness", "Diagnosed issues through logs and runtime signals", "Studied the impact of dependency failure on overall workflow performance", "Documented repeatable recovery patterns to reduce future friction", "Framed resilience as an operating capability, not just a technical detail"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Capabilities this signals"
    set subtitleLine to "Business-facing systems judgment with technical fluency"
    set bulletItems to {"Systems thinking for complex operating environments", "KPI and reporting instincts grounded in visibility and traceability", "Cross-functional coordination mindset across ambiguous dependencies", "Executive communication that translates technical complexity into business implications", "AI fluency that complements, rather than replaces, domain execution skills"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Closing takeaway"
    set subtitleLine to "A secondary proof point that I can build the operating system behind the strategy"
    set bulletItems to {"Growth strategy works best when execution systems are explicit and measurable", "This project shows how I translate ambiguity into workable operating models", "It reflects judgment around visibility, coordination, and recovery", "It supports my broader story around executive insight and cross-functional execution", "For partner strategy, it is evidence of operating rigor in an AI-shaped business environment"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    save newPresentation in outputPath
    close newPresentation saving yes
end tell
end using terms from
