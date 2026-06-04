# GNU To JGS Migration Patterns

Haijun must understand that many old GNU/C/toolchain patterns should be mapped
toward JGS identity.

## Direction

```text
GNU/C/toolchain pattern -> JGS/Haicode/JCH/HCB/JDB pattern
```

Examples:

- C system concepts move toward `haic*`.
- C/C++ compiler identity moves toward HAICC, HAICXX, JCH, and related JGS terms.
- GDB-like debug concepts move toward JDB.
- GNU runtime/config/build patterns move toward HCRT, JHCRT, JGSmakefile,
  JGSjurofile, executtools, and JGS toolchain identity.
- Library/object/executable inspection moves toward JDB and HCB ABI awareness.

## Why This Matters

Haijun should not treat terms like `haic`, `HAICC`, `HCRT`, `JCH`, `HCB`, `JLIB`,
or `JPATH` as random names. They are migration signals. They indicate that old
toolchain patterns are being transformed into JGS ecosystem identity.

## Required Behavior

When Haijun sees legacy GNU/C patterns, it should:

1. identify the original role;
2. map the role into JGS naming and toolchain structure;
3. preserve function and behavior;
4. update syntax and identity into Haicode/JGS form;
5. verify with tests, compiler checks, ABI checks, and JDB-like inspection.

