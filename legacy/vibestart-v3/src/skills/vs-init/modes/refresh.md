# REFRESH Mode

Режим перегенерации артефактов vibestart.

## Когда используется

| Условие | Режим |
|---------|-------|
| `.vibestart/` существует | REFRESH |
| `vs.project.toml` существует | REFRESH |
| Версия = текущей (3.0.0) | REFRESH |
| Проблем не обнаружено | REFRESH |
| Пользователь запросил перегенерацию | REFRESH |

## Что делает REFRESH

| Артефакт | Действие |
|----------|----------|
| **vs.project.toml** | Не изменяется (сохраняется) |
| **AGENTS.md** | Перегенерируется из фрагментов |
| **docs/*.xml** | Не изменяются (сохраняются) |
| **Интеграции** | Проверяются, не перезапускаются |

---

## Flow

### Шаг 1: Git Checkpoint Safety

```
[SKILL:vs-init] REFRESH mode: Creating safety checkpoint...

Creating safety tag: vs-init-backup-YYYYMMDD-HHMMSS
  → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init refresh checkpoint"

If refresh goes wrong, rollback with:
  git checkout vs-init-backup-YYYYMMDD-HHMMSS
```

---

### Шаг 2: Чтение текущей конфигурации

```
[SKILL:vs-init] REFRESH mode: Reading configuration...

Current configuration:
  • Version: 3.0.0
  • Mode: advanced
  • Installed at: 2026-03-20T10:30:00Z
  • Integrations:
    - Entire.io: enabled
    - ConPort: enabled
```

---

### Шаг 3: Backup AGENTS.md

```
[SKILL:vs-init] REFRESH mode: Backing up AGENTS.md...

Creating backup:
  ✓ AGENTS.md → AGENTS.md.backup.YYYYMMDD-HHMMSS
```

---

### Шаг 4: Перегенерация AGENTS.md

```
[SKILL:vs-init] REFRESH mode: Regenerating AGENTS.md...

Loading fragments:
  ✓ core/grace-intro.md
  ✓ core/session-management.md
  ✓ core/agent-transparency.md
  ✓ core/error-handling.md
  ✓ core/git-workflow.md
  ✓ features/entire-session-capture.md (Entire.io enabled)
  ✓ features/conport-memory.md (ConPort enabled)
  ✓ process/design-first.md
  ✓ process/batch-mode.md

Generating AGENTS.md:
  ✓ Combining fragments
  ✓ Replacing placeholders
  ✓ Writing to AGENTS.md

AGENTS.md regenerated.
```

---

### Шаг 5: Проверка GRACE артефактов

```
[SKILL:vs-init] REFRESH mode: Checking GRACE artifacts...

Checking docs/*.xml:
  ✓ docs/requirements.xml (no changes needed)
  ✓ docs/technology.xml (no changes needed)
  ✓ docs/knowledge-graph.xml (no changes needed)
  ✓ docs/development-plan.xml (no changes needed)
  ✓ docs/verification-plan.xml (no changes needed)
  ✓ docs/decisions.xml (no changes needed)

All GRACE artifacts are up-to-date.
```

---

### Шаг 6: Проверка интеграций

```
[SKILL:vs-init] REFRESH mode: Checking integrations...

Entire.io:
  ✓ CLI installed (v1.2.0)
  ✓ Git hooks exist
  ✓ Branch entire/checkpoints/v1 exists
  ✓ Integration healthy

ConPort:
  ✓ CLI installed
  ✓ MCP configured
  ✓ Memory Bank exists
  ✓ Integration healthy
```

---

### Шаг 7: Финальная проверка

```
[SKILL:vs-init] REFRESH mode: Verifying refresh...

Verifying refreshed files:
  ✓ AGENTS.md (regenerated)
  ✓ vs.project.toml (preserved)
  ✓ docs/*.xml (preserved)

Running verify-vibestart.sh:
  ✓ Framework integrity: PASS
  ✓ Skills integrity: PASS
  ✓ Templates integrity: PASS
  ✓ Fragments integrity: PASS
  ✓ GRACE artifacts: PASS
  ✓ Integrations: PASS
```

---

### Шаг 8: Вывод результата

```
╔═══════════════════════════════════════════════════════════════╗
║                    REFRESH COMPLETE                           ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Project: <project-name>                                      ║
║  Mode: advanced                                               ║
║                                                                ║
║  Refreshed:                                                   ║
║    ✓ AGENTS.md (regenerated from fragments)                   ║
║                                                                ║
║  Preserved:                                                   ║
║    ✓ vs.project.toml                                          ║
║    ✓ docs/*.xml (6 files)                                     ║
║    ✓ Integrations (Entire.io, ConPort)                        ║
║                                                                ║
║  Backup:                                                      ║
║    AGENTS.md.backup.YYYYMMDD-HHMMSS                           ║
║                                                                ║
║  To rollback:                                                 ║
║    cp AGENTS.md.backup.YYYYMMDD-HHMMSS AGENTS.md              ║
║    Or: git checkout vs-init-backup-YYYYMMDD-HHMMSS            ║
║                                                                ║
║  Next steps:                                                  ║
║    • Review regenerated AGENTS.md                             ║
║    • Run /grace-status to verify GRACE health                 ║
║    • Start working with /grace-plan or /grace-ask             ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## Когда использовать REFRESH

| Сценарий | REFRESH |
|----------|---------|
| Изменились фрагменты vibestart | ✅ Да |
| Пользователь изменил vs.project.toml | ✅ Да |
| Нужно обновить AGENTS.md после изменения конфигурации | ✅ Да |
| GRACE артефакты устарели | ❌ Нет (используй grace-refresh) |
| Интеграции сломаны | ❌ Нет (используй REPAIR) |
| Версия vibestart устарела | ❌ Нет (используй UPDATE) |

---

## Отличия от других режимов

| Режим | AGENTS.md | docs/*.xml | vs.project.toml | Интеграции |
|-------|-----------|------------|-----------------|------------|
| **INSTALL** | Создаётся | Создаются | Создаётся | Настраиваются |
| **UPDATE** | Обновляется | Не изменяются | Обновляется | Проверяются |
| **REPAIR** | Перегенерируется | Исправляются | Создаётся (если нет) | Переустанавливаются |
| **MIGRATE** | Перегенерируется | Мигрируются | Мигрируется | Не изменяются |
| **REFRESH** | Перегенерируется | Не изменяются | Не изменяется | Проверяются |

---

## Edge Cases

| Случай | Обработка |
|--------|-----------|
| Фрагменты отсутствуют | Переключиться на REPAIR mode |
| AGENTS.md не был создан ранее | Создать новый (как в INSTALL) |
| Интеграции отключены в vs.project.toml | Не включать фрагменты интеграций |
| Git не доступен | Продолжить без safety checkpoint с предупреждением |
| Пользователь вручную редактировал AGENTS.md | Предупредить, что изменения будут потеряны |

---

## Откат (Rollback)

Если refresh прошёл неудачно:

```bash
# Вариант 1: Git rollback
git checkout vs-init-backup-YYYYMMDD-HHMMSS

# Вариант 2: Ручной restore из backup
cp AGENTS.md.backup.YYYYMMDD-HHMMSS AGENTS.md
```
