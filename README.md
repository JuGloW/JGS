# JGS

JGS means **JuGloW Global System**. It is the central repository for the
JuGloW ecosystem: Haicode, the hai* language family, JCH, HCB ABI, JUROX OS,
and Haijun AI.

JGS is a meta-programming language framework that maps programming languages
into the Haicode family. The Haicode language family (`hai*`) provides
specialized implementations for each programming paradigm, with `haic*` as the
foundational bridge for C/C++ and Unix/Linux system concepts.

## Initial Structure

- `docs/`: ecosystem maps, roadmap, governance, and cloud/DNS planning.
- `haicode/`: Haicode and Converhai planning.
- `haijun/`: Haijun AI integration notes.
- `jurox/`: JUROX OS architecture direction.
- `infrastructure/`: domain, DNS, cloud, GPU, storage, and database planning.
- `datasets/`: dataset governance, curation, and safety rules.
- `models/`: model selection and server-only model policy.
- `security/`: secrets, access, and owner-protection rules.

## Current Domain

- Primary domain: `juglow.my.id`
- Registrar: DomaiNesia
- DNS provider: Cloudflare
- DNS status: active/protected

## Repository Rules

- Do not commit model weights.
- Do not commit `.env`, tokens, SSH keys, passwords, or private company data.
- Do not store large archives here.
- Keep GPU training artifacts on the GPU server or approved storage.
- Use this repository as the public structure and planning source for JGS.
