# Dataset Schema

Haijun supervised fine-tuning data uses JSONL. Each line is one conversation.

```json
{"messages":[{"role":"system","content":"..."},{"role":"user","content":"..."},{"role":"assistant","content":"..."}],"meta":{"source":"manual","project":"jgs","tags":["compiler"]}}
```

Rules:

- `messages` must be a non-empty list.
- Each message must have `role` and `content`.
- Roles must be `system`, `user`, or `assistant`.
- Every example should teach one concrete behavior.
- Prefer short, high quality examples over noisy bulk logs.
- Put raw logs in `data/raw/`; only curated training rows go to `datasets/`.

Recommended example types:

- bug diagnosis;
- command planning;
- code review;
- project architecture explanation;
- migration decision;
- failed approach and corrected approach;
- safety boundary for risky operations.

