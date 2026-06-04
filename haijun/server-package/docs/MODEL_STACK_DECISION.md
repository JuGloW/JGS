# Haijun Model Stack Decision

This document records the first model stack decision for Haijun. The stack is
role-based. A model is selected only when it owns a specific capability.

## Decision Summary

| Role | Decision | Reason |
| --- | --- | --- |
| Primary agentic coding brain | Qwen3-Coder-Next / Qwen3-Coder family | Best first target for CLI-like coding agent behavior and executable task loops. |
| Large server coding teacher | Qwen3-Coder-480B-A35B-Instruct | Use as teacher/evaluator on GPU or API-scale server when budget allows. |
| Comparative code teacher | DeepSeek-Coder-V2 family | Use to compare code repair and conversion behavior, not as duplicate runtime. |
| Deep architecture reasoning | Reasoning model family selected after JGS eval | Needed for JCH/HCB/JUROX design decisions; do not hard-lock before tests. |
| Retrieval memory | BGE-M3 first baseline, plus code embedding candidate | Multilingual, dense/sparse/multi-vector retrieval for JGS docs and memory. |
| Multimodal perception | Qwen Omni family first candidate | Image/audio/video/document understanding for diagrams, screenshots, docs, and media. |
| Speech capture | Whisper baseline | Mature multilingual ASR for voice notes and task capture. |
| Security layer | Deterministic scanners plus model review | Semgrep, CodeQL, Bandit, gosec, njsscan, Snyk Code or similar tools should guard model output. |
| CLI ecosystem study | Aider, Continue, Tabby, Ollama, Codex CLI, Qwen Code | Study patterns for Haijun CLI/JCLI behavior, not all as runtime dependencies. |

## Why This Stack

Haijun needs different intelligence channels:

- coding agent;
- compiler and OS reasoning;
- Converhai conversion;
- retrieval memory;
- multimodal understanding;
- security and policy guard;
- platform-specific runtime.

One model rarely owns all of these. Haijun should first run as a routed
specialist system, then distill the best behavior into a Haijun core.

## Model Use Rules

- Do not download models to the local control computer.
- Do not keep duplicate specialists with the same role.
- Do not merge model/adapters without JGS-specific evaluation.
- Use strong models as teachers when they are too large for routine runtime.
- Promote a model only after it passes Haicode, JCH, HCB, JDB, JUROX, CLI, and
  security tests.

## Initial Promotion Targets

1. Qwen3-Coder-Next as first agentic coding candidate.
2. BGE-M3 as first retrieval baseline.
3. Whisper as first speech baseline.
4. Qwen Omni as first multimodal baseline.
5. Deterministic security tools before model-only security decisions.

## Open Decisions

- Final reasoning model for OS/compiler architecture.
- Final code embedding model for source-level Converhai retrieval.
- Final small runtime model for PC/laptop/phone mode.
- Whether Qwen3-Coder-480B is affordable as teacher-only or runtime server model.

