# Changelog

This changelog tracks the clean VIBE / vibestart root surface.

Legacy vibestart v3 history remains preserved in `legacy/vibestart-v3/CHANGELOG.v3.md`.

## 4.0.0-beta.2 - 2026-04-03

Target-repo-first bootstrap increment.

### Added

- `bootstrap-from-git.sh` wrapper for fetching vibestart from git and bootstrapping the current target repository in place
- `tests/test_bootstrap_from_git.py`
- canonical release story updated around the target-repo-first acquisition model

### Changed

- the intended prerelease adoption path is now target-repo-first instead of requiring a separate long-lived local framework checkout as the main workflow

## 4.0.0-beta.1 - 2026-04-03

First public core-first beta candidate for the new VIBE / vibestart root surface.

### Added

- clean public root surface for VIBE and vibestart
- quarantined legacy and internal boundaries
- active `vibestart` bootstrap entrypoint
- target-repo-first `bootstrap-from-git.sh` acquisition wrapper
- explicit `--core` and `--deep` profile selection
- deterministic first-run contract
- VIBE-native beta readiness note
- VIBE-native operator guide
- richer generic XML bootstrap scaffolds for the first real project loop

### Changed

- `core` is now the explicit recommended beta path for one-project adoption
- `deep` remains explicit and supported, but still draft-level for richer adapters
- generated bootstrap surfaces now guide the project toward `discover -> refine -> deliver/fix -> sync`

### Known Limits

- full detailed GRACE operational mechanics have not yet been fully re-expressed on the clean root surface
- `deep` is not yet richly differentiated beyond the shared safe baseline
- richer multi-agent and integration contours remain future work
