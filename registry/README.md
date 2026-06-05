# JGS Link Registry

The registry stores structured link data for the JGS documentation hub.

JGS is not a single global source bundle. It is the starting document for the
whole ecosystem and points to many separate repositories and installable
packages.

## Registry Files

- `packages.yaml`: project list, repository targets, and status.
- `install-index.md`: human-readable project/install index.

## Rules

- Each major package gets its own repository or release package.
- The JGS root repo stores links and metadata, not every package source.
- Package downloads must be separated by need.
- Model weights and private artifacts are never stored in JGS root.
