# GRACE to VIBE Mapping v0.1

## Status

Draft.

This document explains lineage, compatibility, migration intent, and deliberate divergences between GRACE and VIBE.

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

## 1. Why This Mapping Exists

VIBE is not presented as a GRACE rebrand.
It is a new methodology with its own public language and control model.

But VIBE is also not a zero-based invention.
It deliberately inherits and evolves strong GRACE ideas:
- contract-first engineering
- graph-first continuity
- top-down synthesis
- verification as an architectural surface
- governed autonomy

This document exists for four reasons:
- preserve attribution honestly
- make compatibility claims explicit
- help GRACE users migrate without guesswork
- show where VIBE intentionally diverges

## 2. Principle Mapping

| GRACE principle | VIBE continuation | What changed |
| :--- | :--- | :--- |
| Never Write Code Without a Contract | Contract-First Planning | VIBE keeps the contract-first stance, but moves the public user language from low-level planning/execution skills to macro contracts. |
| Knowledge Graph Is Always Current | Graph-first canonical model | VIBE keeps the graph as the primary knowledge spine, then strengthens it with deterministic projection rules and a broader graph-first orchestration role. |
| Top-Down Synthesis | Intent -> discover -> refine -> deliver | VIBE preserves top-down sequencing but replaces the older phase vocabulary with a macro language closer to user intent. |
| Verification Is Architecture | Verification Before Trust | VIBE keeps verification as a first-class architectural concern, then adds governance-driven review escalation and sync semantics. |
| Governed Autonomy (PCAM) | Traceable Autonomy + Adaptive Governance | VIBE keeps constrained autonomy, but formalizes more of the control logic at runtime level: routing, review choice, sync selection, experimental surfaces. |
| Semantic markup as navigable structure | Semantic Anchors | VIBE keeps the anchor idea broadly, but extends it from code navigation to the whole operational contour: docs, macros, governance, and owned artifacts. |

## 3. Artifact Mapping

| GRACE artifact | VIBE status | Mapping |
| :--- | :--- | :--- |
| `docs/requirements.xml` | retained | Still the requirements surface, but in VIBE it is explicitly a cleaned projection of clarified graph state rather than the birthplace of ideas. |
| `docs/development-plan.xml` | retained | Still the execution surface, now used to describe modules, phases, data flows, and methodology/product work itself. |
| `docs/verification-plan.xml` | retained | Still the trust surface, now expanded to cover routing, governance algebra, sync semantics, and config-policy verification. |
| `docs/knowledge-graph.xml` | retained and strengthened | Still the map of the system, but now promoted to primary orchestration continuity spine. |
| `docs/decisions.xml` | added as first-class canonical artifact | VIBE makes decision capture explicit as a committed architectural and process surface. |
| `docs/technology.xml` | not currently in VIBE core v0.1 | Deliberately not part of the current canonical set. It can return later, but is not required for the present framework draft. |
| `docs/specs/*` | rejected as canonical | VIBE explicitly rejects a mandatory side-bridge prose layer. |

## 4. Workflow Mapping

GRACE exposes more phase- and implementation-oriented commands.
VIBE exposes a macro-first public API.

### Public mapping

| GRACE capability | VIBE macro / surface | Mapping type |
| :--- | :--- | :--- |
| `$grace-plan` | `refine` | evolved |
| `$grace-verification` | `refine` + `deliver` + governance | split and evolved |
| `$grace-execute` | `deliver` | evolved |
| `$grace-multiagent-execute` | `deliver --multi` when allowed | absorbed into capability mode |
| `$grace-fix` | `fix` | evolved |
| `$grace-refresh` | `sync` reconcile phase | absorbed |
| `$grace-status` | `sync` + future status/report surfaces | partially absorbed |
| session continuity patterns | `resume` | evolved |
| no GRACE direct equivalent | `discover` | new first-class macro |
| no GRACE direct equivalent | `deploy` | new first-class macro |
| no GRACE direct equivalent | `vibe` | new top-level orchestrator |
| no GRACE direct equivalent | `calibrate` | new expert macro |

### Important note

VIBE compatibility is not command-name compatibility.

VIBE compatibility means:
- the same engineering intent can be represented without losing rigor
- graph, plan, and verification discipline remain strong
- contract and verification semantics remain legible
- autonomous work remains governed rather than ad hoc

## 5. What VIBE Deliberately Changes

