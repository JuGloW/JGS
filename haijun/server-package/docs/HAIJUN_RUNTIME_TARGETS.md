# Haijun Runtime Targets

Haijun should be usable across platforms, but not every platform should run the
same model size.

## Full Server Mode

Runs on rented GPU or dedicated server.

- strongest model stack;
- training;
- adapter export;
- long-context analysis;
- heavy multimodal processing.

## Website/API Mode

Runs as a web service.

- user authentication;
- project memory access;
- model router;
- logs and approval gates;
- no public leak of private JGS data.

## CLI Developer Mode

Runs like a developer agent in terminal.

- inspect files;
- run approved commands;
- create patches;
- analyze errors;
- coordinate with Codex-style workflows.

## PC/Laptop Mode

Lightweight local client only.

- no heavy model download by default;
- connects to server/API;
- optional tiny local model only if explicitly approved.

## Phone Mode

Mobile client.

- voice/text input;
- task review;
- approval gates;
- lightweight summaries;
- server-backed heavy reasoning.

## JUROX-Native Mode

Future mode when JUROX OS exists.

- Haicode-native integration;
- JCH/HCB-aware tooling;
- system-level developer agent;
- local policy and security hooks.

