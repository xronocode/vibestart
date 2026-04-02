# VIBE Methodology Audit

## Status

Completed on 2026-04-02.

This report summarizes the methodology audit performed against the current VIBE / vibestart draft surfaces.

## Scope

Audited canonical VIBE surfaces:
- `vibe.toml`
- `docs/vibe/governance.toml`
- `docs/vibe/macros.toml`
- `docs/knowledge-graph.xml`
- `docs/requirements.xml`
- `docs/development-plan.xml`
- `docs/verification-plan.xml`
- `docs/vibe/spec.md`
- `docs/vibe/vibestart-contract.md`

Not fully audited in this pass:
- runtime/bootstrap implementation under `vs-init`, `lib/`, `profiles/`, `src/`, `tests/`
- public repo narrative surfaces such as `README.md` and `CHANGELOG.md`

## Summary

The canonical VIBE methodology surface is now materially more coherent than at the start of the audit.

Main outcomes:
- root manifest semantics were tightened and de-ambiguous
- governance and macro contracts were aligned with deterministic-control decisions
- graph schema was normalized around `kind` as the universal node-family discriminator
- stale verification and product-contract references were updated after schema refactors
- product-profile language was aligned around `core` and `deep`
- VIBE identity and positioning were made explicit in canonical and publishable surfaces

## Major Fixes by Surface

### 1. `vibe.toml`

Applied:
- introduced `[manifest]` with `schema_version` and `role`
- separated `[project]` identity from `[bootstrap]` profile
- renamed `[defaults]` to `[execution]`
- renamed `[stability]` to `[execution_policy]`
- removed premature `[profiles]`
- renamed `[features]` to `[capabilities]`
- renamed `[policy]` to `[contracts]`
- renamed `policy_files` to `override_files`
- kept `[boundary]` but added a future split note for paths vs roles

Why:
- to remove semantic buckets that would otherwise become drift magnets
- to separate identity, execution defaults, policy posture, and product profile cleanly
- to keep the root manifest short, readable, and machine-safe

### 2. `docs/vibe/governance.toml`

Applied:
- renamed `[policy]` to `[preflight]`
- tightened routing/governance mode to deterministic-only in canonical form
- clarified that `lines_changed` is a secondary signal
- documented mixed threshold families and mixed reconcile trigger families explicitly
- renamed `review.after_fix.baseline` to `default_level`
- made risk scoring explicitly subordinate to hard floors and deterministic precedence
- added `decision_reason` to the required governance output bundle
- clarified calibration supported-vs-enabled semantics

Why:
- to close sanctioned heuristic drift paths
- to preserve explainability as part of the hard contract
- to keep governance algebra explicit, reproducible, and reviewable

### 3. `docs/vibe/macros.toml`

Applied:
- tightened routing mode to deterministic-only in canonical form
- clarified that auto-mode routing remains traceable even when not announced inline
- removed duplicated global stability block from the macro file
- clarified the private skill namespace and macro-to-skill mappings
- added conditional-write clarifications for `discover`, `refine`, `deliver`, `deploy`
- clarified selective `multi` semantics for `deliver` and `fix`
- narrowed `sync` purpose to its actual write scope
- clarified `resume` as control-flow re-entry rather than product-maturity projection
- clarified `vibe` as an orchestrator with delegated writes
- clarified that `calibrate` support does not override governance-level permission

Why:
- to keep public macro contracts stable and precise
- to prevent the macro surface from silently absorbing global policy concerns
- to make execution semantics explicit enough for compliant runtimes

### 4. `docs/knowledge-graph.xml`

Applied:
- normalized schema so `kind` is the universal node-family discriminator
- retained `type` only for module taxonomy
- renamed `NodeTypes` to `NodeKinds`
- marked module taxonomy active subset vs reserved placeholders
- aligned `F-002` so `calibrate` is no longer described as part of the public macro language
- aligned `F-003` source with the actual bootstrap contract surface
- moved `W-001`, `W-002`, and `W-003` to `done/done` to match completed module work
- updated ontology export wording from `node types` to `node kinds`
- completed missing `governed-by` decision crosslinks

Why:
- the graph is the semantic center of the methodology and cannot afford overloaded field meaning
- stale work states and incomplete crosslinks would otherwise undermine anti-drift claims
- the graph had to reflect the actual macro/public-vs-expert boundary

### 5. `docs/verification-plan.xml`

Applied:
- updated verification commands to match the new root-manifest schema
- updated governance verification for `default_level` and `decision_reason`
- updated ontology verification from `NodeTypes` to `NodeKinds`
- aligned trace language with current schema and profile terminology

Why:
- the project’s self-verification had drifted behind the canonical surfaces
- VIBE cannot claim deterministic control while validating stale contracts

### 6. `docs/vibe/vibestart-contract.md`

Applied:
- updated root-manifest references from `bootstrap_profile` to `[bootstrap].profile`
- aligned wording from `docs integrations` to `external integrations`
- kept `core` and `deep` as product profiles over one methodology

Why:
- the human-facing product contract must track the actual manifest schema
- product language must stay aligned with the current config vocabulary

### 7. `docs/requirements.xml` and `docs/vibe/spec.md`

Applied:
- added an explicit VIBE identity surface
- fixed the official expansion: `Verified Intent-Based Engineering`
- made lineage to GRACE and adjacent workflow tooling explicit
- described macro-first goal closure, adaptive autonomy hooks, XML/TOML surface split, and `core/deep` profiles

Why:
- the draft had grown structurally strong, but its identity story was still underspecified
- a methodology of this kind needs a clear definition, not only a set of artifacts

## Key Methodological Corrections

The most important conceptual corrections were:
- VIBE is one methodology; `vibestart` is an optional product
- `core` and `deep` are product profiles, not separate standards
- macros are the public language; skills are the internal realization layer
- deterministic control is normative; heuristic control is not part of the canonical contract
- verification is part of the trust model, not a post-hoc check
- runtime state is operational exhaust, not canonical truth

## Residual Risks

These are still open or outside current scope:
- runtime/bootstrap implementation under `vs-init`, `lib/`, `src/`, and `tests/` has not yet been audited against the new methodology surfaces
- public-facing repo narrative such as `README.md` still likely reflects older product framing
- `docs/technology.xml` remains a GRACE compatibility shim and must continue to be prevented from becoming a competing VIBE core surface
- `deep` is still defined contractually more than operationally; richer integration semantics remain future work

## Verification Performed

Completed after the audit:
- XML parse of canonical XML surfaces
- TOML parse of canonical TOML surfaces
- targeted verification snippets for ontology and manifest/governance updates
- graph crosslink and layer-count consistency checks
- stale-term sweep for removed schema names and outdated manifest fields

## Conclusion

The current VIBE methodology draft is now substantially more internally consistent.

Its strongest properties after the audit are:
- clearer semantic boundaries
- a more uniform graph schema
- stronger deterministic-control posture
- better alignment between canonical artifacts and human-facing contract documents

The next high-value work is no longer methodology cleanup.
It is implementation alignment:
- audit and adapt the legacy/runtime bootstrap code
- refresh public-facing repo narrative
- implement `vibestart` behavior against the now-hardened contracts
