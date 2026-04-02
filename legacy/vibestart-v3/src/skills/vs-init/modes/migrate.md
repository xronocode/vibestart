# MIGRATE Mode

Режим миграции с v1.x на v3.x.

## Когда используется

| Условие | Режим |
|---------|-------|
| `vs.project.toml` существует | MIGRATE |
| Версия = 1.x | MIGRATE |
| `.vibestart/` имеет старую структуру | MIGRATE |

## Отличия v1.x → v3.x

| Аспект | v1.x | v3.x | Изменение |
|--------|------|------|-----------|
| **Структура** | `.vibestart/framework/` | `.vibestart/src/` | Реорганизация |
| **Режимы** | Только INSTALL | INSTALL/UPDATE/REPAIR/MIGRATE/REFRESH | +4 режима |
| **Установка** | Один сценарий | LITE / ADVANCED | +2 режима |
| **Интеграции** | Нет | Entire.io + ConPort | +Интеграции |
| **Конфликты** | Нет детектирования | 6 типов | +Детектирование |
| **Тесты** | Нет | Bats тесты | +Тестирование |

---

## Flow

### Шаг 1: Git Checkpoint Safety

```
[SKILL:vs-init] MIGRATE mode: Creating full backup...

Creating full backup:
  ✓ Backing up .vibestart/ → .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/
  ✓ Backing up vs.project.toml
  ✓ Backing up AGENTS.md
  ✓ Backing up docs/*.xml

Safety tag: vs-init-backup-YYYYMMDD-HHMMSS
  → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init migration checkpoint"

If migration goes wrong, rollback with:
  git checkout vs-init-backup-YYYYMMDD-HHMMSS
```

---

### Шаг 2: Чтение текущей конфигурации v1.x

```
[SKILL:vs-init] MIGRATE mode: Reading v1.x configuration...

Current v1.x configuration:
  • Version: 1.2.0
  • Framework path: .vibestart/framework/
  • AGENTS.md: monolithic (not from fragments)
  • GRACE artifacts: v1 schema
  • Integrations: none
```

---

### Шаг 3: Миграция структуры

```
[SKILL:vs-init] MIGRATE mode: Migrating structure...

Migrating .vibestart/ structure:

  Old structure:
    .vibestart/framework/src/skills/
    .vibestart/framework/src/standards/
    .vibestart/framework/src/templates/
    .vibestart/framework/src/fragments/

  New structure:
    .vibestart/src/skills/
    .vibestart/src/standards/
    .vibestart/src/templates/
    .vibestart/src/fragments/

  Moving files:
    ✓ .vibestart/framework/src/ → .vibestart/src/
    ✓ Removing old framework/ directory
```

---

### Шаг 4: Миграция vs.project.toml

```
[SKILL:vs-init] MIGRATE mode: Migrating vs.project.toml...

Old v1.x format:
  [framework]
  version = "1.2.0"
  skills_path = ".vibestart/framework/src/skills"

New v3.x format:
  [project]
  name = "<project-name>"
  version = "0.1.0"
  mode = "lite"
  
  [features]
  grace = true
  conport = false
  entire = false
  
  [integrations.entire]
  enabled = false
  
  [integrations.conport]
  enabled = false
  
  [vibestart]
  version = "3.0.0"
  installed_at = "$TIMESTAMP"
  migrated_from = "1.2.0"

Migration complete.
```

---

### Шаг 5: Миграция GRACE артефактов

```
[SKILL:vs-init] MIGRATE mode: Migrating GRACE artifacts...

Migrating docs/*.xml:

  docs/requirements.xml:
    ✓ Extracting use cases (UC-*)
    ✓ Extracting decisions (D-*)
    ✓ Extracting constraints
    ✓ Extracting glossary
    ✓ Creating new schema with preserved data
  
  docs/decisions.xml:
    ✓ Extracting decisions (D-*)
    ✓ Preserving review sections
    ✓ Recalculating statistics
  
  docs/knowledge-graph.xml:
    ✓ Extracting nodes (M-*)
    ✓ Extracting edges
    ✓ Validating references
    ✓ Recalculating layers
  
  docs/development-plan.xml:
    ✓ Extracting modules (M-*)
    ✓ Extracting data flows (DF-*)
    ✓ Preserving implementation order
  
  docs/verification-plan.xml:
    ✓ Extracting test cases
    ✓ Preserving verification entries
  
  docs/technology.xml:
    ✓ Extracting technology decisions
    ✓ Preserving stack information

All GRACE artifacts migrated to v3.x schema.
```

---

### Шаг 6: Миграция AGENTS.md

```
[SKILL:vs-init] MIGRATE mode: Migrating AGENTS.md...

Old v1.x: Monolithic file
New v3.x: Generated from fragments

Steps:
  ✓ Backing up AGENTS.md → AGENTS.md.backup.YYYYMMDD-HHMMSS
  ✓ Analyzing existing content
  ✓ Extracting custom sections
  ✓ Loading v3.x fragments
  ✓ Generating new AGENTS.md from fragments
  ✓ Appending custom sections (if any)

New AGENTS.md generated.
```

