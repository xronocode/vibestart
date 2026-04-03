# VIBE / vibestart

`VIBE` stands for `Verified Intent-Based Engineering`.

It is an agent-agnostic methodology for intent-driven engineering, designed to reduce drift between engineering intent, canonical knowledge artifacts, implementation, verification, and runtime control behavior.

`v4` is a major redesign of the previous vibestart line, not a small incremental update. It deliberately combines and re-expresses strong ideas from [osovv/grace-marketplace](https://github.com/osovv/grace-marketplace) and [aka-NameRec/ai-standards](https://github.com/aka-NameRec/ai-standards) into one clean methodology-first product surface.

## What v4 unifies

| Dimension | [grace-marketplace](https://github.com/osovv/grace-marketplace) | [ai-standards](https://github.com/aka-NameRec/ai-standards) | `VIBE / vibestart v4` |
| --- | --- | --- | --- |
| Main contribution | graph-anchored code engineering, contracts, verification-first execution, controller-managed skills | centralized AI instruction infrastructure, manifest-driven composition, reusable fragments, project-local overrides | one methodology-first root surface that combines graph/contract rigor with explicit policy/config composition and bootstrap |
| Public operating model | skill-driven workflow such as `grace-init`, `grace-plan`, `grace-execute`, `grace-reviewer` | manifest and renderer flow for project-specific `AGENTS.md` generation | macro-first workflow language: `discover`, `refine`, `deliver`, `fix`, `sync`, `resume`, `deploy`, `vibe` |
| Core artifacts | XML planning, graph, verification, semantic execution flow | `ai.project.toml`, fragment registry, generated `AGENTS.md`, local overrides | canonical XML knowledge surfaces plus TOML operating contracts and explicit runtime-state boundary |
| Configuration style | methodology and skill corpus shipped together | manifest-only dependency declaration for instruction features and stacks | explicit root manifest, governance policy, macro contracts, and profile-aware bootstrap through `core` and `deep` |
| Execution control | controller-managed sequential or multi-agent implementation | policy composition and activation guidance | deterministic governance, review/sync selection by risk and evidence, traceable and calibratable autonomy |
| What v4 changes | keeps the graph/contract/verification depth | keeps explicit composition and project-scoped policy discipline | unifies both approaches into a target-repo-first bootstrap and a clean public VIBE root surface |

## Public root surface

The clean methodology surface:
- `CHANGELOG.md`
- `bootstrap-from-git.sh`
- `vibestart`
- `tests/test_vibestart.py`
- `tests/test_bootstrap_from_git.py`
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

Current active entrypoints:

- `./vibestart --core --target /path/to/project`
- `./vibestart --deep --target /path/to/project`
- from inside a target repository:
  `bash <(curl -fsSL <bootstrap-from-git.sh-url>) --repo <git-url> --ref v4.0.0-beta.2 --core --target .`

Current beta posture:

- `core` is the recommended beta path for one-project adoption
- `deep` remains explicit and supported, but its richer adapters are still draft-level
- `docs/vibe/operator-guide.md` describes the normal first project loop after bootstrap
- current prerelease git path is `v4.0.0-beta.2`
- intended adoption UX is target-repo-first: fetch vibestart from git into the current repository context, then write the VIBE surface into that repository

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
