# Detect Mode

Определение режима работы vs-init.

## Алгоритм

```
[SKILL:vs-init] Step 1: Detecting mode...

Checking project state:
  • .vibestart/ directory: [exists/missing]
  • vs.project.toml: [exists/missing]
  • docs/*.xml: [count] files found
  • AGENTS.md: [exists/missing]
```

## Режимы

| Режим | Условия | Описание |
|-------|---------|----------|
| **INSTALL** | Нет `.vibestart/` | Новая установка |
| **UPDATE** | Есть `.vibestart/` и `vs.project.toml`, версия < текущей | Обновление версии |
| **REPAIR** | Есть `.vibestart/`, нет `vs.project.toml` или проблемы с файлами | Исправление проблем |
| **MIGRATE** | Есть `.vibestart/`, версия = 1.x | Миграция с v1.x на v3.x |
| **REFRESH** | Есть `.vibestart/`, версия = текущей | Перегенерация артефактов |

## Детектирование

### Шаг 1: Проверка .vibestart/

```
if not exists(".vibestart/"):
    return INSTALL
```

### Шаг 2: Проверка vs.project.toml

```
if not exists("vs.project.toml"):
    return REPAIR
```

### Шаг 3: Чтение версии

```
config = read_toml("vs.project.toml")
version = config.get("vibestart", {}).get("version", "0.0.0")
```

### Шаг 4: Определение режима

```
if version.startswith("1."):
    return MIGRATE

if version < CURRENT_VERSION:
    return UPDATE

if has_problems():
    return REPAIR

return REFRESH
```

## Проверка проблем (REPAIR)

```python
def has_problems():
    problems = []
    
    # Check 1: Отсутствующие файлы .vibestart/
    required_files = [
        ".vibestart/src/skills/vs-init/SKILL.md",
        ".vibestart/src/standards/architecture.md",
        ".vibestart/src/templates/requirements.xml"
    ]
    
    for file in required_files:
        if not exists(file):
            problems.append(f"Missing: {file}")
    
    # Check 2: Отсутствующие GRACE артефакты
    grace_files = [
        "docs/requirements.xml",
        "docs/knowledge-graph.xml",
        "docs/technology.xml"
    ]
    
    for file in grace_files:
        if not exists(file):
            problems.append(f"Missing GRACE: {file}")
    
    # Check 3: Некорректный XML
    for file in grace_files:
        if exists(file) and not is_valid_xml(file):
            problems.append(f"Invalid XML: {file}")
    
    # Check 4: AGENTS.md не содержит vibestart
    if exists("AGENTS.md"):
        content = read("AGENTS.md")
        if "vibestart" not in content.lower() and "grace" not in content.lower():
            problems.append("AGENTS.md not vibestart-compatible")
    
    return len(problems) > 0
```

## Вывод для пользователя

```
╔═══════════════════════════════════════════════════════════════╗
║                    DETECTED MODE                              ║
╠═══════════════════════════════════════════════════════════════╣
║                                                                ║
║  Mode: [MODE_NAME]                                             ║
║                                                                ║
║  Description: [описание режима]                                ║
║                                                                ║
║  Detected:                                                     ║
║    • .vibestart/: [exists/missing]                             ║
║    • vs.project.toml: [exists/missing]                         ║
║    • Version: [version/none]                                   ║
║    • Problems: [count]                                         ║
║                                                                ║
╚═══════════════════════════════════════════════════════════════╝
```

## Edge Cases

| Случай | Детектирование | Режим |
|--------|----------------|-------|
| `.git/` есть, `.vibestart/` нет | `exists(".git/")` and `not exists(".vibestart/")` | INSTALL |
| `.vibestart/` есть, `vs.project.toml` нет | `exists(".vibestart/")` and `not exists("vs.project.toml")` | REPAIR |
| `vs.project.toml` версия пустая | `version = ""` | REPAIR |
| `vs.project.toml` версия не парсится | TOML parse error | REPAIR |
| `docs/` есть, XML нет | `exists("docs/")` and `count("docs/*.xml") = 0` | INSTALL (создать XML) |
