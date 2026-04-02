# Legacy Runtime Inventory and Separation Report

## Objective

This report inventories the current repository, groups the files by role, identifies which surfaces are live versus dormant, and proposes a clean separation between:
- clean agnostic VIBE release artifacts
- internal working materials
- legacy vibestart v3 product/runtime surfaces

## Repository Groups

### A. Clean agnostic VIBE release surface

These are the files that already form the new methodology and product-contract surface.

| Path | Role | Current status | Recommended action |
| :--- | :--- | :--- | :--- |
| `vibe.toml` | Root VIBE manifest | canonical | keep in release surface |
| `docs/requirements.xml` | intent and identity surface | canonical | keep in release surface |
| `docs/development-plan.xml` | execution architecture surface | canonical | keep in release surface |
| `docs/verification-plan.xml` | trust and verification surface | canonical | keep in release surface |
| `docs/knowledge-graph.xml` | semantic spine | canonical | keep in release surface |
| `docs/decisions.xml` | committed decisions | canonical | keep in release surface |
| `docs/vibe/governance.toml` | governance contract | canonical | keep in release surface |
| `docs/vibe/macros.toml` | macro contract surface | canonical | keep in release surface |
| `docs/vibe/spec.md` | human-readable VIBE spec | publishable projection | keep in release surface |
| `docs/vibe/grace-mapping.md` | lineage and migration | release-supporting | keep in release surface |
| `docs/vibe/vibestart-contract.md` | vibestart product contract | publishable projection | keep in release surface |
| `README.md` | clean public repo entrypoint | release-facing | keep in release surface |
| `.vibestart/state/.gitkeep` | runtime boundary placeholder | supportive | keep only if the release wants to expose runtime-state boundary explicitly |

### B. Compatibility-bound surface

These files are not VIBE core, but still exist for workflow compatibility.

| Path | Role | Current status | Recommended action |
| :--- | :--- | :--- | :--- |
| `docs/technology.xml` | GRACE compatibility shim | compatibility-only | keep in repo for local GRACE-compatible flows, but exclude from clean release surface |

### C. Internal-only project working surface

These files are useful for active framework development, but should not live inside the clean public methodology surface.

| Path | Role | Current status | Recommended action |
| :--- | :--- | :--- | :--- |
| `internal/reviews/2026-04-02-vibe-methodology-audit.md` | methodology audit report | internal | keep in `internal/` |
| `internal/inventory/2026-04-02-legacy-runtime-inventory.md` | inventory and separation report | internal | keep in `internal/` |

### D. Legacy vibestart v3 live runtime surface

These files were the live old installer/runtime path. Wave 3 has now quarantined them as one coherent legacy package.

| Path | Role | Evidence of live use | Recommended action |
| :--- | :--- | :--- | :--- |
| `legacy/vibestart-v3/vs-init` | old vibestart v3 shell entrypoint | sources `lib/*` and `lib/config/*` directly | quarantined in legacy |
| `legacy/vibestart-v3/lib/` | old shell runtime modules | sourced by `vs-init` | quarantined in legacy |
| `legacy/vibestart-v3/lib/config/` | environment-specific generators | sourced by `vs-init`; used by tests | quarantined in legacy |
| `legacy/vibestart-v3/profiles/*.env` | runtime defaults for old generators | sourced by `lib/detect.sh` and `lib/config/*` | quarantined in legacy |
| `legacy/vibestart-v3/tests/` | tests for old shell runtime | exercises `vs-init`, `lib/json.sh`, `lib/config/*` | quarantined in legacy |

### E. Legacy vibestart v3 dormant payload

These surfaces look like a historical framework/source pack. No current shell runtime code was found reading them directly. Wave 2 has already quarantined this payload under the legacy package.

| Path | Role | Evidence | Recommended action |
| :--- | :--- | :--- | :--- |
| `legacy/vibestart-v3/src/framework.toml` | old vibestart framework manifest | no runtime references found | quarantined in legacy |
| `legacy/vibestart-v3/src/fragments/` | AGENTS/context fragments | referenced only inside legacy docs/generator text, not by current runtime code | quarantined in legacy |
| `legacy/vibestart-v3/src/macros/` | old GRACE macro XMLs | no runtime references found | quarantined in legacy |
| `legacy/vibestart-v3/src/skills/grace/` | embedded GRACE skills source pack | no runtime references found | quarantined in legacy |
| `legacy/vibestart-v3/src/skills/vs-init/` | vs-init skill/reference pack | no runtime references found | quarantined in legacy |
| `legacy/vibestart-v3/src/standards/` | old standards source pack | no runtime references found | quarantined in legacy |
| `legacy/vibestart-v3/src/templates/` | old XML templates source pack | no runtime references found | quarantined in legacy |

Important constraint:
- these were safe to move only as one coherent legacy package
- current generator text still mentions `.vibestart/src/...`, which is acceptable only because this payload is now clearly quarantined under `legacy/vibestart-v3/`

### F. Legacy public product narrative

These files describe the old vibestart v3 product, not the clean VIBE methodology surface.

| Path | Role | Current status | Recommended action |
| :--- | :--- | :--- | :--- |
| `legacy/vibestart-v3/README.v3.md` | old vibestart v3 public narrative | legacy-facing | keep in legacy quarantine |
| `legacy/vibestart-v3/CHANGELOG.v3.md` | old vibestart v3 release log | legacy-facing | keep in legacy quarantine |

