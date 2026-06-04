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

## Registry Files

- `registry/packages.yaml`: source of truth for package/repository targets.
- `registry/install-index.md`: human-readable package index.
- `registry/README.md`: registry rules.

This root repository should remain intentionally small. Detailed docs and source
trees belong in their separate repositories, for example `haijun`, `haicode`,
`jurox`, `jch`, and future `hai*` packages.

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
