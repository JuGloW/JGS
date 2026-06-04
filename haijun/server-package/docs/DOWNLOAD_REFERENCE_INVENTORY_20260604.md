# Download Reference Inventory - 2026-06-04

Source: `D:\READY\DOWNLOAD`

This inventory records important local downloads that can become references for
Haijun. Only key small files should be copied into Haijun. Large archives and
model weights must stay outside the local Haijun workspace unless explicitly
approved.

## High Priority For Haijun

| Area | Local Files/Folders | Why Important |
| --- | --- | --- |
| GNU/C to JGS migration | `gcc-master.zip`, `binutils-gdb-master.zip`, `autoconf-master.zip`, `automake-master.zip`, `gnu-m4-master.zip`, `libtool-master.zip`, `make-4.4.tar.gz` | Converhai, GNU pattern migration, JCH/JDB design. |
| JDB/debug/binary inspection | `binutils-gdb-master.zip`, `ghidra-master.zip`, `Cutter-v2.4.1-Windows-x86_64.zip`, `imhex-1.38.1-Windows-x86_64.msi`, `malcat_win38_lite.zip`, `xed-main.zip`, `capstone-next.zip`, `keystone-master.zip`, `udis86-master.zip`, `minx86dec-master.zip` | Debugger, disassembler, object/executable, HCB ABI, JDB references. |
| OS/JUROX references | `busybox-master.zip`, `qemu-master.zip`, `bash-5.3`, `fish-shell-master.zip`, `zsh-master.zip`, `syscall_32.tbl`, `syscall_64.tbl`, `syscalls.master`, `windows-syscalls-master.zip` | Shell, syscall, portable OS/runtime, JUROX research. |
| Language convergence | `cpython-main.zip`, `go-master.zip`, `rust-main.zip`, `TypeScript-main.zip`, `node-main.zip`, `php-src-master.zip`, `julia-master.zip`, `kotlin-master.zip`, `swift-corelibs-foundation-main.zip`, `freepascal-master.zip`, `r-source-trunk.zip`, `LuaJIT-2.1.zip`, `lua-master.zip`, `pypy-main.zip` | Converhai source-language mapping into `hai*`. |
| AI/model runtime | `transformers-main.zip`, `safetensors-main.zip`, `pytorch-main.zip`, `tensorflow-master.zip`, `jax-main.zip`, `ollama-0.16.3.zip` | Training/runtime/model packaging references. |
| Portable AI | `Portable-AI-USB-main`, `PortableLM-main` | USB/SSD/HDD portable Haijun runtime reference. |
| Haicode/JGS local docs | `Haicode-Merevolusi-Pengembangan-Perangkat.pdf`, `Haicode-Merevolusi-Pengembangan-Perangkat.pptx`, `haicode.jfif` | Public-facing Haicode explanation and identity material. |

## Copied Into Haijun Reference Vault

Copied to `references/copied-key-files`:

- `haicode_list_key_tok.txt`
- `haicode_data_instruction_set.txt`
- `libjch_Makefile.in`
- `win32_haicconfig.h`
- `syscall_32.tbl`
- `syscall_64.tbl`
- `syscalls.master`

Copied to `references/portable-ai`:

- `PortableLM_README.md`
- `PortableLM_models.json`
- `PortableLM_chat_server.py`
- `Portable-AI-USB_README.md`
- `Portable-AI-USB_install-core.ps1`

## Zip Summary

Zip central directory summaries are stored at:

- `references/zip-summaries/download_zip_key_entries.md`

No large archive was extracted.

## Next Extraction Rules

For each large archive, extract only:

- README/LICENSE;
- build config;
- include/interface headers;
- toolchain docs;
- small examples;
- debugger/ABI docs;
- model/runtime manifests.

Do not copy:

- full source trees;
- model weights;
- build outputs;
- generated caches;
- private secrets.