### G. Repo meta

| Path | Role | Recommended action |
| :--- | :--- | :--- |
| `.gitignore` | repo hygiene | keep |
| `.gitattributes` | repo hygiene | keep |
| `LICENSE` | licensing | keep |

## Safe-to-Move Candidates

### Already moved during Wave 1

- old `README.md` -> `legacy/vibestart-v3/README.v3.md`
- old `CHANGELOG.md` -> `legacy/vibestart-v3/CHANGELOG.v3.md`
- methodology audit report -> `internal/reviews/`

### Already moved during Wave 2

- `src/framework.toml` -> `legacy/vibestart-v3/src/framework.toml`
- `src/fragments/` -> `legacy/vibestart-v3/src/fragments/`
- `src/macros/` -> `legacy/vibestart-v3/src/macros/`
- `src/skills/` -> `legacy/vibestart-v3/src/skills/`
- `src/standards/` -> `legacy/vibestart-v3/src/standards/`
- `src/templates/` -> `legacy/vibestart-v3/src/templates/`

### Already moved during Wave 3

- `vs-init` -> `legacy/vibestart-v3/vs-init`
- `lib/` -> `legacy/vibestart-v3/lib/`
- `profiles/` -> `legacy/vibestart-v3/profiles/`
- `tests/` -> `legacy/vibestart-v3/tests/`

Reason:
- they form one live legacy runtime package
- the shell entrypoint still consumes them directly
- moving them together preserved the old package's internal path assumptions

### Decision-bound / compatibility-bound

- `docs/technology.xml`

Reason:
- it is not part of clean VIBE core
- but it still exists to satisfy GRACE-compatible flows
- moving it requires updating compatibility assumptions first

## Recommended Target Structure

```text
/
├── README.md                          # new VIBE-centric repo narrative
├── LICENSE
├── .gitignore
├── .gitattributes
├── vibe.toml
├── docs/
│   ├── requirements.xml
│   ├── development-plan.xml
│   ├── verification-plan.xml
│   ├── knowledge-graph.xml
│   ├── decisions.xml
│   └── vibe/
│       ├── governance.toml
│       ├── macros.toml
│       ├── spec.md
│       ├── grace-mapping.md
│       └── vibestart-contract.md
├── compat/
│   └── grace/
│       └── technology.xml             # optional future location
├── internal/
│   ├── README.md
│   ├── reviews/
│   └── inventory/
└── legacy/
    ├── README.md
    └── vibestart-v3/
        ├── CHANGELOG.v3.md
        ├── README.v3.md
        ├── vs-init
        ├── lib/
        ├── profiles/
        ├── src/
        ├── tests/
        └── ...
```

## Recommended Move Waves

### Wave 1: low-risk structure formation

Do now:
- create `internal/`
- create `legacy/`
- move internal review and inventory artifacts out of public docs
- prepare a new clean top-level README

This wave is safe and does not affect the old runtime path.

### Wave 2: legacy dormant payload quarantine

Status:
- applied

Moved as one group:
- `src/framework.toml`
- `src/fragments/`
- `src/macros/`
- `src/skills/`
- `src/standards/`
- `src/templates/`

Target:
- `legacy/vibestart-v3/src/`

Result:
- the clean root release surface no longer exposes the old source pack
- remaining references to `.vibestart/src/...` are now contained inside the quarantined legacy package and old runtime texts

### Wave 3: legacy runtime quarantine

Status:
- applied

Moved as one group:
- `vs-init`
- `lib/`
- `profiles/`
- `tests/`
- old `README.md`
- `CHANGELOG.md`

Target:
- `legacy/vibestart-v3/`

Precondition:
- either the repo is no longer shipping vibestart v3 as the active product
- or a new runtime/product implementation has replaced it

Result:
- the repository root no longer exposes the old v3 runtime as an active product surface
- the clean release surface is now materially separated from the old runtime/toolkit package

## What Was Already Formed in This Pass

Created:
- `internal/`
- `internal/reviews/`
- `internal/inventory/`
- `legacy/`

Moved:
- methodology audit report from public docs to `internal/reviews/`
- old top-level vibestart v3 README to `legacy/vibestart-v3/README.v3.md`
- old top-level vibestart v3 changelog to `legacy/vibestart-v3/CHANGELOG.v3.md`
- legacy dormant source pack to `legacy/vibestart-v3/src/`
- legacy live runtime package to `legacy/vibestart-v3/`

Replaced:
- top-level `README.md` with a clean VIBE-facing repo entrypoint

## Conclusion

The repository currently contains three materially different layers:
- the new VIBE methodology and product-contract surface
- internal working materials
- the old vibestart v3 runtime/toolkit package

The main cleanup principle should be:
- do not delete the old package blindly
- quarantine legacy in coherent waves
- keep the clean VIBE release surface small and agnostic

Current outcome after Waves 1-3:
- clean VIBE release surface remains at the repository root
- internal working materials are under `internal/`
- the old vibestart v3 narrative, runtime, tests, profiles, and source pack are under `legacy/vibestart-v3/`
- `docs/technology.xml` remains compatibility-bound in the repo, but is no longer part of the clean release archive surface
