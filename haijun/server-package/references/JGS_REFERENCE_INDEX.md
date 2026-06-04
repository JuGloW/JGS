# JGS Reference Index

This index is Haijun's first curated map of small reference files. It connects
local reference files to the skills Haijun must learn.

## Core Categories

| Category | Purpose | Primary Files |
| --- | --- | --- |
| Haicode token system | Teach Haijun the breadth of Haicode syntax and absorbed language concepts. | `references/copied-key-files/haicode_list_key_tok.txt` |
| JCH Makefile/config | Teach JCH build identity, HAICC flags, libjch, HCRT, and GNU-to-JGS migration patterns. | `references/copied-key-files/libjch_Makefile.in`, `references/copied-key-files/win32_haicconfig.h` |
| Syscall and OS tables | Teach JUROX/JDB/Linux/Unix syscall awareness and OS interface mapping. | `references/copied-key-files/syscall_32.tbl`, `references/copied-key-files/syscall_64.tbl`, `references/copied-key-files/syscalls.master` |
| Instruction/binary reference | Teach JDB low-level CPU, object, executable, and ABI inspection foundations. | `references/copied-key-files/haicode_data_instruction_set.txt` |
| Portable AI runtime | Teach portable USB/SSD/HDD architecture without installing it locally. | `references/portable-ai/PortableLM_README.md`, `references/portable-ai/PortableLM_models.json`, `references/portable-ai/PortableLM_chat_server.py`, `references/portable-ai/Portable-AI-USB_README.md`, `references/portable-ai/Portable-AI-USB_install-core.ps1` |
| Download zip map | Teach which external source archives are worth deeper extraction later. | `references/zip-summaries/download_zip_key_entries.md` |
| JGS doctrine | Teach Haijun identity, Converhai, JDB, JUROX, security, model stack, and runtime policy. | `docs/*.md` |

## Haicode Token List

File:

- `references/copied-key-files/haicode_list_key_tok.txt`

Use for:

- Converhai syntax mapping;
- `hai*` family expansion;
- source-language keyword matching;
- HCB token/function awareness;
- AI/GPU/framework token awareness.

Training value:

- Haijun learns that Haicode is intentionally broad and absorbs concepts from
  C/C++, Python, JS, SQL, CUDA/GPU, AI/ML, HCB, and modern frameworks.

## JCH Makefile And Config

Files:

- `references/copied-key-files/libjch_Makefile.in`
- `references/copied-key-files/win32_haicconfig.h`

Use for:

- GNU Make to JGS build migration;
- HAICC/HAICFLAGS/HAICPPFLAGS understanding;
- libjch build process;
- bootstrap alias logic;
- HCRT/JHCRT startup object mapping;
- JCH runtime library identity.

Training value:

- Haijun learns that JGS terms such as `HAICC`, `HCRT`, `JHCRT0`, `libjch`,
  and `HAICPPFLAGS` are toolchain signals, not random names.

## Syscall Tables

Files:

- `references/copied-key-files/syscall_32.tbl`
- `references/copied-key-files/syscall_64.tbl`
- `references/copied-key-files/syscalls.master`

Use for:

- Unix/Linux system call literacy;
- JUROX OS planning;
- JDB runtime inspection;
- Converhai mapping of OS-level behavior;
- HCB ABI/system boundary thinking.

Training value:

- Haijun learns that OS work must preserve syscall behavior and system
  contracts, not only source syntax.

## Instruction And Binary Reference

File:

- `references/copied-key-files/haicode_data_instruction_set.txt`

Use for:

- JDB design;
- object/executable inspection;
- binary-level debugging;
- CPU instruction awareness;
- JCH codegen and HCB ABI validation.

Training value:

- Haijun learns that low-level instruction references are evidence sources for
  debugger and ABI reasoning, but must be validated against official manuals
  when precision matters.

## Portable AI Runtime

Files:

- `references/portable-ai/PortableLM_README.md`
- `references/portable-ai/PortableLM_models.json`
- `references/portable-ai/PortableLM_chat_server.py`
- `references/portable-ai/Portable-AI-USB_README.md`
- `references/portable-ai/Portable-AI-USB_install-core.ps1`

Use for:

- portable Haijun runtime design;
- USB/SSD/HDD install model;
- local chat server and UI pattern;
- GGUF target-drive model catalog;
- server-only and target-device-only download policy.

Training value:

- Haijun learns portable architecture without adopting unsafe uncensored prompt
  policies or installing heavy models locally.

## GNU To JGS Terms

Primary files:

- `memory/jgs_legacy_terms_seed.txt`
- `docs/GNU_TO_JGS_MIGRATION_PATTERNS.md`

Use for:

- identifying legacy migration signals;
- mapping GNU/C/C++ toolchain terms into JGS identity;
- building future Converhai dictionaries;
- finding relevant files in source archives.

Training value:

- Haijun learns that names like `HAICC`, `HCRT`, `JCH`, `JLIB`, `JPATH`,
  `haicpp`, `__JGS__`, and `HCB` are anchors in the JGS migration map.

## Doctrine Documents

Core doctrine files:

- `docs/CONVERHAI_DOCTRINE.md`
- `docs/HAICODE_PURITY.md`
- `docs/JDB_DEBUGGER_VISION.md`
- `docs/JUROX_OS_VISION.md`
- `docs/JGS_WORLDVIEW.md`
- `docs/SECURITY_MODEL.md`
- `docs/MODEL_STACK_DECISION.md`
- `docs/CONTROL_ONLY_POLICY.md`

Use for:

- identity training;
- policy training;
- evaluation prompt creation;
- future retrieval memory.

## Next Indexing Steps

1. Build a symbol dictionary from `jgs_legacy_terms_seed.txt`.
2. Build token categories from `haicode_list_key_tok.txt`.
3. Build a Converhai mapping dataset from real JCH/JGS files.
4. Build JDB eval prompts from syscall and instruction references.
5. Keep all model weights and large archives outside this local workspace.

