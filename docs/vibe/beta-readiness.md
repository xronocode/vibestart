# VIBE Core Beta Readiness

## Status

Current prerelease target: `4.0.0-beta.2`.

`core`: beta-candidate for one-project adoption.  
`deep`: draft product profile, explicit and safe but not yet richly differentiated.

## What Is Ready Now

- one clean public root surface for VIBE and vibestart
- one active `vibestart` bootstrap entrypoint
- one git-acquisition wrapper for target-repo-first bootstrap
- explicit `--core` and `--deep` profile selection
- deterministic first-run contract
- parseable XML and TOML shared install surface
- normative defaults kept at `guided` and `single`
- legacy v3 package quarantined away from the active product surface

## What Is Intentionally Not Beta-Complete Yet

- richer `deep`-specific adapters and integrations
- full VIBE-native re-expression of every detailed GRACE operational skill
- production-ready multi-agent operating layer
- richer non-XML memory or integration backends

## Practical Beta Boundary

The current beta recommendation is:

- use `vibestart --core`
- prefer target-repo-first bootstrap by fetching vibestart from git into the current repository context
- treat `deep` as an explicit future-facing profile, not as the main beta path
- use the clean root VIBE docs as the active methodology source
- use the quarantined GRACE skill corpus only as reference material when a detailed legacy playbook is still useful

## Beta Checklist

- `core` bootstrap path works end-to-end
- generated starting artifacts are generic and usable for the first real project loop
- operator guidance exists in VIBE-native form
- beta scope and known gaps are explicit
- one pilot project can move through `discover -> refine -> deliver/fix -> sync`

## Recommended Release Message

VIBE currently supports a `core-first` beta: one methodology, one clean root surface, one working bootstrap path, and a usable first project loop. `deep` remains explicit and supported as a product profile, but richer differentiation is still future work.
