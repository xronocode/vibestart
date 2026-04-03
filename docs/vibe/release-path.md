# VIBE Release Path

## Purpose

Define the git-visible prerelease path for the clean VIBE / vibestart root surface.

## Current Line

The current clean-root line starts at:

- `4.0.0-beta.1`
- `4.0.0-beta.2`

This line is separate from the quarantined legacy vibestart v3 tags.

## Tagging Rules

Use annotated git tags.

Recommended tag sequence:

- `v4.0.0-beta.1`
- `v4.0.0-beta.2`
- `v4.0.0-beta.N`
- `v4.0.0-rc.1`
- `v4.0.0`

## Meaning Of Each Stage

### `beta`

Use `beta` when:

- the clean public root surface is coherent
- the active bootstrap path works
- one-project adoption is practical
- scope limits are still explicit

### `rc`

Use `rc` when:

- the beta path has already been exercised on real pilot repositories
- release notes and changelog are stable
- remaining gaps are no longer structural blockers

### stable

Use the stable `0.1.0` release when:

- the core path is proven
- release packaging is stable
- the public story, operator guide, and bootstrap behavior no longer drift materially

## Release Notes Requirements

Each prerelease should describe:

- what is newly usable
- what remains draft
- which profile is recommended
- known limits
- whether legacy material is still needed as reference
- whether target-repo-first git acquisition is part of the supported bootstrap path

## Current Recommendation

For the current line:

- recommend `core`
- describe `deep` as explicit but still draft-level in richer adapters
- keep release notes honest about the remaining GRACE-mechanics gap
