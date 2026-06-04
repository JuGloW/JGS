# Control Only Policy

This local computer is the control machine for Haijun. It is not the training
machine and not the model storage machine.

## Allowed Locally

- write documentation;
- curate JSONL datasets;
- validate dataset schema;
- prepare SSH and sync commands;
- inspect logs and metrics downloaded from the server;
- plan model choices and training experiments.

## Not Allowed Locally

- download base model weights;
- store LoRA adapters or checkpoints;
- install CUDA, PyTorch GPU stacks, bitsandbytes, or large ML packages;
- run real training jobs;
- keep GPU server processes alive after training has finished.

## Server Only

The rented GPU server owns:

- Python virtual environment;
- ML dependencies;
- model cache;
- checkpoints;
- training runs;
- export and quantization jobs.

The local machine may receive small reports and metadata. Large artifacts should
stay on remote storage unless a specific export target is chosen.

