# Conflict Resolvers

Стратегии разрешения конфликтов для vs-init.

## Обзор

Для каждого типа конфликта определены стратегии разрешения:

| Тип | Стратегия 1 | Стратегия 2 | Стратегия 3 |
|-----|-------------|-------------|-------------|
| CONF-001 | Backup + replace | Merge | Skip |
| CONF-002 | Preserve + update | Replace | Skip |
| CONF-003 | Disable old + enable new | Keep old | Manual |
| CONF-004 | Skip | Reinstall | Check version |
| CONF-005 | Skip | Reinstall | Update config |
| CONF-006 | Merge hooks | Replace | Skip |

---

## RESOLVER-001: AGENTS.md Conflict

### Стратегия 1: Backup + Replace

```python
def resolve_agents_backup_replace(project_path):
    import shutil
    from datetime import datetime
    
    agents_file = project_path / "AGENTS.md"
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_path = project_path / f"AGENTS.md.backup.{timestamp}"
    
    # Создаём backup
    shutil.copy2(agents_file, backup_path)
    
    # Генерируем новый из шаблона
    generate_agents_md(project_path)
    
    return {
        "status": "success",
        "backup": str(backup_path),
        "message": "AGENTS.md заменён, backup создан"
    }
```

### Стратегия 2: Merge

```python
def resolve_agents_merge(project_path):
    # Читаем существующий
    existing = read_file(project_path / "AGENTS.md")
    
    # Читаем шаблон vibestart
    template = read_file(project_path / ".vibestart/src/templates/AGENTS.md.template")
    
    # Предлагаем агенту объединить
    merged = merge_documents(existing, template)
    
    # Сохраняем merged версию
    write_file(project_path / "AGENTS.md", merged)
    
    return {
        "status": "manual_review_required",
        "message": "AGENTS.md объединён, требуется ручная проверка"
    }
```

### Стратегия 3: Skip

```python
def resolve_agents_skip(project_path):
    return {
        "status": "skipped",
        "message": "AGENTS.md не изменён"
    }
```

---

## RESOLVER-002: GRACE Artifacts Conflict

### Стратегия 1: Preserve + Update

```python
def resolve_grace_preserve_update(project_path):
    import shutil
    from datetime import datetime
    
    docs_dir = project_path / "docs"
    backup_dir = project_path / "docs" / ".backup" / datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir.mkdir(parents=True, exist_ok=True)
    
    preserved_data = {}
    
    # Для каждого существующего файла
    for xml_file in docs_dir.glob("*.xml"):
        # Извлекаем данные
        data = extract_grace_data(xml_file)
        preserved_data[xml_file.name] = data
        
        # Создаём backup
        shutil.copy2(xml_file, backup_dir / xml_file.name)
    
    # Создаём новые файлы из шаблонов
    for template in (project_path / ".vibestart/src/templates").glob("*.xml.template"):
        target_name = template.name.replace(".template", "")
        target_file = docs_dir / target_name
        
        # Создаём из шаблона
        content = read_file(template)
        content = replace_placeholders(content, preserved_data.get(target_name, {}))
        write_file(target_file, content)
    
    return {
        "status": "success",
        "backup": str(backup_dir),
        "preserved_files": list(preserved_data.keys()),
        "message": "GRACE артефакты обновлены с сохранением данных"
    }
```

### Стратегия 2: Replace

```python
def resolve_grace_replace(project_path):
    import shutil
    from datetime import datetime
    
    docs_dir = project_path / "docs"
    backup_dir = project_path / "docs" / ".backup" / datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir.mkdir(parents=True, exist_ok=True)
    
    # Backup существующих
    for xml_file in docs_dir.glob("*.xml"):
        shutil.copy2(xml_file, backup_dir / xml_file.name)
    
    # Создаём новые из шаблонов
    for template in (project_path / ".vibestart/src/templates").glob("*.xml.template"):
        target_name = template.name.replace(".template", "")
        target_file = docs_dir / target_name
        
        content = read_file(template)
        content = replace_placeholders(content, {})
        write_file(target_file, content)
    
    return {
        "status": "success",
        "backup": str(backup_dir),
        "message": "GRACE артефакты заменены полностью"
    }
```