These are not accidents. They are deliberate departures.

### 1. Macro-first public API

GRACE exposes a more phase-native tool vocabulary.
VIBE exposes:
- `discover`
- `refine`
- `deliver`
- `fix`
- `sync`
- `resume`
- `deploy`
- `vibe`

Reason:
- users think in intent and task shape more naturally than in framework phase names
- macro contracts are easier to route, recommend, and review as a public language

### 2. Implicit routing

GRACE is more explicit in its skill invocation model.
VIBE enables implicit `vibe` routing by default.

Reason:
- reduce user cognitive load
- keep methodology active even when the user speaks in plain engineering language

Constraint:
- implicit routing must still be deterministic and explainable

### 3. Deterministic runtime control

GRACE strongly constrains engineering behavior, but VIBE moves more of that control into explicit runtime contracts:
- deterministic router
- projection algebra ownership split
- deterministic review-selection algebra
- two-phase sync
- experimental surface labeling

Reason:
- VIBE is aiming at broader agent/runtime portability
- hidden heuristics would create shell-specific drift

### 4. Conservative normative defaults

GRACE already values governed execution.
VIBE makes this more explicit at the framework policy level:
- normative defaults: `guided`, `single`
- experimental surfaces: `auto`, `multi`, `calibrate-apply`

Reason:
- autonomy should not outrun proof of control

### 5. Graph-first anti-drift posture

GRACE already treats the graph as current.
VIBE pushes that further:
- idea starts in graph
- requirements are projected from clarified graph state
- plan and verification are projected from refined graph state
- drift is detected through layered redundancy, not avoided by pretending one view is enough

## 6. What VIBE Does Not Carry Forward Directly

| GRACE element | VIBE position |
| :--- | :--- |
| Original public command names | not preserved as the main public language |
| Mandatory prose bridge docs | rejected |
| Technology artifact as current core requirement | deferred |
| Purely sequential execution as the only serious path | expanded into `single` and controlled `multi` surfaces |

These are not incompatibilities by themselves.
They are surface changes around a preserved engineering substrate.

## 7. Migration Guidance for GRACE Projects

### Step 1. Preserve canonical docs

Keep:
- `docs/requirements.xml`
- `docs/development-plan.xml`
- `docs/verification-plan.xml`
- `docs/knowledge-graph.xml`

Add or normalize:
- `docs/decisions.xml`

### Step 2. Reinterpret, do not rewrite blindly

Map existing planning and verification intent into VIBE’s public macro language:
- planning-heavy work becomes `refine`
- execution-heavy work becomes `deliver`
- repair flows become `fix`
- refresh/drift correction becomes `sync`
- context recovery becomes `resume`

### Step 3. Make graph-first continuity explicit

If the GRACE project still treats requirements or plan as the practical birthplace of new work, shift that behavior so:
- idea enters the graph first
- projection happens through explicit guards

### Step 4. Add root and docs-level config surfaces

Introduce:
- `vibe.toml`
- `docs/vibe/governance.toml`
- `docs/vibe/macros.toml`

These do not replace canonical docs.
They make runtime control explicit and reviewable.

### Step 5. Start conservative

Recommended migration baseline:
- `guided`
- `single`
- implicit `vibe` allowed
- `auto`, `multi`, `calibrate-apply` treated as experimental until the project hardens its control surfaces

## 8. Compatibility Statement

VIBE is compatible with GRACE at the level of:
- engineering values
- graph-aware planning
- contract discipline
- verification discipline
- governed execution

VIBE is not a promise of:
- identical command names
- identical runtime ergonomics
- identical artifact set
- identical public UX

Compatibility is semantic and architectural, not cosmetic.

## 9. Credits and Lineage

GRACE deserves explicit credit for the substrate VIBE builds on:
- contract-first thinking
- graph-current discipline
- verification as architecture
- governed autonomy
- semantic navigation as a load-bearing structure

VIBE’s own contribution is the next layer:
- intent-native macro language
- deterministic runtime control surfaces
- graph-first projection model for broader orchestration
- adaptive governance
- explicit separation of normative defaults and experimental surfaces

## 10. Current Draft Boundary

This mapping document is accurate for the current draft state of VIBE.

It should evolve when any of these change materially:
- canonical artifact set
- macro vocabulary
- projection ownership model
- governance algebra
- vibestart product boundary
