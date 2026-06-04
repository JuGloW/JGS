# JDB Debugger Vision

JDB is the future debugger and binary inspection direction for Haicode and the
JGS ecosystem.

## Analogy

If C programs are tested and debugged with GDB, Haicode programs should
eventually be tested and debugged with JDB.

```text
C / GNU / GDB -> Haicode / JGS / JDB
```

## Scope

JDB should be able to inspect and debug:

- Haicode source;
- `hai*` family source files;
- JCH compiler output;
- HCB ABI metadata;
- libraries;
- binary libraries;
- object files;
- executables;
- runtime modules;
- symbol tables;
- traces and crash reports.

## Relationship To Converhai

Converhai converts source ecosystems into Haicode. JDB verifies that converted
programs behave correctly at runtime and binary level.

Converhai asks:

> Did we convert the program into Haicode correctly?

JDB asks:

> Does the converted program execute, link, load, and behave correctly?

## Relationship To HCB

JDB must understand HCB ABI rules. It should help inspect:

- calling conventions;
- symbol names;
- object layout;
- binary compatibility;
- runtime entry points;
- module boundaries;
- executable behavior.

## Haijun's Role

Haijun must learn JDB as part of its debugging intelligence. When Haijun studies
GDB, GNU, ELF/PE/COFF, object files, symbols, and debug formats, it should map
that knowledge toward JDB and the JGS toolchain.

