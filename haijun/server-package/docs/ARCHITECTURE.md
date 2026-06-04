# Haijun Architecture

Haijun has four layers.

## 1. Control Layer

Runs on this local machine.

- collect source context and notes;
- create training examples;
- validate JSONL datasets;
- package GPU jobs;
- compare evaluation reports.

## 2. Knowledge Layer

Long project memory should live outside the model whenever possible.

- source code index;
- project notes;
- issue history;
- command logs;
- design decisions;
- glossary and naming conventions.

This layer should later become retrieval augmented generation (RAG), so Haijun
does not need to memorize every line of JGS code.

## 3. Adaptation Layer

LoRA/QLoRA adapters teach the model how to behave:

- JGS repair workflow;
- Indonesian working style with technical precision;
- preferred command discipline;
- code review habits;
- consistency rules for compiler and ABI work.

## 4. Deployment Layer

For daily work, Haijun can run through one of these modes:

- API-backed assistant using the best available hosted model plus JGS retrieval;
- local/server inference with a quantized model;
- adapter inference on GPU when the task needs specialist behavior.

The first production Haijun should combine retrieval plus a small, tested
adapter. Bigger models come after evaluation proves they are worth the cost.

