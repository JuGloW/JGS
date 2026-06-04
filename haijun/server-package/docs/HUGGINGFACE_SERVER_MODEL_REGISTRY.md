# Hugging Face Server Model Registry

Haijun models must be downloaded on the GPU server or target runtime device, not
on the local control computer.

## Confirmed/Recommended Server Candidates

| Role | Model/Family | Source |
| --- | --- | --- |
| Agentic coding brain | `Qwen/Qwen3-Coder-480B-A35B-Instruct`, Qwen3-Coder-Next family | Hugging Face / Qwen technical report |
| Comparative code teacher | `deepseek-ai/DeepSeek-Coder-V2` | GitHub / model release |
| Retrieval baseline | `BAAI/bge-m3` | Hugging Face |
| Speech baseline | Whisper | OpenAI research release |
| Portable standard small model | Qwen2.5 1.5B/7B Instruct GGUF variants | PortableLM/Portable-AI catalogs |
| Portable small reasoning | Phi-3.5 Mini GGUF | PortableLM/Portable-AI catalogs |
| Multimodal candidate | Qwen Omni family | Qwen/Qwen Omni reports |

## Server Download Policy

When the GPU server is ready:

1. select exact model ID and revision;
2. verify license;
3. record VRAM/RAM/disk requirements;
4. download on server only;
5. keep cache on server storage;
6. store local reference metadata only.

## Hugging Face Identity Note

Searches for `JuGloW`, `JGS`, `Haijun`, and `Haicode` did not clearly identify a
public JuGloW-owned Hugging Face organization. A nearby result was
`Junaidi-AI`, but ownership is not assumed. Add the exact Hugging Face URL when
available.

