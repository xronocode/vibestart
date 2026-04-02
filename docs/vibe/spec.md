# VIBE Spec v0.1

## Status

Draft.

This document is a publishable, human-readable projection of the current VIBE framework state.

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

## 1. What VIBE Is

`VIBE` stands for `Verified Intent-Based Engineering`.

VIBE is an agent-agnostic methodology for intent-driven engineering. Its purpose is to reduce drift between user intent, canonical artifacts, code, verification, and runtime control behavior.

VIBE is not a zero-based invention. It preserves and extends proven practices from GRACE and adjacent agentic workflow tooling:
- graph-first continuity
- contract-first planning
- verification as architecture
- structured repair and synchronization
- session continuity and safe resume
- controlled parallel and multi-agent execution

VIBE does not define one shell, one model vendor, or one runtime. It defines a stable engineering grammar:
- a graph-first knowledge model
- deterministic projection rules
- a macro-first workflow language
- risk-and-evidence governance
- traceable autonomous execution

The macro layer is critical. VIBE exposes `discover`, `refine`, `deliver`, `fix`, `sync`, `resume`, `deploy`, and `vibe` as public workflow contracts so the operator does not need to manually orchestrate isolated phases to achieve an engineering goal. The system routes from the goal shape toward the appropriate path and drives the work toward closure instead of stopping at one low-level step.

VIBE also includes hooks for adaptive development. When the model, runtime harness, observability, and verification surface are strong enough, the same methodology can safely calibrate:
- `guided` toward `auto`
- `single` toward `multi`
- review sensitivity
- sync behavior
- policy tuning through controlled calibration

The operating surface is split deliberately:
- XML artifacts under `docs/` hold canonical knowledge
- `vibe.toml` and `docs/vibe/*.toml` hold active operating contracts and policy
- `.vibestart/state/` holds runtime state and operational exhaust only

`vibestart` is an optional bootstrap/runtime product that installs and adapts VIBE in a concrete repository and agent environment.

`vibestart` exposes two product profiles over one VIBE methodology:
- `core` for the lighter and more conservative operating baseline
- `deep` for a richer operational contour and stronger adaptive agentic development

## 2. Core Principles

VIBE is built on these principles:

| Principle | Meaning |
| :--- | :--- |
| Intent Awareness | Interpret the actual engineering intent, not only the literal wording of a request. |
| Context Awareness | Use project state, decisions, active work, drift signals, and verification posture as first-class inputs. |
| Adaptive Execution | Adjust workflow depth and path to task maturity, scale, and risk. |
| Constructive Friction | Refuse false clarity and force clarification when the work shape is still ambiguous. |
| Contract-First Planning | Define expected behavior and boundaries before implementation. |
| Verification Before Trust | Trust tests, traces, reviews, and evidence instead of fluent output. |
| Semantic Anchors | Keep code, docs, and operational artifacts navigable through stable structure and identifiers. |
| Adaptive Governance | Escalate review and sync based on risk signals, not ritual. |
| Traceable Autonomy | Permit autonomy only when control decisions remain explainable and inspectable. |
| Layered Redundancy | Repeat key knowledge only when the repeated view serves a different role and helps detect drift. |
| Config as Documentation | Keep configuration readable, commented, and reviewable as an operating contract. |
| Deterministic Control | Make routing, projection, review escalation, and sync semantics explicit and reproducible across runtimes. |

## 3. Canonical Artifact Model

Canonical project knowledge lives in `docs/`.

| Artifact | Role |
| :--- | :--- |
| `docs/knowledge-graph.xml` | Primary knowledge spine and orchestration continuity surface |
| `docs/requirements.xml` | Cleaned projection of clarified intent |
| `docs/development-plan.xml` | Execution surface: phases, steps, modules, tasks, write scopes |
| `docs/verification-plan.xml` | Trust surface: tests, traces, gates, review and verification logic |
| `docs/decisions.xml` | Committed architectural and process decisions |

Rules:
- ideas enter the system through the graph first
- requirements are not the birthplace of ideas
- no mandatory `docs/specs/` side-bridge exists
- projections must be deterministic enough that two compliant runtimes choose the same control path from the same observable state

## 4. Ontology and Projection

The graph is the semantic center of the methodology.

### Node classes

VIBE v0.1 uses these node classes:
- `intent`
- `feature`
- `work`
- `module`
- `verification`
- `decision`
- `deploy`

### Lifecycle stages

Primary stages:
- `captured`
- `clarified`
- `designed`
- `refined`
- `ready`
- `in_progress`
- `verified`
- `done`

Side states:
- `blocked`
- `deferred`
- `dropped`

### Projection ownership

Projection is intentionally split into two layers:

- ontology layer owns semantic invariants and maturity semantics
- macro layer owns executable projection controls

That means:
- the graph defines what maturity means
- the macro layer defines when and how projection is executed

For `refine`, the executable projection contract currently requires:
- `projection_mode = deterministic`
- `projection_source_of_truth = knowledge-graph`
- idempotent projection
- `requirements_projection_min_stage = clarified`
- `plan_projection_min_stage = designed`
- `verification_projection_min_stage = designed`
- `projection_conflict_policy = graph-first-until-committed`
- no implicit reverse projection

## 5. Workflow Language

VIBE exposes a macro-first public API.

### Public macros

- `discover`
- `refine`
- `deliver`
- `fix`
- `sync`
- `resume`
- `deploy`
- `vibe`

### Expert macro

- `calibrate`

Macros are the stable public workflow contracts.
Skills are lower-level implementation operators that may evolve while preserving macro semantics.

## 6. Macro Contracts

Each macro is expected to define:
- purpose
- lineage
- default autonomy
- default agent mode
- read set
- write set
- entry guard
- state transitions
- invariants

### `discover`

