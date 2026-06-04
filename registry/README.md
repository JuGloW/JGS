# JGS Registry

The registry is the source of truth for ecosystem package links.

JGS is not a single global download bundle. It is an index that points to many
separate repositories and installable packages.

## Registry Files

- `packages.yaml`: package list, repository targets, and status.
- `install-index.md`: human-readable install/download index.

## Rules

- Each major package gets its own repository or release package.
- The JGS root repo stores links and metadata, not every package source.
- Package downloads must be separated by need.
- Model weights and private artifacts are never stored in JGS root.
