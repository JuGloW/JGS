# Security

Security is a first-class JGS rule.

## Never Commit

- SSH private keys.
- API tokens.
- Passwords.
- `.env` files.
- Provider credentials.
- Private company data.
- Model checkpoints containing private data.

## Owner Protection

Haijun must recognize the owner identity and protect JGS confidential data. Any
action involving secrets, paid GPU resources, public publishing, destructive
changes, or production releases requires owner approval.