Purpose:
Capture and clarify intent in the graph until it is ready for structured refinement.

Normative defaults:
- autonomy: `guided`
- agents: `single`

Allowed but experimental:
- `auto`
- `multi`

Transitions:
- `captured -> clarified`
- `clarified -> designed`

### `refine`

Purpose:
Project clarified intent into executable development and verification artifacts.

Normative defaults:
- autonomy: `guided`
- agents: `single`

Allowed but experimental:
- `auto`
- `multi`

Transitions:
- `designed -> refined`
- `refined -> ready`

### `deliver`

Purpose:
Implement ready work under verification-first execution, adaptive review, and sync discipline.

Normative defaults:
- autonomy: `guided`
- agents: `single`

Allowed but experimental:
- `auto`
- `multi`

Transitions:
- `ready -> in_progress`
- `in_progress -> verified`
- `verified -> done`

### `fix`

Purpose:
Repair mismatches and regressions without hiding structural drift.

Normative defaults:
- autonomy: `guided`
- agents: `single`

Allowed but experimental:
- `auto`
- `multi`

Transitions:
- `done -> in_progress`
- `in_progress -> verified`
- `verified -> done`

Invariant:
- repair is not closed until `review-after-fix` is satisfied

### `sync`

Purpose:
Reconcile canonical artifacts with reality and clean VIBE-owned operational exhaust.

Normative defaults:
- autonomy: `guided`
- agents: `single`

Allowed but experimental:
- `auto`

Two-phase model:
- `reconcile -> done`
- `reconcile -> cleanup -> done`

Cleanup is allowed only when VIBE-owned operational exhaust is present.
Unknown artifacts are reported, not mutated.

### `resume`

Purpose:
Recover current work position and recommend the next safe step.

### `deploy`

Purpose:
Move verified work into an explicit local or quick-cloud deployment path.

### `vibe`

Purpose:
Top-level orchestrator that routes ordinary engineering requests into the correct macro path.

## 7. Routing Model

Implicit VIBE is enabled by default.

That means ordinary engineering requests are routed through `vibe` unless a more explicit macro is invoked.

Routing mode is deterministic.

Current routing precedence:
1. explicit macro
2. resume request
3. bug or failed verification
4. explicit deploy request
5. ready work
6. designed work
7. captured or ambiguous intent
8. fallback discover

Tie-break rule:
- choose the less autonomous valid path

Guided mode must explain the selected route.

## 8. Execution Modes and Stability

VIBE distinguishes normative defaults from experimental but allowed surfaces.

### Normative defaults

- autonomy: `guided`
- agents: `single`

### Experimental surfaces

- `auto`
- `multi`
- `calibrate-apply`

Experimental does not mean forbidden.
It means the path is allowed but not yet the normative baseline of the framework.

## 9. Governance

Governance is risk-and-evidence based.
Elapsed time is explicitly not a primary signal.

### Signals

Current signal set includes:
- files changed
- modules touched
- lines changed
- contract or API change
- security change
- dependency or deploy-shape change
- verification gap
- multi-agent complexity
- artifact drift

### Decision function

Governance selection is deterministic.

Current precedence:
1. security change
2. artifact drift
3. contract or API change
4. dependency or deploy change
5. multi-agent complexity
6. scale thresholds
7. review streak

Rules:
- tie-breaks escalate upward
- unknown signals escalate rather than being ignored
- module scope dominates file scope, which dominates line count

### Review levels

- `quick`
- `scoped`
- `full`

### Review-after-fix

`fix` has an explicit `review-after-fix` hook.

Defaults:
- enabled
- baseline `quick`
- uses the same risk engine as the main governance model
- required before a repair is considered closed

### Sync model

`sync` is not one opaque operation.

It is a two-phase control flow:
1. `reconcile` canonical artifacts
2. optionally `cleanup` only VIBE-owned operational exhaust

Cleanup must never mutate canonical docs surfaces.

### Recommendation confirmation

Guided-mode recommendation acceptance uses a minimal explicit token:
- primary token: `v`
- layout-safe alias: `м`

Semantics:
- accept the current recommendation bundle only
- do not trigger arbitrary hidden actions

## 10. Configuration Surfaces

VIBE keeps configuration and runtime state separated.

| Surface | Role |
| :--- | :--- |
| `vibe.toml` | Root manifest and active project-level defaults |
| `docs/vibe/governance.toml` | Human-facing detailed governance policy |
| `docs/vibe/macros.toml` | Human-facing macro behavior and stability rules |
| `.vibestart/state/*` | Runtime state, logs, archive, counters, and operational exhaust |

Configuration is expected to be:
- explicit
- commented
- reviewable
- free of runtime secrets

## 11. VIBE and vibestart

VIBE is the methodology.
`vibestart` is the optional product layer.

`vibestart` profiles:
- `core`
- `deep`

Rules:
- profile choice is explicit
- `core` and `deep` are product profiles, not separate methodologies
- VIBE remains usable without vibestart

## 12. Current Boundary of v0.1

Locked enough to publish as a draft:
- principles
- graph-first canonical model
- macro vocabulary
- deterministic router
- projection ownership split
- risk-and-evidence governance
- split sync semantics
- conservative normative defaults

Still intentionally draft:
- full `vibestart` product mapping
- deep integration layer
- long-run policy calibration practice
- broader migration documentation from adjacent frameworks

## 13. Lineage

VIBE is a new methodology, but not a zero-based invention.

It evolves proven ideas from:
- GRACE principles around contracts, verification, graph-aware engineering, and governed execution
- brainstorming and workflow discipline patterns from adjacent agentic systems
- memory and continuity patterns that improve context carry-over across sessions

Lineage matters for compatibility and attribution.
Primary value proposition still belongs to VIBE itself, not to the names of prior systems.
