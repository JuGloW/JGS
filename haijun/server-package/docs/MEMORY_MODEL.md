# Memory Model

Haijun needs memory more than raw size. The JGS ecosystem is large, so long-term
memory should be structured and retrievable.

## Memory Types

- identity memory: who the owner is and what Haijun is for;
- project memory: JGS architecture, modules, conventions, and current status;
- work memory: active tasks, errors, fixes, and decisions;
- security memory: protected assets and data classifications;
- training memory: datasets, model runs, evaluations, and lessons learned;
- partner memory: how Haijun helps Codex work better.
- migration memory: GNU/C/JCH/HCB/JDB terms, file patterns, and toolchain
  direction.

## What Goes Into Fine-Tuning

Fine-tuning should teach behavior:

- Indonesian technical style;
- JGS development discipline;
- safe command habits;
- code review taste;
- repair workflows;
- how to collaborate with Codex.

## What Goes Into Retrieval

Retrieval should hold changing knowledge:

- file indexes;
- project notes;
- logs;
- module status;
- design documents;
- dependency inventories;
- run reports.
- external source inventories such as JCH, executtools, autoconf, token lists,
  and instruction references.

## What Must Not Become Public Training Data

- secrets;
- credentials;
- private personal details;
- company confidential data;
- raw logs with unknown sensitivity;
- unreviewed private source snapshots.
