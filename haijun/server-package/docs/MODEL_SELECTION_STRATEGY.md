# Model Selection Strategy

Haijun must not be built by randomly stacking models that do the same thing.
Each selected model must have a specific role in the Haijun body.

## Principle

Use mature models as teachers, specialists, or runtime modules. Then build
Haijun-specific behavior through:

- routing;
- retrieval;
- LoRA/QLoRA adapters;
- task-specific fine-tuning;
- evaluation;
- distillation into a smaller Haijun core;
- adapter merging only when tests prove compatibility.

The goal is not to keep many duplicated models forever. The goal is to collect
specialized strengths, identify gaps, and gradually compress the useful behavior
into Haijun.

## Required Capability Roles

| Role | Purpose |
| --- | --- |
| Core Developer Brain | JGS coding, architecture, debugging, repair planning. |
| Agentic CLI Model | Tool use, terminal workflows, long task loops, error recovery. |
| Reasoning Model | Deep planning, OS/compiler design, complex tradeoffs. |
| Security Model | Secret detection, risky code review, infra/security posture. |
| Multilingual/Knowledge Model | Indonesian/English technical memory and broad explanation. |
| Embedding Model | Retrieval over JGS source, docs, logs, and memory. |
| Vision Model | Diagrams, screenshots, UI, images, visual debugging. |
| Audio Model | Speech-to-text, voice notes, meeting/task capture. |
| Multimodal Model | Text, image, audio, video understanding for broader Haijun inputs. |
| Small Local Runtime | Lightweight PC/laptop/phone usage when full Haijun is unavailable. |

## Architecture Stages

### Stage 1: Specialist Stack

Use several models with clear roles. A router decides which model or adapter is
called for each task. This stage is easiest to debug.

### Stage 2: Haijun Adapters

Train Haijun adapters on JGS behavior, coding discipline, security policy,
Haicode/JCH/HCB/JUROX knowledge, and Codex partnership.

### Stage 3: Distilled Haijun Core

Use outputs from the best specialist stack to train a stronger Haijun core model
that behaves consistently without needing every specialist for every task.

### Stage 4: Platform Builds

Prepare different runtime profiles:

- server/GPU full mode;
- website/API mode;
- CLI developer mode;
- laptop/PC reduced mode;
- phone lightweight mode;
- future JUROX-native mode.

## Do Not Do

- Do not download models to the local control computer.
- Do not train on secrets.
- Do not keep two models if one role is already covered better.
- Do not merge adapters without evaluation.
- Do not assume a larger model is better for every role.
- Do not choose a model without checking license, context length, VRAM, and tool
  compatibility.

