# DNS and Cloud Plan

## Domain

- Primary domain: `juglow.my.id`
- Registrar: DomaiNesia
- DNS provider: Cloudflare
- Cloudflare plan: Free

## Active DNS Identity Records

- `jgs.juglow.my.id`: JGS root identity.
- `haijun.juglow.my.id`: Haijun AI control identity.
- `api.juglow.my.id`: reserved for API endpoint.
- `gpu.juglow.my.id`: reserved for GPU server endpoint.
- `storage.juglow.my.id`: reserved for storage endpoint.

## Not Configured Yet

- Root website.
- `www` website alias.
- Email/MX records.
- Public API server.
- GPU server DNS target.
- Storage custom domain.

## Low-Cost Cloud Direction

- DNS: Cloudflare.
- GPU: RunPod first.
- Storage: Cloudflare R2 later if needed.
- Database: Supabase or Neon later if needed.
- AWS: postponed until JGS needs enterprise cloud services.
