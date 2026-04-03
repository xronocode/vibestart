# vibestart v4.0.0-beta.2

`v4` is not just a new `vibestart` version. It is a major redesign of the entire product line.

If `v3.x` was primarily a bootstrap/runtime package with a legacy skill corpus, `v4` rebuilds `vibestart` around a new methodology-first foundation: `VIBE` - `Verified Intent-Based Engineering`.

This is a new public line where:
- work starts from the engineering goal rather than manual phase-by-phase orchestration
- graph, contracts, verification, and governance become the canonical root surface
- configuration and operating policy are expressed explicitly instead of being hidden inside tool-specific mechanics
- bootstrap becomes target-repo-first: adoption starts from the target repository itself

## What v4 unifies

`v4` deliberately combines and re-expresses strong ideas from two existing approaches:

- [osovv/grace-marketplace](https://github.com/osovv/grace-marketplace)
- [aka-NameRec/ai-standards](https://github.com/aka-NameRec/ai-standards)

| Source | Strong contribution | How `VIBE / vibestart v4` re-expresses it |
| --- | --- | --- |
| `grace-marketplace` | graph-anchored code engineering, contracts, verification-first execution, controller-managed skills | keeps the graph/contract/verification depth, but moves the public workflow into VIBE macros and a clean root artifact surface |
| `ai-standards` | manifest-driven AI instruction composition, reusable fragments, project-local overrides | keeps explicit config/policy composition, but grounds it in VIBE manifests, governance, macro contracts, and bootstrap profiles |
| `VIBE / vibestart v4` | unified line | combines graph-first knowledge, contract-first execution, explicit config surfaces, and target-repo-first bootstrap into one clean methodology-first product surface |

## What changes in practice

The main shift in `v4` is:
- from a skill-centric/tool-centric model to a methodology-first model
- from scattered scripts and legacy flows to a clean public root surface
- from manual orchestration burden to macro-driven workflow
- from implicit operational behavior to deterministic governance and traceable autonomy

The new public workflow is built around macros:
- `discover`
- `refine`
- `deliver`
- `fix`
- `sync`
- `resume`
- `deploy`
- `vibe`

This means the system moves from intent to a closure path instead of requiring the operator to trigger isolated low-level steps one by one.

## What beta.1 established

`v4.0.0-beta.1` established the new foundation:
- clean public root surface for `VIBE / vibestart`
- quarantined `legacy/` and `internal/` boundaries
- active `vibestart` bootstrap entrypoint
- explicit `--core` and `--deep`
- deterministic first-run contract
- VIBE-native beta readiness note
- VIBE-native operator guide
- richer generic XML scaffolds for the first real project loop

## What beta.2 adds

`v4.0.0-beta.2` adds the next important step:
- a target-repo-first bootstrap path
- `bootstrap-from-git.sh`
- bootstrap from git directly into the current target repository
- a prerelease adoption UX that no longer treats a long-lived local framework checkout as the main path

This makes adoption much closer to real project use:
1. stand inside a new repository
2. fetch `vibestart` from git
3. initialize VIBE into the current repo

## Current status

The honest current status is:
- `core` is the recommended beta path for one-project adoption
- `deep` is explicit and supported, but richer adapters are still draft-level
- the canonical methodology surface already exists
- the clean bootstrap path already works
- full operational parity with the full legacy GRACE skill corpus is not there yet

## Current limitations

- not all detailed GRACE operational mechanics have been re-expressed into the new clean-root VIBE corpus yet
- `deep` is not yet differentiated as deeply as intended
- richer multi-agent and integration contours remain future work
- this is a beta of the new methodology and bootstrap path, not a final complete runtime product

## Short formula

- `v3.x` = legacy vibestart line
- `v4.x` = new `VIBE / vibestart` methodology-first line
