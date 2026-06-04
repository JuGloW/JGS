# JGS Repository Plan

Repository: `https://github.com/JuGloW/JGS`

Haijun should live inside the JGS ecosystem, not as an unrelated project. When
the main repository structure is ready, this workspace can move into a JGS path
such as:

```text
JGS/
  ai/
    haijun/
      configs/
      data/
      datasets/
      docs/
      remote/
      scripts/
      src/
```

## Suggested Ecosystem Layout

```text
JGS/
  README.md
  docs/
  ai/
    haijun/
  compiler/
    jch/
    haicode/
    hcb/
  tools/
  experiments/
  infra/
```

## Migration Rule

Move Haijun into `JuGloW/JGS` only when:

- the JGS repo has its first stable structure;
- `.gitignore` prevents model/checkpoint uploads;
- SSH keys and server secrets are kept outside git;
- dataset policy is clear;
- first Haijun runbook has been tested.

