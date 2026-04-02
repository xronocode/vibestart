# REPAIR Mode

Режим исправления проблем с установкой vibestart.

## Когда используется

| Условие | Режим |
|---------|-------|
| `.vibestart/` существует | REPAIR |
| `vs.project.toml` отсутствует | REPAIR |
| Отсутствуют файлы .vibestart/ | REPAIR |
| GRACE артефакты повреждены | REPAIR |
| AGENTS.md не совместим | REPAIR |
| Интеграции сломаны | REPAIR |

## Детектирование проблем

```python
def detect_problems(project_path):
    problems = []
    
    # Check 1: Отсутствующие файлы .vibestart/
    required_files = [
        ".vibestart/src/skills/vs-init/SKILL.md",
        ".vibestart/src/standards/architecture.md",
        ".vibestart/src/templates/requirements.xml"
    ]
    
    for file_path in required_files:
        full_path = project_path / file_path
        if not full_path.exists():
            problems.append({
                "type": "missing_framework_file",
                "path": file_path,
                "severity": "error"
            })
    
    # Check 2: Отсутствующие GRACE артефакты
    grace_files = [
        "docs/requirements.xml",
        "docs/knowledge-graph.xml",
        "docs/technology.xml",
        "docs/development-plan.xml",
        "docs/verification-plan.xml",
        "docs/decisions.xml"
    ]
    
    for file_path in grace_files:
        full_path = project_path / "docs" / file_path
        if not full_path.exists():
            problems.append({
                "type": "missing_grace_artifact",
                "path": f"docs/{file_path}",
                "severity": "warning"
            })
        else:
            # Проверка валидности XML
            if not is_valid_xml(full_path):
                problems.append({
                    "type": "invalid_xml",
                    "path": f"docs/{file_path}",
                    "severity": "error"
                })
    
    # Check 3: vs.project.toml отсутствует
    if not (project_path / "vs.project.toml").exists():
        problems.append({
            "type": "missing_config",
            "path": "vs.project.toml",
            "severity": "error"
        })
    
    # Check 4: AGENTS.md не совместим
    agents_md = project_path / "AGENTS.md"
    if agents_md.exists():
        content = agents_md.read_text()
        if "vibestart" not in content.lower() and "grace" not in content.lower():
            problems.append({
                "type": "agents_incompatible",
                "path": "AGENTS.md",
                "severity": "warning"
            })
    
    # Check 5: Интеграции сломаны
    config = load_vs_config(project_path / "vs.project.toml") if (project_path / "vs.project.toml").exists() else {}
    
    if config.get("features", {}).get("entire"):
        if not check_entire_health(project_path):
            problems.append({
                "type": "broken_integration",
                "integration": "entire",
                "severity": "warning"
            })
    
    if config.get("features", {}).get("conport"):
        if not check_conport_health(project_path):
            problems.append({
                "type": "broken_integration",
                "integration": "conport",
                "severity": "warning"
            })
    
    return problems
```

---

## Flow

### Шаг 1: Git Checkpoint Safety

```
[SKILL:vs-init] REPAIR mode: Creating safety checkpoint...

Creating safety tag: vs-init-backup-YYYYMMDD-HHMMSS
  → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init repair checkpoint"

If repair goes wrong, rollback with:
  git checkout vs-init-backup-YYYYMMDD-HHMMSS
```

---

### Шаг 2: Сканирование проблем

```
[SKILL:vs-init] REPAIR mode: Scanning for problems...

Detected problems:
  • missing_framework_file: .vibestart/src/skills/vs-init/SKILL.md (error)
  • missing_config: vs.project.toml (error)
  • missing_grace_artifact: docs/verification-plan.xml (warning)
  • broken_integration: entire (warning)

Total: 4 problems (2 errors, 2 warnings)
```

---

### Шаг 3: Исправление проблем

#### Проблема: missing_framework_file

```
Fixing: missing_framework_file

  File: .vibestart/src/skills/vs-init/SKILL.md
  Action: Restore from backup or reinstall
  
  ✓ Checking backup...
  ✓ Found in .vibestart/.backup/
  ✓ Restoring from backup
  
  If no backup:
  ✓ Reinstalling from vibestart repository
```

#### Проблема: missing_config

```
Fixing: missing_config

  File: vs.project.toml
  Action: Recreate from template
  
  ✓ Reading project metadata
  ✓ Detecting existing integrations
  ✓ Creating vs.project.toml from template
  
  Created:
    [project]
    name = "<project-name>"
    version = "0.1.0"
    mode = "lite"
    
    [features]
    grace = true
    conport = false
    entire = false
    
    [vibestart]
    version = "3.0.0"
    installed_at = "$TIMESTAMP"
```

