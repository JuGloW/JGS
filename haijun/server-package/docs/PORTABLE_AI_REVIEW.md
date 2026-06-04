# Portable AI Review

Haijun should support portable runtime modes, but the portable model choices
must respect Haijun's security and developer-agent mission.

## PortableLM Findings

Local source:

- `D:\READY\DOWNLOAD\PortableLM-main`

Copied references:

- `references/portable-ai/PortableLM_README.md`
- `references/portable-ai/PortableLM_models.json`
- `references/portable-ai/PortableLM_chat_server.py`

Key architecture:

- cross-platform folders for Windows, Linux, Mac, and Android;
- shared model/data folder;
- local chat server on port `3333`;
- Ollama or llama.cpp-style backend;
- optional Stable Diffusion path;
- portable chat data and settings.

PortableLM model catalog includes:

- Gemma 2 2B Abliterated;
- Gemma 4 E4B Ultra Uncensored Heretic;
- Qwen 3.5 9B Uncensored Aggressive;
- NemoMix Unleashed 12B;
- Dolphin 2.9 Llama 3 8B;
- Phi-3.5 Mini 3.8B;
- Qwen2.5 1.5B Instruct for Android;
- SmolLM2 1.7B Uncensored;
- CyberRealistic image model.

## Portable-AI-USB Findings

Local source:

- `D:\READY\DOWNLOAD\Portable-AI-USB-main`

Copied references:

- `references/portable-ai/Portable-AI-USB_README.md`
- `references/portable-ai/Portable-AI-USB_install-core.ps1`

Key architecture:

- USB/SSD/HDD portable setup;
- AnythingLLM UI;
- Ollama model backend;
- Windows/Mac/Linux scripts;
- model folder with GGUF files;
- offline use after setup.

Portable-AI-USB model catalog includes:

- NemoMix Unleashed 12B;
- Dolphin 2.9 Llama 3 8B;
- Mistral 7B Instruct v0.3;
- Qwen 2.5 7B Instruct;
- Llama 3.2 3B Instruct;
- Phi-3.5 Mini 3.8B;
- custom GGUF from Hugging Face.

## Haijun Decision

Portable AI projects are useful as runtime architecture references, especially
for USB/SSD/HDD deployment. However, their uncensored/aggressive prompt presets
must not become Haijun's default personality or security policy.

Recommended Haijun portable direction:

- use standard/safe small instruct models for local lightweight mode;
- use server-backed strong models for serious coding, JDB, Converhai, and JUROX
  work;
- keep local portable mode as client or emergency assistant;
- never download full model weights into the local control workspace;
- download portable GGUF models only to the target USB/SSD/HDD or server.

Candidate portable models from local catalogs:

- `Qwen2.5 1.5B Instruct` for Android/lightweight mode;
- `Phi-3.5 Mini 3.8B` for small reasoning baseline;
- `Qwen 2.5 7B Instruct` for stronger portable multilingual mode;
- `Mistral 7B Instruct v0.3` for general portable baseline.

Rejected as Haijun core defaults:

- aggressive/uncensored presets that instruct the model to ignore legality,
  morality, or safety.

