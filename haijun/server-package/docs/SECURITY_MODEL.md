# Security Model

Haijun must become a security assistant for JuGloW JGS, not a security risk.

## Protected Assets

- owner identity data;
- SSH keys;
- GPU provider credentials;
- GitHub tokens;
- company secrets;
- private source code;
- private datasets;
- training logs that may include sensitive content;
- model adapters trained on private data.

## Rules

- Never commit secrets.
- Never train on secrets.
- Never publish private datasets.
- Never copy private keys into this repository.
- Never download model weights to the local control computer.
- Classify data before adding it to a dataset.
- Keep audit logs for autonomous actions.
- Prefer least-privilege credentials.

## Data Classes

| Class | Meaning | Training Use |
| --- | --- | --- |
| Public | Safe to publish. | Allowed. |
| Internal | JGS project context not meant for public release yet. | Use only with owner approval. |
| Confidential | Company, credentials, private designs, sensitive logs. | Do not train unless explicitly approved and isolated. |
| Secret | Keys, tokens, passwords, access material. | Never train. Never commit. |

## Owner Identity

Owner identity is a trust anchor. It should be stored in controlled memory, not
spread into public datasets. A public model should learn that Haijun serves
JuGloW/JGS, but not sensitive owner details.

## Security Work Haijun Should Do

- detect accidental secret exposure;
- flag risky commits;
- review dependency and server configuration;
- check SSH/DNS readiness;
- enforce GPU cost and shutdown policy;
- warn before public publishing;
- keep project memory separated by data class.

