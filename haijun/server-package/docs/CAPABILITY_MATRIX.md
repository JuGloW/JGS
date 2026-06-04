# Capability Matrix

This matrix defines what kind of model Haijun needs for each capability. Model
names are candidates, not final commitments.

## Candidate Roles

| Capability | Candidate Family | Why It Fits | Notes |
| --- | --- | --- | --- |
| Agentic coding and CLI | Qwen3-Coder-Next / Qwen Coder family | Designed for coding agents and executable task training. | Strong candidate for Haijun developer brain. |
| General coding and code repair | DeepSeek-Coder family / Qwen Coder family | Strong code generation and debugging history. | Must evaluate security and provider behavior carefully. |
| Deep reasoning | Qwen reasoning models / DeepSeek reasoning models / other open reasoning models | Useful for OS, compiler, ABI, and architecture planning. | Reasoning model may plan; coding model may implement. |
| Multimodal perception | Qwen Omni family / Llama multimodal family | Text, image, audio, and video understanding. | Useful for screenshots, diagrams, UI, and media tasks. |
| Speech capture | Whisper or newer ASR model | Mature multilingual speech recognition. | Use for voice notes and meeting capture. |
| Vision-language retrieval | CLIP-like or newer vision embedding models | Maps images and text into shared retrieval space. | Useful for diagrams/screenshots/assets. |
| Text retrieval | Dedicated embedding model | Indexes JGS source, docs, logs, memory. | Must be small, fast, and high quality. |
| Lightweight local mode | Small instruct/code model | Runs on PC/laptop/phone when full server is unavailable. | Must be optional and tiny; no local heavyweight model storage. |
| Security review | Code/security-tuned model plus rules | Reviews risky code, secrets, infra config. | Must be paired with deterministic scanners. |

## Role Separation

Haijun should separate:

- planner;
- coder;
- reviewer;
- security checker;
- retriever;
- multimodal interpreter;
- final response composer.

Some roles may use the same base model if it wins evaluation, but the selection
must be evidence-based.

## Evaluation Before Promotion

Every candidate must pass:

- JGS coding tasks;
- CLI/tool-use tasks;
- Haicode/JCH/HCB/JUROX Q&A;
- security refusal and secret handling tests;
- Indonesian technical explanation;
- long-context project recall through retrieval;
- cost and speed checks.

