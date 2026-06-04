# JGS DNS Plan

Date: 2026-06-04

## Domain Ownership

- Primary domain: `juglow.my.id`
- Registrar: DomaiNesia
- DNS provider: Cloudflare
- Cloudflare plan: Free
- Domain status: active
- Cloudflare status: active/protected
- Registration date: 2026-06-04
- Next due date: 2027-06-04

Bonus domain:

- `juglow.web.id`
- Status: active
- Use: reserved only, not primary JGS domain

## Active DNS Records

These records currently exist in Cloudflare DNS:

| Hostname | Type | Value | Status |
| --- | --- | --- | --- |
| `jgs.juglow.my.id` | TXT | `JuGloW Global System - JGS root identity` | active |
| `haijun.juglow.my.id` | TXT | `Haijun AI control identity for JuGloW JGS` | active |
| `api.juglow.my.id` | TXT | `Reserved for JGS API endpoint` | reserved |
| `gpu.juglow.my.id` | TXT | `Reserved for Haijun GPU server endpoint` | reserved |
| `storage.juglow.my.id` | TXT | `Reserved for JGS storage endpoint` | reserved |

## Reserved DNS Targets

These names are reserved for future services:

- `juglow.my.id`: root website or portal, not configured yet.
- `www.juglow.my.id`: website alias, not configured yet.
- `jgs.juglow.my.id`: JGS identity and future JGS portal.
- `haijun.juglow.my.id`: Haijun AI identity and future interface.
- `api.juglow.my.id`: JGS API endpoint.
- `gpu.juglow.my.id`: temporary GPU server endpoint when a provider gives a stable host/IP.
- `storage.juglow.my.id`: storage endpoint or object gateway.

## Current Not Configured

- Root `A`, `AAAA`, or `CNAME` record: not configured.
- `www` record: not configured.
- Email `MX`: not configured.
- SPF, DKIM, DMARC: not configured.
- RunPod GPU DNS target: not configured.
- Storage provider DNS target: not configured.
- Database public DNS target: not configured.

## Rules

- Do not create fake `A` records before a real server/IP exists.
- Do not point `gpu.juglow.my.id` at a temporary GPU until the server first-run
  inspection passes.
- Do not expose database endpoints publicly unless the security model is written.
- Keep TXT records as identity/reservation markers until real services exist.
- Use Cloudflare DNS as the source of truth for `juglow.my.id`.

## Next DNS Changes

When a service becomes real, add one of:

- `A` record when we have a stable IPv4 address.
- `AAAA` record when we have a stable IPv6 address.
- `CNAME` record when the provider gives a hostname.

Likely future records:

| Hostname | Future Type | Future Target |
| --- | --- | --- |
| `gpu.juglow.my.id` | `A` or `CNAME` | RunPod or future GPU server |
| `api.juglow.my.id` | `A` or `CNAME` | JGS API server |
| `storage.juglow.my.id` | `CNAME` | Cloudflare R2/custom storage endpoint |
| `haijun.juglow.my.id` | `A` or `CNAME` | Haijun web/CLI gateway |
| `www.juglow.my.id` | `CNAME` | root website or Cloudflare Pages |