---

### Шаг 7: Миграция интеграций

```
[SKILL:vs-init] MIGRATE mode: Migrating integrations...

v1.x had no integrations.

Setting up v3.x integrations structure:
  ✓ Creating src/skills/vs-init/integrations/
  ✓ Creating src/fragments/features/
  ✓ Preparing for Entire.io (optional)
  ✓ Preparing for ConPort (optional)

To enable integrations later:
  /vs-init --add-entire
  /vs-init --add-conport
```

---

### Шаг 8: Финальная проверка

```
[SKILL:vs-init] MIGRATE mode: Verifying migration...

Verifying migrated files:
  ✓ .vibestart/src/ structure
  ✓ vs.project.toml (v3.x format)
  ✓ AGENTS.md (from fragments)
  ✓ docs/*.xml (v3.x schema)

Running verify-vibestart.sh:
  ✓ Framework integrity: PASS
  ✓ Skills integrity: PASS
  ✓ Templates integrity: PASS
  ✓ Fragments integrity: PASS
  ✓ GRACE artifacts: PASS
  ✓ Migration complete: PASS
```

---

### Шаг 9: Вывод результата

```
╔═══════════════════════════════════════════════════════════════╗
║                    MIGRATION COMPLETE                         ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Project: <project-name>                                      ║
║  Migrated: v1.2.0 → v3.0.0                                    ║
║                                                                ║
║  Migration applied:                                           ║
║    ✓ Structure: .vibestart/framework/ → .vibestart/src/       ║
║    ✓ Config: vs.project.toml v1 → v3 format                   ║
║    ✓ GRACE: XML artifacts migrated to v3 schema               ║
║    ✓ AGENTS.md: Monolithic → fragments                        ║
║                                                                ║
║  Backup location:                                             ║
║    .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/                ║
║    AGENTS.md.backup.YYYYMMDD-HHMMSS                           ║
║                                                                ║
║  To rollback:                                                 ║
║    git checkout vs-init-backup-YYYYMMDD-HHMMSS                ║
║                                                                ║
║  Next steps:                                                  ║
║    • Review AGENTS.md for new structure                       ║
║    • Review docs/*.xml for migrated data                      ║
║    • Consider enabling integrations:                          ║
║      - /vs-init --add-entire (session audit)                  ║
║      - /vs-init --add-conport (long-term memory)              ║
║    • Run /grace-status to verify GRACE health                 ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## Migration Report

Создаётся файл: `docs/.backup/migration-report-YYYYMMDD-HHMMSS.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<MigrationReport TIMESTAMP="2026-03-27T14:30:22Z">

  <Summary>
    <source-version>1.2.0</source-version>
    <target-version>3.0.0</target-version>
    <files-migrated>8</files-migrated>
    <elements-preserved>156</elements-preserved>
    <warnings>2</warnings>
    <errors>0</errors>
  </Summary>

  <FileMigrations>
    <File name="requirements.xml">
      <status>migrated</status>
      <use-cases-preserved>12</use-cases-preserved>
      <decisions-preserved>5</decisions-preserved>
      <constraints-preserved>8</constraints-preserved>
    </File>
    <File name="decisions.xml">
      <status>migrated</status>
      <decisions-preserved>8</decisions-preserved>
    </File>
    <File name="knowledge-graph.xml">
      <status>migrated</status>
      <nodes-preserved>25</nodes-preserved>
      <edges-preserved>42</edges-preserved>
    </File>
  </FileMigrations>

  <Warnings>
    <warning>Unknown element &lt;customMetadata&gt; moved to LegacyData</warning>
    <warning>Orphaned edge removed: edge-123</warning>
  </Warnings>

  <RollbackInstructions>
    <step-1>To rollback: cp .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/* .</step-1>
    <step-2>Or use git: git checkout vs-init-backup-YYYYMMDD-HHMMSS</step-2>
  </RollbackInstructions>

</MigrationReport>
```

---

## Edge Cases

| Случай | Обработка |
|--------|-----------|
| Malformed XML | Abort migration, offer fresh start |
| Missing required attributes | Generate new ID with prefix `MIGRATED-` |
| Duplicate IDs across files | Prefix with file type: `REQ-UC-001` |
| Circular references in graph | Break cycle, add warning |
| External file references to missing files | Remove reference, add warning |
| Very large files (>1MB) | Warn user, offer partial migration |
| Non-UTF-8 encoding | Convert to UTF-8, log conversion |

---

## Откат (Rollback)

Если миграция прошла неудачно:

```bash
# Вариант 1: Git rollback
git checkout vs-init-backup-YYYYMMDD-HHMMSS

# Вариант 2: Ручной restore из backup
cp -r .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/.vibestart/* .vibestart/
cp .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/vs.project.toml .
cp .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/AGENTS.md .
cp -r .vibestart/.backup/migrate-YYYYMMDD-HHMMSS/docs/* docs/
```
