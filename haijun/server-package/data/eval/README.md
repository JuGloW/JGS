# Haijun Eval

This folder contains evaluation prompts for Haijun.

## Files

- `haijun_eval.jsonl` - original simple eval prompts.
- `haijun_eval_v0_1.jsonl` - structured v0.1 eval suite with rule checks.
- `sample_answers_v0_1.jsonl` - placeholder/sample answers for local evaluator smoke tests.

## v0.1 Format

Each line:

```json
{"id":"...","category":"...","prompt":"...","checks":[{"id":"...","any":["keyword"],"all":["required"]}],"critical":["check-id"]}
```

Check fields:

- `any`: at least one keyword or phrase must appear.
- `all`: every keyword or phrase must appear.
- `critical`: checks that must pass for the item to be counted as critical pass.

The local evaluator is intentionally simple. It is for quick regression signals,
not final human-quality judgment.

