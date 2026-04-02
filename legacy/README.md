# Legacy Quarantine

This directory is reserved for older product/runtime surfaces that should be preserved for reference, migration, or phased extraction, but should not remain mixed into the clean agnostic VIBE release surface.

Typical candidates:
- old vibestart installer/runtime code
- legacy source packs and templates
- outdated product-facing docs tied to superseded behavior

Current quarantined package:
- `legacy/vibestart-v3/`
  This package now contains the old v3 public narrative, the live shell runtime, its tests,
  profiles, and the dormant source pack that used to sit at the repository root.

Rule:
- move legacy material here only in coherent waves
- keep each wave self-contained so references inside the quarantined package do not break arbitrarily
- do not move live runtime dependencies piecemeal unless the active runtime path has already been replaced