### Стратегия 3: Skip

```python
def resolve_grace_skip(project_path):
    return {
        "status": "skipped",
        "message": "GRACE артефакты не изменены"
    }
```

---

## RESOLVER-003: MCP Servers Conflict

### Стратегия 1: Disable Old + Enable ConPort

```python
def resolve_mcp_disable_old_enable_conport(project_path):
    mcp_configs = get_mcp_config_paths(project_path)
    
    for config_path in mcp_configs:
        if not config_path.exists():
            continue
        
        config = json.load(open(config_path))
        servers = config.get("mcpServers", {})
        
        # Комментируем старые серверы памяти
        for name in list(servers.keys()):
            if "conport" in name.lower() or "memory" in name.lower():
                # Добавляем префикс для отключения
                servers[f"_disabled_{name}"] = servers.pop(name)
        
        # Добавляем ConPort
        servers["conport"] = {
            "command": "conport",
            "args": ["--project", str(project_path)]
        }
        
        config["mcpServers"] = servers
        write_file(config_path, json.dumps(config, indent=2))
    
    return {
        "status": "success",
        "message": "Старые MCP серверы отключены, ConPort добавлен"
    }
```

### Стратегия 2: Keep Old

```python
def resolve_mcp_keep_old(project_path):
    return {
        "status": "skipped",
        "message": "Существующие MCP серверы сохранены, ConPort не добавлен"
    }
```

### Стратегия 3: Manual

```python
def resolve_mcp_manual(project_path):
    return {
        "status": "manual_required",
        "message": "Ручная настройка MCP серверов требуется",
        "configs": get_mcp_config_paths(project_path)
    }
```

---

## RESOLVER-004: Entire.io Conflict

### Стратегия 1: Skip

```python
def resolve_entire_skip(project_path):
    return {
        "status": "skipped",
        "message": "Entire.io уже настроен"
    }
```

### Стратегия 2: Reinstall

```python
def resolve_entire_reinstall(project_path):
    import subprocess
    
    # Удаляем хуки
    hooks_dir = project_path / ".git" / "hooks"
    for hook in ["post-commit", "pre-push"]:
        hook_file = hooks_dir / hook
        if hook_file.exists():
            hook_file.unlink()
    
    # Выполняем entire enable
    result = subprocess.run(["entire", "enable"], cwd=project_path, capture_output=True, text=True)
    
    if result.returncode != 0:
        return {
            "status": "error",
            "message": f"entire enable failed: {result.stderr}"
        }
    
    return {
        "status": "success",
        "message": "Entire.io переустановлен"
    }
```

### Стратегия 3: Check Version

```python
def resolve_entire_check_version(project_path):
    import subprocess
    
    result = subprocess.run(["entire", "--version"], capture_output=True, text=True)
    current_version = result.stdout.strip()
    
    # Проверяем последнюю версию
    latest_version = get_latest_entire_version()
    
    if current_version < latest_version:
        return {
            "status": "update_available",
            "current": current_version,
            "latest": latest_version,
            "message": f"Доступно обновление: {current_version} → {latest_version}"
        }
    
    return {
        "status": "up_to_date",
        "version": current_version,
        "message": "Entire.io актуален"
    }
```

---

## RESOLVER-005: ConPort Conflict

### Стратегия 1: Skip

```python
def resolve_conport_skip(project_path):
    return {
        "status": "skipped",
        "message": "ConPort уже настроен"
    }
```

### Стратегия 2: Reinstall

```python
def resolve_conport_reinstall(project_path):
    import subprocess
    
    # Сбрасываем MCP конфиг
    remove_conport_from_mcp_config(project_path)
    
    # Инициализируем заново
    result = subprocess.run(
        ["conport", "init", "--project", str(project_path)],
        capture_output=True,
        text=True
    )
    
    if result.returncode != 0:
        return {
            "status": "error",
            "message": f"conport init failed: {result.stderr}"
        }
    
    # Добавляем в MCP конфиг
    add_conport_to_mcp_config(project_path)
    
    return {
        "status": "success",
        "message": "ConPort переустановлен"
    }
```

