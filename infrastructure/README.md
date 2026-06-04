# Infrastructure

This area tracks the infrastructure direction for JGS.

## Current Stack

- Domain: `juglow.my.id`
- Registrar: DomaiNesia
- DNS: Cloudflare
- GPU: RunPod planned
- Storage: Cloudflare R2 planned
- Database: Supabase or Neon planned

## RunPod First-Run Rule

The first GPU server session must only:

- upload the Haijun server package;
- inspect OS, disk, Python, GPU, and `nvidia-smi`;
- validate dataset and eval;
- write first-run reports;
- avoid model downloads and training.
