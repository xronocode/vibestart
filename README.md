# VIBE / vibestart

`VIBE` stands for `Verified Intent-Based Engineering`.

It is an agent-agnostic methodology for intent-driven engineering, designed to reduce drift between engineering intent, canonical knowledge artifacts, implementation, verification, and runtime control behavior.

## What this repository currently contains

The clean methodology surface:
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

These files define the current VIBE draft:
- graph-first knowledge continuity
- contract-first execution
- macro-first workflow language
- deterministic governance
- traceable and calibratable autonomy

## vibestart

`vibestart` is the optional bootstrap/runtime product for VIBE.

It is intended to install and adapt one VIBE methodology through two product profiles:
- `core`
- `deep`

At the methodology level, `VIBE` remains one standard.
`core` and `deep` are product profiles, not separate frameworks.

## Current draft status

This repository is still in an active draft-and-separation phase:
- the methodology surface is being hardened
- the old vibestart v3 runtime/toolkit is being quarantined out of the clean release surface
- compatibility material is being kept explicit instead of being mixed into core semantics

## Legacy package

The previous vibestart v3 product/runtime materials are being moved into:

- `legacy/vibestart-v3/`

That package is preserved for reference and phased extraction, but it is no longer the canonical description of the new VIBE methodology surface.

## Internal working materials

Project-internal audits and inventory reports live under:

- `internal/`

They are useful during development and migration, but they are not part of the clean public methodology contract.
