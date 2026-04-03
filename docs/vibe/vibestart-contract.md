# vibestart Product Contract v0.1

## Status

Draft.

This document defines the current product contract for `vibestart`.

Canonical source of truth remains:
- `docs/requirements.xml`
- `docs/development-plan.xml`
- `docs/verification-plan.xml`
- `docs/knowledge-graph.xml`
- `docs/decisions.xml`
- `vibe.toml`
- `docs/vibe/governance.toml`
- `docs/vibe/macros.toml`

If this document and the canonical surfaces disagree, the canonical surfaces win.

## 1. Product Boundary

`vibestart` is an optional bootstrap/runtime product for VIBE.

It does not define a separate methodology.
It installs and adapts one VIBE methodology through two product profiles:
- `vibestart --core`
- `vibestart --deep`

If no explicit profile flag is provided, `vibestart` must ask for an explicit profile choice before continuing.

## 2. Shared Install Surface

Both profiles install the same canonical VIBE surfaces:
- `docs/requirements.xml`
- `docs/development-plan.xml`
- `docs/verification-plan.xml`
- `docs/knowledge-graph.xml`
- `docs/decisions.xml`
- `vibe.toml`
- `docs/vibe/governance.toml`
- `docs/vibe/macros.toml`
- `.vibestart/state/`

Both profiles may also install or adapt agent-environment surfaces as needed, but they must not change VIBE methodology semantics.

## 3. vibestart --core

`core` is the lighter bootstrap profile.

### Purpose

Provide a low-friction path to:
- canonical VIBE artifacts
- stable defaults
- readable policy/config surfaces
- immediate usability in a concrete repository

### What core installs

- the shared install surface
- the root manifest with `[bootstrap].profile = "core"`
- minimal runtime state directory
- profile-safe onboarding and first-run explanation
- environment adaptation required to operate the canonical VIBE surfaces in the current agent shell

### What core enables

- `implicit_vibe = true`
- normative defaults:
  - `autonomy = "guided"`
  - `agents = "single"`
- `memory = "xml"`
- `deployment = true`
- `calibration_hooks = true`

### What core keeps optional

- external docs/tool integrations
- database-backed memory
- richer multi-agent setup
- deeper deployment/integration scaffolding
- any experimental runtime surface

## 4. vibestart --deep

`deep` is the richer bootstrap profile.

### Purpose

Provide a longer-lived operating contour for projects that are ready to invest more in:
- integrations
- richer runtime adaptation
- extended memory and context tactics
- broader multi-agent readiness

### What deep installs

- everything from `core`
- the root manifest with `[bootstrap].profile = "deep"`
- expanded configuration comments and extension-ready surfaces
- placeholders or adapters for richer integrations when the current environment supports them
- deeper onboarding that explains what is now available beyond the core baseline

### What deep enables

`deep` still preserves one VIBE methodology and the same normative safety posture.

Normative defaults remain:
- `autonomy = "guided"`
- `agents = "single"`

What changes is product depth, not methodology semantics.

`deep` is allowed to prepare or expose richer optional surfaces such as:
- external integrations
- richer memory backends
- stronger multi-agent preparation
- deeper deployment-related setup

These surfaces remain optional until explicitly configured or supported by the current environment.

### Adoption paths

`deep` is allowed:
- from scratch
- as an upgrade path from `core`

## 5. Defaults and Policy Profiles

Unless explicitly overridden by profile-specific implementation details, `vibestart` must preserve these normative defaults on first install:

- `implicit_vibe = true`
- `autonomy = "guided"`
- `agents = "single"`
- recommendation confirmation token: `v`
- layout-safe recommendation alias: `м`

The product must not silently treat experimental surfaces as normative defaults.

Experimental surfaces currently include:
- `auto`
- `multi`
- `calibrate-apply`

## 6. What Remains Optional

Even after installation, these remain optional:
- `vibestart` itself, because VIBE can still be used directly through its canonical files
- external integrations
- non-XML memory backends
- environment-specific multi-agent capabilities
- deeper deployment surfaces
- experimental runtime surfaces

## 7. Onboarding Flow

The onboarding flow is deterministic.

### First install

1. Resolve profile choice:
   - explicit flag, or
   - explicit interactive prompt
2. Check whether the target already contains conflicting VIBE surfaces
3. Allow a dry-run path that explains the shared install surface without writing files
4. Install the shared VIBE surfaces only when the operator has selected a real write path
5. Apply the selected product profile
6. Explain what was installed
7. Explain active defaults
8. Explain what remains optional
9. Explain the next interaction model

### Profile switch

When switching between `core` and `deep`, `vibestart` must:
1. state the current profile
2. state the requested target profile
3. explain what new product surfaces are added or kept optional
4. preserve methodology continuity instead of resetting the project

## 8. First-Run Contract

The first-run contract is mandatory.

It must state:
- selected profile
- installed surfaces
- active defaults
- optional surfaces not enabled yet
- how plain requests are routed
- how guided recommendations can be accepted
- what the operator should do next

### Required first-run fields

- `profile`
- `installed_surfaces`
- `active_defaults`
- `optional_surfaces`
- `next_step`
- `recommendation_confirmation`

### Required behavior

- plain engineering requests route through VIBE implicitly
- guided mode explains the selected path
- `v` accepts the current recommendation bundle
- `м` is accepted as a layout-safe alias of `v`
- non-interactive runs must fail safely if no explicit profile is given
- dry-run must not write files
- existing VIBE surfaces must not be overwritten without an explicit force path

## 9. Example First-Run Contract

The exact wording can vary, but the contract must cover the same structure.

```text
vibestart profile: core

Installed:
- docs/*.xml
- vibe.toml
- docs/vibe/governance.toml
- docs/vibe/macros.toml
- .vibestart/state/

Active defaults:
- implicit_vibe = true
- autonomy = guided
- agents = single

Optional:
- external integrations
- richer memory backends
- multi-agent runtime surfaces
- experimental surfaces: auto, multi, calibrate-apply

Interaction model:
- plain engineering requests enter VIBE implicitly
- guided mode explains recommended paths
- type v or м to accept the current recommendation bundle

Next step:
- describe the task you want to work on, or invoke a specific macro explicitly
```

## 10. Language Rule

Canonical contract markup and structural labels remain in English.

Localized interaction aliases are allowed only as user-input tokens.
They do not change the canonical language of headings, field names, or protocol labels.

This includes:
- XML contract field names
- TOML keys
- structural section names used as machine-readable protocol surface

Human-facing explanatory prose may be localized.
Canonical structural markup may not.