### Стратегия 3: Update Config

```python
def resolve_conport_update_config(project_path):
    # Проверяем MCP конфиг
    mcp_config = get_mcp_config(project_path)
    
    if "conport" not in mcp_config.get("mcpServers", {}):
        add_conport_to_mcp_config(project_path)
        return {
            "status": "success",
            "message": "ConPort добавлен в MCP конфиг"
        }
    
    return {
        "status": "up_to_date",
        "message": "ConPort конфиг актуален"
    }
```

---

## RESOLVER-006: Git Hooks Conflict

### Стратегия 1: Merge Hooks

```python
def resolve_git_hooks_merge(project_path):
    hooks_dir = project_path / ".git" / "hooks"
    post_commit_hook = hooks_dir / "post-commit"
    
    # Читаем существующий хук
    existing_content = read_file(post_commit_hook)
    
    # Добавляем vibestart/Entire.io вызовы
    vibestart_hook = """
# vibestart hooks
if command -v entire &> /dev/null; then
    entire record --commit "$1" 2>/dev/null || true
fi
"""
    
    # Объединяем
    merged_content = existing_content + "\n" + vibestart_hook
    write_file(post_commit_hook, merged_content)
    
    # Делаем исполняемым
    make_executable(post_commit_hook)
    
    return {
        "status": "success",
        "message": "Git хук объединён"
    }
```

### Стратегия 2: Replace

```python
def resolve_git_hooks_replace(project_path):
    hooks_dir = project_path / ".git" / "hooks"
    post_commit_hook = hooks_dir / "post-commit"
    
    # Создаём новый хук
    hook_content = """#!/bin/bash
# vibestart post-commit hook

if command -v entire &> /dev/null; then
    entire record --commit "$1" 2>/dev/null || true
fi
"""
    
    write_file(post_commit_hook, hook_content)
    make_executable(post_commit_hook)
    
    return {
        "status": "success",
        "message": "Git хук заменён"
    }
```

### Стратегия 3: Skip

```python
def resolve_git_hooks_skip(project_path):
    return {
        "status": "skipped",
        "message": "Git хук не изменён"
    }
```

---

## Диалог с пользователем

### Пример вывода для CONF-001

```
╔═══════════════════════════════════════════════════════════════╗
║                    AGENTS.md EXISTS                           ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  An AGENTS.md file already exists in this project.           ║
║                                                                ║
║  Options:                                                      ║
║    [1] backup-and-replace (RECOMMENDED)                       ║
║        → Save current to AGENTS.md.backup                     ║
║        → Generate new from template                           ║
║                                                                ║
║    [2] keep-existing                                           ║
║        → No changes to AGENTS.md                              ║
║        → Continue with other files                            ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2]:
```

### Пример вывода для CONF-002

```
╔═══════════════════════════════════════════════════════════════╗
║                    GRACE ARTIFACTS EXIST                      ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Found existing GRACE-compatible XML files:                   ║
║    • docs/requirements.xml (12 use cases, 5 decisions)        ║
║    • docs/decisions.xml (8 decisions)                         ║
║                                                                ║
║  Options:                                                      ║
║    [1] Preserve and update (RECOMMENDED)                      ║
║        → Extract data, merge with templates                   ║
║        → Create backups                                       ║
║                                                                ║
║    [2] Replace all                                            ║
║        → Backup originals, create fresh from templates        ║
║                                                                ║
║    [3] Skip                                                   ║
║        → Leave existing files unchanged                       ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝

Your choice [1/2/3]:
```

---

## Сводная матрица разрешений

| Тип | Авто | Требует выбора | Ручное |
|-----|------|----------------|--------|
| CONF-001 | ❌ | ✅ | ✅ |
| CONF-002 | ❌ | ✅ | ✅ |
| CONF-003 | ❌ | ✅ | ✅ |
| CONF-004 | ✅ | ❌ | ❌ |
| CONF-005 | ✅ | ❌ | ❌ |
| CONF-006 | ❌ | ✅ | ✅ |
