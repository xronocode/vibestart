# Conflicts Detection

Детектирование 6 типов конфликтов при установке vibestart.

## Обзор

| Тип | Название | Что детектируем |
|-----|----------|-----------------|
| **CONF-001** | AGENTS.md exists | Существует ли AGENTS.md |
| **CONF-002** | GRACE artifacts exist | Существуют ли docs/*.xml |
| **CONF-003** | MCP servers configured | Настроены ли другие MCP серверы |
| **CONF-004** | Entire.io installed | Установлен ли Entire.io |
| **CONF-005** | ConPort installed | Установлен ли ConPort |
| **CONF-006** | Git hooks exist | Существуют ли Git хуки |

---

## CONF-001: AGENTS.md exists

### Детектирование

```python
def check_agents_conflict(project_path):
    agents_file = project_path / "AGENTS.md"
    
    if not agents_file.exists():
        return {"conflict": False}
    
    content = agents_file.read_text()
    
    # Проверяем содержимое
    if "vibestart" in content.lower() or "grace" in content.lower():
        return {
            "conflict": True,
            "type": "existing-vibestart",
            "severity": "warning",
            "message": "AGENTS.md уже содержит vibestart/GRACE инструкции"
        }
    
    return {
        "conflict": True,
        "type": "external-agents",
        "severity": "error",
        "message": "AGENTS.md уже существует с другими инструкциями"
    }
```

### Вывод

```
⚠️ Конфликт: AGENTS.md уже существует

Тип: existing-vibestart / external-agents
Серьёзность: warning / error

Варианты:
  [1] Backup + замена (рекомендуется)
  [2] Merge (ручное вмешательство)
  [3] Пропустить
```

---

## CONF-002: GRACE artifacts exist

### Детектирование

```python
def check_grace_artifacts_conflict(project_path):
    docs_dir = project_path / "docs"
    grace_files = [
        "requirements.xml",
        "technology.xml", 
        "knowledge-graph.xml",
        "development-plan.xml",
        "verification-plan.xml",
        "decisions.xml"
    ]
    
    existing = [f for f in grace_files if (docs_dir / f).exists()]
    
    if not existing:
        return {"conflict": False}
    
    # Проверяем версию GRACE
    versions = check_grace_versions(docs_dir, existing)
    
    return {
        "conflict": True,
        "type": "existing-grace",
        "severity": "info",
        "message": f"GRACE артефакты уже существуют: {', '.join(existing)}",
        "details": {
            "existing_files": existing,
            "versions": versions,
            "last_modified": get_last_modified(docs_dir)
        }
    }
```

### Вывод

```
ℹ️ Информация: GRACE артефакты уже существуют

Найдены файлы:
  ✅ docs/requirements.xml
  ✅ docs/knowledge-graph.xml
  ✅ docs/technology.xml

Варианты:
  [1] Сохранить и обновить (рекомендуется)
  [2] Заменить полностью
  [3] Пропустить
```

---

## CONF-003: MCP servers configured

### Детектирование

```python
def check_mcp_conflict(project_path):
    # Проверяем конфиги разных агентов
    mcp_configs = [
        project_path / ".claude" / "settings.json",
        project_path / ".kilocode" / "mcp_settings.json",
        project_path / ".cursor" / "mcp.json",
        Path.home() / ".claude" / "claude_desktop_config.json",
    ]
    
    existing_servers = []
    
    for config_path in mcp_configs:
        if config_path.exists():
            config = json.load(open(config_path))
            servers = config.get("mcpServers", {})
            
            for name, server_config in servers.items():
                # Проверяем на конфликты с ConPort
                if "conport" in name.lower() or "memory" in name.lower():
                    existing_servers.append({
                        "name": name,
                        "config_path": str(config_path),
                        "server": server_config
                    })
    
    if not existing_servers:
        return {"conflict": False}
    
    return {
        "conflict": True,
        "type": "existing-mcp",
        "severity": "warning",
        "message": "Обнаружены другие MCP серверы памяти",
        "details": {
            "existing_servers": existing_servers
        }
    }
```

### Вывод

```
⚠️ Конфликт: Обнаружены другие MCP серверы памяти

Найдено:
  • memory-server (в .claude/settings.json)
  • conport-old (в .kilocode/mcp_settings.json)

Варианты:
  [1] Отключить старые, включить ConPort
  [2] Оставить старые, ConPort не включать
  [3] Ручная настройка
```

---

## CONF-004: Entire.io installed

### Детектирование

```python
def check_entire_conflict(project_path):
    # Проверяем entire CLI
    entire_installed = shutil.which("entire") is not None
    
    # Проверяем хуки
    hooks_dir = project_path / ".git" / "hooks"
    entire_hooks = [
        hooks_dir / "post-commit",
        hooks_dir / "pre-push"
    ]
    hooks_installed = all(h.exists() for h in entire_hooks)
    
    # Проверяем ветку checkpoints
    result = subprocess.run(["git", "branch", "-a"], capture_output=True, text=True)
    branch_exists = "entire/checkpoints/v1" in result.stdout
    
    if not entire_installed:
        return {"conflict": False}
    
    return {
        "conflict": True,
        "type": "existing-entire",
        "severity": "info",
        "message": "Entire.io уже установлен",
        "details": {
            "cli_installed": entire_installed,
            "hooks_installed": hooks_installed,
            "branch_exists": branch_exists,
            "cli_version": get_entire_version()
        }
    }
```

### Вывод

```
ℹ️ Информация: Entire.io уже установлен

Статус:
  ✅ entire CLI (v1.2.0)
  ✅ Git хуки
  ✅ Ветка entire/checkpoints/v1

Варианты:
  [1] Пропустить (рекомендуется)
  [2] Переустановить
  [3] Проверить версию
```

---

## CONF-005: ConPort installed

### Детектирование

```python
def check_conport_conflict(project_path):
    # Проверяем ConPort CLI
    conport_installed = shutil.which("conport") is not None
    
    # Проверяем MCP конфиг
    mcp_config = get_mcp_config(project_path)
    conport_in_mcp = "conport" in mcp_config.get("mcpServers", {})
    
    # Проверяем Memory Bank
    mb_path = project_path / ".conport" / "memory.db"
    memory_bank_exists = mb_path.exists()
    
    if not conport_installed:
        return {"conflict": False}
    
    return {
        "conflict": True,
        "type": "existing-conport",
        "severity": "info",
        "message": "ConPort уже установлен",
        "details": {
            "cli_installed": conport_installed,
            "mcp_configured": conport_in_mcp,
            "memory_bank_exists": memory_bank_exists,
            "memories_count": get_memories_count(mb_path) if memory_bank_exists else 0
        }
    }
```

### Вывод

```
ℹ️ Информация: ConPort уже установлен

Статус:
  ✅ ConPort CLI
  ✅ MCP сервер настроен
  ✅ Memory Bank (125 воспоминаний)

Варианты:
  [1] Пропустить (рекомендуется)
  [2] Переустановить
  [3] Обновить конфигурацию
```

---

## CONF-006: Git hooks exist

### Детектирование

```python
def check_git_hooks_conflict(project_path):
    hooks_dir = project_path / ".git" / "hooks"
    post_commit_hook = hooks_dir / "post-commit"
    
    if not post_commit_hook.exists():
        return {"conflict": False}
    
    # Читаем содержимое хука
    content = post_commit_hook.read_text()
    
    # Проверяем это entire.io хук
    is_entire_hook = "entire" in content.lower()
    
    # Проверяем это vibestart хук
    is_vibestart_hook = "vibestart" in content.lower()
    
    # Проверяем это другой хук
    is_other_hook = not is_entire_hook and not is_vibestart_hook
    
    if is_entire_hook or is_vibestart_hook:
        return {"conflict": False}
    
    return {
        "conflict": True,
        "type": "existing-git-hooks",
        "severity": "warning",
        "message": "Существующий post-commit хук не от vibestart/Entire.io",
        "details": {
            "hook_path": str(post_commit_hook),
            "hook_size": len(content),
            "first_lines": content.split("\n")[:5]
        }
    }
```

### Вывод

```
⚠️ Конфликт: Существующий post-commit хук

Путь: .git/hooks/post-commit
Содержимое (первые 5 строк):
  #!/bin/bash
  # Пользовательский хук для деплоя
  ...

Варианты:
  [1] Объединить хуки (рекомендуется)
  [2] Заменить vibestart хуком
  [3] Пропустить
```

---

## Сводная таблица

| Тип | Серьёзность | Авто-разрешение | Требует выбора |
|-----|-------------|-----------------|----------------|
| CONF-001 | warning/error | ❌ | ✅ |
| CONF-002 | info | ❌ | ✅ |
| CONF-003 | warning | ❌ | ✅ |
| CONF-004 | info | ✅ | ❌ |
| CONF-005 | info | ✅ | ❌ |
| CONF-006 | warning | ❌ | ✅ |
