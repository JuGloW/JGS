# Haicode Purity

Haicode purity means software enters the JGS ecosystem with Haicode identity,
not as a loose copy of another language.

## Rule

The original program's function and behavior must be preserved, but its syntax,
extension, naming identity, and ecosystem position must become part of the
Haicode family.

## Not Enough

These are not enough:

- renaming files only;
- changing keywords with text replacement;
- wrapping foreign code while leaving semantics unknown;
- claiming compatibility without tests;
- hiding unsupported behavior.

## Required

Haicode conversion must preserve:

- logic;
- control flow;
- data flow;
- type meaning;
- API behavior;
- runtime expectations;
- ABI behavior when relevant;
- test results or expected outputs.

## Family Direction

The `haic*` group is the starting foundation for C-like system conversion.
Other branches of the larger `hai*` family should grow from the same principle:
each source language enters Haicode with equivalent behavior and clear identity.