#### Проблема: missing_grace_artifact

```
Fixing: missing_grace_artifact

  File: docs/verification-plan.xml
  Action: Create from template
  
  ✓ Reading template
  ✓ Creating docs/verification-plan.xml
```

#### Проблема: invalid_xml

```
Fixing: invalid_xml

  File: docs/knowledge-graph.xml
  Action: Try to fix or restore from backup
  
  ✓ Attempting to fix XML...
  ✗ Fix failed (malformed structure)
  
  ✓ Restoring from backup...
  ✓ Found backup: docs/.backup/knowledge-graph.xml.YYYYMMDD-HHMMSS
  ✓ Restored successfully
```

#### Проблема: agents_incompatible

```
Fixing: agents_incompatible

  File: AGENTS.md
  Action: Regenerate from fragments
  
  ✓ Backing up current AGENTS.md
  ✓ Reading vs.project.toml
  ✓ Loading fragments
  ✓ Generating new AGENTS.md
  
  Backup: AGENTS.md.backup.YYYYMMDD-HHMMSS
```

#### Проблема: broken_integration (Entire.io)

```
Fixing: broken_integration (entire)

  Action: Reinstall Entire.io integration
  
  ✓ Checking entire CLI...
  ✓ entire CLI installed (v1.2.0)
  
  ✓ Re-running: entire enable
  ✓ Verifying git hooks...
  ✓ Hooks reinstalled
  ✓ Verifying branch...
  ✓ Branch exists
  
  Entire.io integration repaired
```

#### Проблема: broken_integration (ConPort)

```
Fixing: broken_integration (conport)

  Action: Reinstall ConPort integration
  
  ✓ Checking ConPort CLI...
  ✓ ConPort CLI installed
  
  ✓ Checking MCP config...
  ✓ ConPort not in MCP config
  ✓ Adding ConPort to MCP config
  
  ✓ Checking Memory Bank...
  ✓ Memory Bank exists
  ✓ Connection verified
  
  ConPort integration repaired
```

---

### Шаг 4: Финальная проверка

```
[SKILL:vs-init] REPAIR mode: Verifying repairs...

Verifying fixed problems:
  ✓ missing_framework_file: FIXED
  ✓ missing_config: FIXED
  ✓ missing_grace_artifact: FIXED
  ✓ broken_integration: FIXED

Running verify-vibestart.sh:
  ✓ Framework integrity: PASS
  ✓ Skills integrity: PASS
  ✓ Templates integrity: PASS
  ✓ Fragments integrity: PASS
  ✓ GRACE artifacts: PASS
  ✓ Integrations: PASS

All problems resolved!
```

---

### Шаг 5: Вывод результата

```
╔═══════════════════════════════════════════════════════════════╗
║                    REPAIR COMPLETE                            ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Project: <project-name>                                      ║
║  Problems fixed: 4                                            ║
║                                                                ║
║  Repairs applied:                                             ║
║    ✓ Restored: .vibestart/src/skills/vs-init/SKILL.md         ║
║    ✓ Created: vs.project.toml                                 ║
║    ✓ Created: docs/verification-plan.xml                      ║
║    ✓ Reinstalled: Entire.io integration                       ║
║                                                                ║
║  Backups created:                                             ║
║    • AGENTS.md.backup.YYYYMMDD-HHMMSS                         ║
║    • docs/.backup/knowledge-graph.xml.YYYYMMDD-HHMMSS         ║
║                                                                ║
║  To rollback:                                                 ║
║    git checkout vs-init-backup-YYYYMMDD-HHMMSS                ║
║                                                                ║
║  Next steps:                                                  ║
║    • Review AGENTS.md                                         ║
║    • Run /grace-status to verify GRACE health                 ║
║    • Test integrations: entire status, conport status         ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

---

## Edge Cases

| Случай | Обработка |
|--------|-----------|
| Нет backup для файла | Восстановить из репозитория vibestart |
| XML не исправляется | Создать новый из шаблона, предупредить о потере данных |
| Интеграция не чинится | Предложить отключить интеграцию |
| Git не доступен | Продолжить без safety checkpoint с предупреждением |
| Много проблем (>10) | Предложить полную переустановку (INSTALL mode) |

---

## Откат (Rollback)

Если ремонт прошёл неудачно:

```bash
# Вариант 1: Git rollback
git checkout vs-init-backup-YYYYMMDD-HHMMSS

# Вариант 2: Ручной restore из backup
cp .vibestart/.backup/AGENTS.md.backup.YYYYMMDD-HHMMSS AGENTS.md
cp -r .vibestart/.backup/docs/.backup/*.xml.YYYYMMDD-HHMMSS docs/
```
