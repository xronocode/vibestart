# VIBE / vibestart

`VIBE` stands for `Verified Intent-Based Engineering`.

It is an agent-agnostic methodology for intent-driven engineering, designed to reduce drift between engineering intent, canonical knowledge artifacts, implementation, verification, and runtime control behavior.

## Public root surface

The clean methodology surface:
- `CHANGELOG.md`
- `vibestart`
- `tests/test_vibestart.py`
- `vibe.toml`
- `docs/requirements.xml`
- `docs/development-plan.xml`
- `docs/verification-plan.xml`
- `docs/knowledge-graph.xml`
- `docs/decisions.xml`
- `docs/vibe/governance.toml`
- `docs/vibe/macros.toml`
- `docs/vibe/spec.md`
- `docs/vibe/grace-mapping.md`
- `docs/vibe/vibestart-contract.md`
- `docs/vibe/beta-readiness.md`
- `docs/vibe/operator-guide.md`
- `docs/vibe/release-path.md`

These files define the current VIBE draft:
- graph-first knowledge continuity
- contract-first execution
- macro-first workflow language
- deterministic governance
- traceable and calibratable autonomy
- a working root bootstrap entrypoint for explicit `core` and `deep` profile selection
- a core-first beta adoption path for one-project use

## vibestart

`vibestart` is the optional bootstrap/runtime product for VIBE.

It is intended to install and adapt one VIBE methodology through two product profiles:
- `core`
- `deep`

At the methodology level, `VIBE` remains one standard.
`core` and `deep` are product profiles, not separate frameworks.

Current active entrypoint:

- `./vibestart --core --target /path/to/project`
- `./vibestart --deep --target /path/to/project`

Current beta posture:

- `core` is the recommended beta path for one-project adoption
- `deep` remains explicit and supported, but its richer adapters are still draft-level
- `docs/vibe/operator-guide.md` describes the normal first project loop after bootstrap
- prerelease git path starts at `v0.1.0-beta.1`

## Repository structure

- repository root, `vibe.toml`, and `docs/` form the clean VIBE working and release surface
- `docs/technology.xml` is compatibility-only material kept for GRACE-compatible flows
- `internal/` holds project-internal reviews, inventory, and migration notes
- `legacy/vibestart-v3/` holds the quarantined vibestart v3 package

## Legacy package

The previous vibestart v3 product/runtime materials are preserved under:

- `legacy/vibestart-v3/`

That package is preserved for reference and phased extraction, but it is no longer the canonical description of the new VIBE methodology or product surface.

## Internal working materials

Project-internal audits and inventory reports live under:

- `internal/`

They are useful during development and migration, but they are not part of the clean public methodology contract.

## Current working rule

New VIBE and vibestart product/workspace work happens only on the clean root surface.

- treat `legacy/` as reference-only unless a deliberate extraction or migration task requires it
- keep compatibility artifacts explicit instead of letting them leak into VIBE core semantics
- keep internal reports out of the public contract surface
