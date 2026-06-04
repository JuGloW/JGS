# Training Lifecycle

Haijun training must be treated like a short, planned rental session.

## Before GPU Starts

- dataset is prepared and validated;
- base model candidate is selected;
- expected VRAM and cost are known;
- SSH login is tested;
- DNS or server hostname is stable;
- remote disk capacity is checked;
- stop condition is written down.

## During GPU Session

- install dependencies on the server;
- download model weights on the server;
- run a smoke test first;
- start the real training run;
- watch logs and GPU utilization;
- stop early if loss, data, or config is clearly wrong.

## After GPU Session

- save training config copy;
- keep metrics and eval reports;
- keep adapter/checkpoint on server storage;
- download only small analysis artifacts unless export is needed;
- shut down the GPU server;
- write what improved and what failed.

## Promotion Rule

A Haijun adapter is promoted only when it beats the base model on JGS-specific
evaluation prompts and behaves more consistently in real project tasks.
