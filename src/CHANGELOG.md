# Changelog

All notable changes to vibestart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2026-03-23

### Changed

#### Skills Consolidation
- **vs-init** — Now includes integrated AGENTS.md rendering (Phase 5/6)
  - Rendering happens automatically during initialization
  - No need for separate vs-render command
  - Re-run vs-init after configuration changes to regenerate AGENTS.md

### Removed

#### Redundant Skills
- **vs-status** — Removed (use `grace-status` instead)
  - `grace-status` provides GRACE-specific health checks
  - Framework-level checks integrated into `vs-init`
- **vs-refresh** — Removed (use `grace-refresh` instead)
  - `grace-refresh` provides more sophisticated sync with targeted/full modes
- **vs-render** — Removed (integrated into `vs-init`)
  - AGENTS.md generation now happens automatically during initialization
  - Rendering triggered by: clean install, config changes, conflict resolution

### Migration Guide

#### From v2.0.0
No migration needed. Simply use:
- `/grace-status` instead of `/vs-status`
- `/grace-refresh` instead of `/vs-refresh`
- `/vs-init` for AGENTS.md generation (no separate `/vs-render` needed)

---

## [2.0.0] - 2026-03-23

### Added

#### Architecture
- **Framework structure** — separate from project structure
- **standards/** directory with XML standards
- **templates/** directory with XML templates
- **fragments/** directory for AGENTS.md generation
- **skills/** directory with vs-* and grace-* skills
- **macros/** directory with XML macros
- **support/** directory for auxiliary files

#### Standards
- **grace** — GRACE methodology (enhanced from grace-marketplace)
- **architecture** — Layer dependencies and boundaries
- **error-handling** — Logging and error management rules
- **git-workflow** — Commit format and branching conventions
- **agent-transparency** — Action context protocol (6 categories)
- **compatibility** — Skill conflict detection and resolution

#### Skills (vs-*)
- **vs-init** — Smart initialization with:
  - Framework integrity check (7 checks)
  - Conflict detection (6 types)
  - Conflict resolution (3 strategies)
  - Migration v1.0 → v2.0
  - Missing pieces detection
  - Integrated AGENTS.md rendering (vs-render functionality merged)

#### Skills (grace-*)
- Enhanced versions from grace-marketplace
- Integrated with vibestart framework
- Added session logging support
- Added agent transparency support

#### Conflict Detection
- CONF-001: Duplicate skills from different sources
- CONF-002: AGENTS.md manual vs generated
- CONF-003: Multiple configuration files
- CONF-004: GRACE artifacts format mismatch
- CONF-005: Session log format mismatch
- CONF-006: Incomplete gitignore

#### Integrity Checks
- INT-001: Framework installation
- INT-002: Global configuration
- INT-003: Standards integrity
- INT-004: Templates integrity
- INT-005: Skills integrity
- INT-006: Fragments integrity
- INT-007: Project files

#### Agent Support
- Kilo Code (P1) — full support
- Cursor (P1) — full support
- Claude Code (P2) — basic support
- Windsurf (P3) — on request
- Aider (P3) — on request

#### Templates
- development-plan.xml.template
- requirements.xml.template
- knowledge-graph.xml.template
- verification-plan.xml.template
- technology.xml.template
- decisions.xml.template

#### Support Files
- SESSION_LOG.md.template
- TASK_LOG.md.template
- Agent-specific configurations

### Changed

#### From v1.0
- AGENTS.md manual editing → generated from fragments
- Single project structure → framework + project separation
- No versioning → skills-registry.json tracking
- No conflict detection → 6 types detected
- No migration → automatic v1.0 → v2.0

#### From grace-marketplace
- grace-* skills enhanced with vibestart integration
- Added session logging support
- Added agent transparency protocol
- Added conflict detection
- Added templates

### Removed
- Python CLI (not needed, agent executes skills directly)

### Migration Guide

#### From v1.0
```
/vs-init --migrate
```

Agent will:
1. Backup v1.0 files
2. Create vs.project.toml from AGENTS.md analysis
3. Convert docs/*.xml to v2.0 format
4. Generate new AGENTS.md from fragments
5. Create missing files

#### From grace-marketplace
```
/vs-init
```

Agent will:
1. Detect existing grace-* skills
2. Offer resolution options
3. Backup originals if replacing
4. Install vibestart v2.0 skills

---

## [1.0.0] - 2026-03-22

### Added
- Initial AGENTS.md with GRACE rules
- Basic session management
- Semantic markup conventions
- GRACE macros (g-init, g-feature, g-drift, g-fix, g-commit)
