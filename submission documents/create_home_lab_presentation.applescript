on joinList(theList, delim)
    set {oldTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, delim}
    set joined to theList as text
    set AppleScript's text item delimiters to oldTID
    return joined
end joinList

set outputPath to POSIX file "/Users/aaliyathewarrior/Organized/Repositories/career-ops/submission documents/home lab presentation.pptx"
using terms from application "Microsoft PowerPoint"
tell application id "com.microsoft.Powerpoint"
    activate
    set newPresentation to make new presentation
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Private AI Systems Sandbox"
    set subtitleLine to "A privacy-safe portfolio project for agentic workflow infrastructure, model routing, service orchestration, and deployment-readiness testing"
    set bulletItems to {"Controlled environment for testing AI system behavior beyond the prompt layer", "Focused on agent workflows, routing, observability, troubleshooting, and readiness validation", "Built as a practical way to study complexity through hands-on experimentation", "Demonstrates both technical execution and systems-thinking discipline"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Why this project matters"
    set subtitleLine to "AI delivery depends on system design, not just model output"
    set bulletItems to {"AI initiatives often focus on prompts and models, but execution depends on the surrounding system", "Workflow reliability requires routing, tool execution, observability, and recovery paths", "Teams need people who can connect product intent to runtime behavior", "This project reflects a mindset of building the right foundation for future effectiveness"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Problem: AI products need more than prompts"
    set subtitleLine to "The prompt is only one layer in a larger execution system"
    set bulletItems to {"AI workflows depend on routing, runtime logic, tools, services, and monitoring", "Failures often occur outside the prompt itself", "Weak visibility makes issues harder to diagnose and fix", "Better operating models lead to better technical and product decisions"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "What the sandbox demonstrates"
    set subtitleLine to "A controlled environment for studying AI system behavior"
    set bulletItems to {"Multi-step agent workflow execution", "Model routing through a gateway layer", "Service orchestration across execution paths", "Health checks, logs, and runtime visibility", "Deployment-readiness testing in a private sandbox"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Architecture overview"
    set subtitleLine to "A generalized, privacy-safe AI systems operating model"
    set bulletItems to {"User requests enter a structured runtime rather than a direct model call", "A model gateway handles routing and abstraction", "An execution layer supports tools, APIs, scripts, and workflows", "Observability layers provide logs, health checks, and status visibility", "Administrative controls support validation and troubleshooting"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Agent workflow demo"
    set subtitleLine to "How a request moves through the sandbox"
    set bulletItems to {"A user request is interpreted into a structured task sequence", "The runtime determines where reasoning and execution should occur", "The system routes model activity and tool use through the appropriate layers", "Outputs are returned with validation signals and runtime context", "The workflow can be reviewed for traceability and failure handling"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Model routing and service orchestration"
    set subtitleLine to "Coordinating AI requests across runtime and execution layers"
    set bulletItems to {"Requests flow through an abstraction layer rather than hard-coded model paths", "Service orchestration coordinates multiple execution dependencies", "Separation of concerns improves maintainability and flexibility", "Routing choices shape reliability, latency, and debugging effort"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Troubleshooting and deployment-readiness"
    set subtitleLine to "Testing recovery, visibility, and operational clarity"
    set bulletItems to {"Validated service health and responsiveness through structured checks", "Used logs and runtime signals to diagnose issues", "Studied how failures in dependencies or routing affect workflow behavior", "Treated the environment as a prototype for production-style readiness testing", "Documented repeatable recovery and validation patterns"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Skills demonstrated"
    set subtitleLine to "Technical execution paired with builder mindset and operational judgment"
    set bulletItems to {"AI systems thinking across routing, runtime, execution, and observability", "Technical program instincts around dependencies, failure modes, and readiness", "Builder mindset grounded in iteration, optimization, and structured problem-solving", "Product and platform judgment focused on repeatability and operating discipline", "Clear communication through sanitized, business-relevant technical framing"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    set newSlide to make new slide at end of slides of newPresentation with properties {layout:ppLayoutText}
    set content of text range of text frame of item 1 of shapes of newSlide to "Business relevance and closing summary"
    set subtitleLine to "Evidence of how I bridge AI strategy and technical execution"
    set bulletItems to {"AI initiatives need leaders who understand both model behavior and system behavior", "This project demonstrates how I translate ambiguity into structured operating models", "It shows practical thinking around reliability, observability, and execution quality", "It reflects a willingness to invest upfront in stronger long-term foundations", "The result is a clearer bridge between AI strategy, delivery, and operational readiness"}
    set slideBody to subtitleLine & return & return & joinList(bulletItems, return)
    set content of text range of text frame of item 2 of shapes of newSlide to slideBody
    save newPresentation in outputPath
    close newPresentation saving yes
end tell
end using terms from