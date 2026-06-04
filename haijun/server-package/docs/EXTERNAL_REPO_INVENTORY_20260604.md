# External Repo Inventory - 2026-06-04

This is the first lightweight read-only inventory of external JCH/JGS paths
provided by JuGloW.

## Existing Paths

- `D:\READY\jch-master`
- `D:\READY\jch-master\jch\haicc\jch`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\jch-libs`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\jch-libs\libjch\Makefile.in`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\jch-libs\libjch\src`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\os\win32\include`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\os\win32\haicconfig.h`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\os\cygwin\include`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\haic`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\linux\haic`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\os\linux\include`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\os\windows\include`
- `D:\READY\jch-master\jch\haicc\project\JCH-Mv1.0.1\windows\haic`
- `D:\executtools`
- `D:\executtools\JCH-Mv1.0.1`
- `D:\executtools\JCH-Mv1.0.1\haicc\haic`
- `D:\executtools\executconf-v1.0.1`
- `D:\READY\jch-master\jch\haicc\project\autoconf`
- `D:\perakitan\picoc-master\haicode\modul\list_key_tok.txt`
- `D:\perakitan\picoc-master\haicode\Doc\data instruction set.txt`

## Missing At Listed Path

- `D:\READY\DOWNLOAD\linux-6.19.4`
- `D:\READY\DOWNLOAD\llvm-project-main`
- `C:\cygwin64\usr\include\sys`

These may exist under different paths or names.

## Read Findings

### `libjch\Makefile.in`

Observed patterns:

- builds `libjch.a` and `libjch_eh.a`;
- uses `HAICC`, `HAICFLAGS`, `HAICPPFLAGS`;
- defines bootstrap aliases such as `Typedef=typedef`, `Struct=struct`,
  `Return=return`, `If=if`;
- uses `haicode_bootstrap_copy.pl`;
- installs headers and libraries into JCH target/version paths.

Haijun should learn this as an early concrete example of GNU/C build logic
moving toward JGS/Haicode/JCH identity.

### `os\win32\haicconfig.h`

Observed patterns:

- console application support;
- HCRT/HCRT0/HCRTI/HCRTN/HCRTBEGIN/HCRTEND startup object naming;
- `JHCRT0` legacy uppercase-family startup;
- `HAICPPADD`, `HAICPPMDADD`, `DEFLIBS`, `DEFCXXLIBS`;
- links `libjch`, `libjchsoftfloat`, and haic runtime libraries.

Haijun should map this into JGS runtime/startup memory and future JDB/HCB
inspection tasks.

### `list_key_tok.txt`

Observed patterns:

- very broad token list covering C/C++-like syntax, Python-like names,
  JavaScript/SQL/HTML, GPU/CUDA, AI/ML terms, HCB functions, framework names,
  benchmark utilities, and more;
- confirms the Haicode direction of absorbing broad language and tooling
  concepts into a single token family.

This file is important for Converhai and Haicode syntax training.

### `data instruction set.txt`

Observed patterns:

- x86/amd64 instruction reference;
- useful for JDB, ABI, object/executable inspection, and low-level JUROX/JCH
  knowledge;
- should be treated carefully because the file itself says it is mechanically
  separated and not perfect.

## Next Inventory Steps

1. Build a non-recursive source map for JCH-Mv1.0.1.
2. Extract all filenames and extensions related to `haic*`, `jch`, `hcb`,
   runtime, startup, libraries, object files, and config.
3. Build term frequency for the legacy JGS term seed.
4. Identify files suitable for curated training examples.
5. Keep private paths out of public datasets unless approved.

