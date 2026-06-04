# JGS

JGS means **JuGloW Global System**. It is the central index and registry for the
JuGloW ecosystem: Haicode, the hai* language family, JCH, HCB ABI, JUROX OS,
Haijun AI, and future JGS packages.

JGS is a meta-programming language framework that maps programming languages
into the Haicode family. The Haicode language family (`hai*`) provides
specialized implementations for each programming paradigm, with `haic*` as the
foundational bridge for C/C++ and Unix/Linux system concepts.

## Repository Role

This repository is the **JGS root registry**, not a monolithic source package.
Each major project must live in its own repository or installable package. JGS
keeps the public map, links, status, standards, and installation index.

Large source families such as Haicode, JCH, JUROX, Haijun, and future `hai*`
packages should be downloaded or installed separately according to need.

## Initial Registry Structure

- `docs/`: ecosystem maps, roadmap, governance, and cloud/DNS planning.
- `registry/`: package registry, repository links, and install index.
- `haicode/`: Haicode and Converhai registry entry.
- `haijun/`: Haijun AI registry entry.
- `jurox/`: JUROX OS registry entry.
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
- Do not turn this repository into one global source bundle.
- Do not store large archives or separate package sources here.
- Keep GPU training artifacts on the GPU server or approved storage.
- Use this repository as the public index and planning source for JGS.
