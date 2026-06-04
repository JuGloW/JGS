# Converhai Doctrine

Converhai is the conversion intelligence Haijun must learn for the JuGloW JGS
ecosystem.

## Definition

Converhai converts software from other programming languages into the Haicode
family.

The conversion target is not only visual syntax. The target is full ecosystem
identity:

- source language syntax becomes Haicode syntax;
- file extensions enter the `hai*` family;
- logic and behavior remain equivalent;
- runtime assumptions are mapped or documented;
- compiler and ABI expectations move toward JCH and HCB.

## Core Formula

```text
source code behavior + source language semantics
  -> Converhai analysis
  -> Haicode syntax and hai* identity
  -> JCH compiler path
  -> HCB ABI validation
  -> equivalent behavior
```

## Primary Foundation

The foundation group is `haic*`.

This matters because Unix and Linux are deeply rooted in C. If JUROX OS is to
become a Haicode-centered system, Haijun must understand how C system code,
Unix/Linux architecture, and ABI behavior can be represented inside the Haicode
ecosystem.

## Conversion Targets

Converhai should eventually handle:

- applications;
- programs;
- libraries;
- IDE source code;
- developer tools;
- operating system components;
- source trees from public or private repositories;
- scripts and build systems, when policy allows.

## Required Conversion Stages

1. Identify source language and project structure.
2. Parse source files into structured representation.
3. Identify semantics, types, control flow, data flow, APIs, and runtime needs.
4. Map language constructs into Haicode and the correct `hai*` family form.
5. Preserve function names and behavior where useful, while adapting ecosystem
   identity.
6. Compile or statically validate through JCH when available.
7. Validate ABI expectations through HCB when relevant.
8. Run tests, golden outputs, and differential checks against the original.
9. Record gaps when exact conversion is not yet possible.

## Quality Standard

The ambition is zero functional conversion error. The engineering standard is:

- no claimed conversion is trusted without tests;
- behavior must be compared against the original;
- unsupported constructs must be marked clearly;
- uncertain conversions must stop or request review;
- conversion knowledge should become training data only after validation.

## Haijun's Responsibility

Haijun must learn Converhai from birth. When Haijun studies any programming
language, it should ask:

- What is the syntax?
- What is the semantic meaning?
- What runtime assumptions exist?
- What ABI or OS behavior is implied?
- What is the Haicode equivalent?
- Which `hai*` family branch should it enter?
- How can the conversion be proven correct?

