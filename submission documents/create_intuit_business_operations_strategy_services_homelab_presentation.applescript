on joinList(theList, delim)
    set {oldTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, delim}
    set joined to theList as text
    set AppleScript's text item delimiters to oldTID
    return joined
end joinList

set outputPath to POSIX file "/Users/aaliyathewarrior/Organized/Repositories/career-ops/submission documents/Aaliya_Bashir_Intuit_Business_Operations_Strategy_Services_Homelab.pptx"
using terms from application "Microsoft PowerPoint"
tell application id "com.microsoft.Powerpoint"
    activate
    set newPresentation to make new presentation
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Private AI Systems Sandbox"
    set subtitleLine to "A business-operations case study in AI-enabled execution, observability, and operating-system design"
    set bulletItems to {"Demonstrates how I turn ambiguity into a structured operating system", "Shows AI-era fluency across routing, orchestration, observability, and recovery", "Connects technical execution with business operations discipline", "Supports Intuit's direction toward AI-enabled services and scalable execution"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Why this matters for Services strategy"
    set subtitleLine to "AI-native growth depends on the operating system behind the product"
    set bulletItems to {"AI-enabled services need more than product ambition; they need execution infrastructure", "Growth priorities move faster when teams can see dependencies, failure modes, and health signals", "Strong operators bridge Product, Engineering, and GTM through shared operating logic", "This project shows how I build that logic in practice"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Problem statement"
    set subtitleLine to "The prompt is only one layer in a broader execution environment"
    set bulletItems to {"AI workflows rely on routing, runtime logic, services, tools, and monitoring", "Weak visibility makes prioritization and troubleshooting harder", "Poor orchestration slows execution and obscures accountability", "Better system design leads to better business and technical decisions"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "What the sandbox demonstrates"
    set subtitleLine to "A controlled environment for studying execution quality and readiness"
    set bulletItems to {"Multi-step agent workflow execution", "Model routing through a gateway abstraction", "Service orchestration across runtime and execution layers", "Observability through logs, health checks, and status visibility", "Deployment-readiness testing and repeatable troubleshooting patterns"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Operating system architecture"
    set subtitleLine to "A privacy-safe model for how AI-enabled services can stay understandable"
    set bulletItems to {"Requests enter a structured runtime instead of an opaque model call", "Routing logic creates flexibility and cleaner abstraction", "Execution layers coordinate tools, APIs, and workflow steps", "Observability layers provide the signals needed for management and diagnosis", "Validation controls support readiness reviews and issue recovery"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Workflow example"
    set subtitleLine to "How a request becomes a traceable, diagnosable business process"
    set bulletItems to {"A request is interpreted into a structured sequence of work", "The system determines where reasoning and execution should happen", "Model and tool activity flow through the appropriate routing layers", "Outputs return with validation signals and runtime context", "Teams can review the workflow for accountability and improvement"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Orchestration and prioritization lessons"
    set subtitleLine to "Coordination quality shapes speed, reliability, and decision confidence"
    set bulletItems to {"Routing choices affect reliability, latency, and operational burden", "Separation of concerns improves maintainability and team coordination", "Explicit orchestration reduces rework and debugging ambiguity", "Better abstractions create stronger foundations for growth priorities"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Troubleshooting and readiness"
    set subtitleLine to "Build systems that remain understandable when something goes wrong"
    set bulletItems to {"Validated health and responsiveness through structured checks", "Used runtime logs and signals to identify failure sources", "Studied how dependency issues affect end-to-end workflow behavior", "Documented repeatable recovery patterns to improve future execution", "Treated readiness as a measurable operating capability"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Role-aligned capabilities"
    set subtitleLine to "Evidence that I can bridge AI strategy, execution systems, and business operations"
    set bulletItems to {"Operating-system thinking for complex, AI-enabled businesses", "Executive insight through visibility, traceability, and structured signals", "Cross-functional fluency across technical and business execution layers", "Change-agent mindset grounded in repeatability and operational discipline", "Clear communication of technical complexity in employer-relevant language"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Closing takeaway"
    set subtitleLine to "A strong proof point for building the operating system behind AI-enabled growth"
    set bulletItems to {"AI strategy creates value only when the execution system is visible and disciplined", "This project shows how I build clarity across routing, orchestration, and readiness", "It demonstrates practical judgment around prioritization, reliability, and recovery", "It reflects the same mindset needed to run an effective Services operating system", "For this Intuit role, it is a meaningful example of turning AI ambition into operational reality"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    save newPresentation in outputPath
    close newPresentation saving yes
end tell
end using terms from
