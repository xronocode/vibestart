# VIBE Operator Guide

## Purpose

This guide describes the normal operating loop for a project that has been bootstrapped with VIBE.

## First Day After `vibestart --core`

1. Replace the placeholder intent in `docs/knowledge-graph.xml`.
2. Clarify the first real project slice in the graph before expanding downstream artifacts.
3. Define the first project module and its verification obligation.
4. Treat the generated XML as a starting surface, not as finished project truth.

## Target-Repo-First Bootstrap

The intended beta UX is:

1. create or enter the target repository
2. fetch vibestart from git
3. run bootstrap against the current repository

Practical shape:

`bootstrap-from-git.sh --repo <git-url> --ref v0.1.0-beta.2 --core --target .`

This keeps the target repository as the active working context instead of requiring a separate long-lived framework checkout first.

## Normal Operating Loop

- use `discover` when intent is new, ambiguous, or changed
- use `refine` when graph state is stable enough to project into requirements, plan, and verification
- use `deliver` when work is ready for implementation
- use `fix` when repairing regressions, mismatches, or drift
- use `sync` when governance recommends reconcile or when shared artifacts need explicit cleanup
- use `resume` when returning to an interrupted thread of work
- use `deploy` only after the relevant work is verified

Plain engineering requests may enter through `vibe` implicitly, but the same macro semantics still apply.

## Recommendation Acceptance

In guided mode:

- review the current recommendation bundle
- type `v` to accept it
- type `м` as a layout-safe alias when needed

These tokens accept the current recommendation bundle only. They do not authorize arbitrary extra actions.

## Core Beta Posture

For the current beta:

- prefer `guided`
- prefer `single`
- treat `auto`, `multi`, and `calibrate-apply` as explicit experimental surfaces
- use `deep` only when you deliberately want the richer product contour, not because the methodology changes

## What To Avoid

- do not treat runtime state as canonical project truth
- do not write downstream plan or verification artifacts before the graph has enough maturity
- do not manually micromanage every low-level phase when a macro already matches the engineering goal
- do not treat the quarantined GRACE legacy package as the active product surface

## Minimal Success Pattern

For a first pilot project, the healthy loop is:

`intent -> discover -> refine -> deliver/fix -> sync -> verified continuity`

If that loop works cleanly, the project is already getting value from VIBE.
