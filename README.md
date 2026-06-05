# JGS

**JGS** means **JuGloW Global System**.

This repository is the starting document and navigation hub for the whole
JuGloW ecosystem. It explains the system, records the main project links, and
points each part of JGS to its own repository.

JGS is not one giant source bundle. Each major part of the ecosystem lives in a
separate repository so it can be downloaded, installed, developed, and released
independently.

## Main Projects

| Project | Role | Repository |
| --- | --- | --- |
| Haijun | Private AI developer agent for JGS | [JuGloW/Haijun](https://github.com/JuGloW/Haijun) |
| Haicode | Root of the Haicode and `hai*` language family | [JuGloW/Haicode](https://github.com/JuGloW/Haicode) |
| Converhai | Conversion doctrine and tooling into Haicode/hai* | [JuGloW/Converhai](https://github.com/JuGloW/Converhai) |
| JUROX OS | Future OS/runtime direction centered on Haicode | [JuGloW/Jurox](https://github.com/JuGloW/Jurox) |
| JCH | Compiler and toolchain package | [JuGloW/JCH](https://github.com/JuGloW/JCH) |
| HCB ABI | ABI specification and binary compatibility direction | [JuGloW/HCB-ABI](https://github.com/JuGloW/HCB-ABI) |
| JDB | Debugger direction for Haicode/JCH/HCB | [JuGloW/JDB](https://github.com/JuGloW/JDB) |
| Haic | C and Unix/Linux bridge inside Haicode | [JuGloW/Haic](https://github.com/JuGloW/Haic) |
| Haicpp | C++ bridge inside Haicode | [JuGloW/Haicpp](https://github.com/JuGloW/Haicpp) |
| Haipy | Python bridge inside Haicode | [JuGloW/Haipy](https://github.com/JuGloW/Haipy) |
| Haijs | JavaScript bridge inside Haicode | [JuGloW/Haijs](https://github.com/JuGloW/Haijs) |
| Haigo | Go bridge inside Haicode | [JuGloW/Haigo](https://github.com/JuGloW/Haigo) |
| Hairust | Rust bridge inside Haicode | [JuGloW/Hairust](https://github.com/JuGloW/Hairust) |

## Haicode Family Direction

Haicode is the language center of JGS. The `hai*` family will contain many
separate packages, such as `haic`, `haicpp`, `haipy`, `haijs`, `hairust`,
`haigo`, and future members. JGS only points to them; it does not contain all
their source code.

## Domain And DNS

- Primary domain: `juglow.my.id`
- Registrar: DomaiNesia
- DNS provider: Cloudflare
- DNS status: active/protected

Current DNS identity records:

- `jgs.juglow.my.id`
- `haijun.juglow.my.id`
- `api.juglow.my.id`
- `gpu.juglow.my.id`
- `storage.juglow.my.id`

## Local Workspace Shape

The intended local layout is:

```text
D:\JuGloW\JGS
D:\JuGloW\haijun
D:\JuGloW\haicode
D:\JuGloW\converhai
D:\JuGloW\jurox
D:\JuGloW\jch
D:\JuGloW\hcb-abi
D:\JuGloW\jdb
D:\JuGloW\haic
D:\JuGloW\haicpp
```

## Repository Contents

This JGS repository should stay small:

- `README.md`: main ecosystem document and clickable project map.
- `registry/packages.yaml`: structured project link data.
- `registry/install-index.md`: human-readable install/link index.
- `registry/README.md`: registry notes.

## Rules

- Do not store every project source inside JGS.
- Do not commit model weights.
- Do not commit `.env`, tokens, SSH keys, passwords, or private company data.
- Do not store large archives here.
- Use JGS as the central document and link hub for the whole ecosystem.
