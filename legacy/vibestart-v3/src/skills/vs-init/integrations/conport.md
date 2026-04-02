# ConPort Integration

Настройка ConPort для долгосрочной памяти AI-агентов.

## Обзор

**ConPort** — это MCP сервер для долгосрочной памяти AI-агентов.

### Возможности

| Функция | Описание |
|---------|----------|
| **Memory Storage** | Хранение воспоминаний между сессиями |
| **Semantic Search** | Семантический поиск по воспоминаниям |
| **Context Carry-over** | Перенос контекста между сессиями |
| **Decision Migration** | Миграция решений в GRACE (decisions.xml) |

### Требования

| Зависимость | Версия | Установка |
|-------------|--------|-----------|
| **Python** | >= 3.10 | https://python.org |
| **ConPort MCP** | >= 1.0.0 | См. инструкцию ниже |
| **Agent with MCP** | - | Claude Code, Kilo Code, Cursor |

### Хранение данных

| Тип | Где хранится |
|-----|--------------|
| **Memory Bank** | `.conport/memory.db` (SQLite) |
| **Воспоминания** | В SQLite базе данных |
| **MCP конфиг** | Зависит от агента (см. ниже) |

---

## Setup Инструкция

### Шаг 1: Проверка ConPort

```bash
conport --version
```

Если не установлен — следуем инструкции по установке:

**Вариант A: Через pip (рекомендуется)**

```bash
pip install context-portal
```

**Вариант B: Из исходников**

```bash
git clone https://github.com/GreatScottyMac/context-portal
cd context-portal
pip install -e .
```

### Шаг 2: Инициализация для проекта

```bash
cd /path/to/project
conport init --project .
```

### Шаг 3: Настройка MCP конфига

**Для Claude Code:**

```json
// ~/.claude/claude_desktop_config.json
{
  "mcpServers": {
    "conport": {
      "command": "conport",
      "args": ["--project", "/path/to/project"]
    }
  }
}
```

**Для Kilo Code:**

```json
// .kilocode/mcp_settings.json
{
  "mcpServers": {
    "conport": {
      "command": "conport",
      "args": ["--project", "${workspaceFolder}"]
    }
  }
}
```

**Для Cursor:**

```json
// .cursor/mcp.json
{
  "mcpServers": {
    "conport": {
      "command": "conport",
      "args": ["--project", "${workspaceFolder}"]
    }
  }
}
```

### Шаг 4: Проверка подключения

```bash
conport status
```

---

## Verify Инструкция

### Проверка 1: ConPort CLI доступен

```bash
conport --version
```

**Ожидается:** Версия >= 1.0.0

### Проверка 2: MCP конфиг настроен

Проверить конфиг агента:

- Claude Code: `~/.claude/claude_desktop_config.json`
- Kilo Code: `.kilocode/mcp_settings.json`
- Cursor: `.cursor/mcp.json`

**Ожидается:** ConPort указан в `mcpServers`

### Проверка 3: Memory Bank существует

```bash
ls -la .conport/memory.db
```

**Ожидается:** Файл существует

### Проверка 4: Воспоминания сохраняются

```bash
conport list
```

**Ожидается:** Список воспоминаний (может быть пустым)

---

## Использование с vibestart

### Включение в vs-init

При запуске `vs-init` в режиме ADVANCED:

```
[SKILL:vs-init] ADVANCED mode selected

Optional integrations:

Question 2: ConPort (long-term memory)?
  • Free, open source
  • MCP server for memory
  • Support: Claude Code, Kilo Code, Cursor

Enable ConPort? [Y/n]: Y

Setting up ConPort:
  ✓ Checking ConPort CLI installation
  ✓ Adding to MCP config
  ✓ Initializing Memory Bank
  ✓ Verifying connection
```

### Фрагмент для AGENTS.md

Добавляется в `AGENTS.md` если ConPort включён:

```markdown
## ConPort Memory

Этот проект использует ConPort для долгосрочной памяти.

### Использование

**Сохранение воспоминания:**
```
conport store "Решили использовать FastAPI для API"
```

**Поиск воспоминаний:**
```
conport recall "API архитектура"
```

**Миграция решений в GRACE:**
Когда воспоминание становится архитектурным решением:
```
conport migrate <memory_id>
```
Это создаст запись в `docs/decisions.xml`.
```

---

## Интеграция с GRACE

### Миграция решений в GRACE

Когда воспоминание ConPort становится архитектурным решением:

```python
# Агент определяет что воспоминание важно
memory = conport.get(memory_id="mem_123")

# Миграция в decisions.xml
decision = {
    "id": f"D-{next_decision_number()}",
    "summary": memory["content"],
    "date": datetime.now().isoformat(),
    "status": "approved"
}

# Добавление в docs/decisions.xml
add_decision_to_xml(decision)

# Обновление knowledge-graph.xml
add_node_to_graph({
    "id": f"M-{decision['id']}",
    "type": "decision",
    "description": decision["summary"]
})
```

---

## Команды ConPort

| Команда | Описание |
|---------|----------|
| `conport init` | Инициализировать Memory Bank |
| `conport store <content>` | Сохранить воспоминание |
| `conport recall <query>` | Поиск воспоминаний |
| `conport list` | Показать все воспоминания |
| `conport status` | Показать статус ConPort |
| `conport migrate <id>` | Миграция в GRACE |

---

## Интеграция с агентами

### Claude Code

Автоматически использует ConPort через MCP.

### Kilo Code

Автоматически использует ConPort через MCP.

### Cursor

Автоматически использует ConPort через MCP.

---

## Edge Cases

| Случай | Решение |
|--------|---------|
| ConPort CLI не найден | Предложить установку: `pip install context-portal` |
| MCP конфиг не найден | Показать путь к файлу конфига для агента |
| Memory Bank не создаётся | Проверить права доступа к `.conport/` |
| ConPort не подключается | Перезапустить агента |

---

## Отключение

```bash
# Удалить из MCP конфига (вручную)
# Удалить Memory Bank
rm -rf .conport/
```

---

## Документация

- **Официальная:** https://github.com/GreatScottyMac/context-portal
- **GitHub:** https://github.com/GreatScottyMac/context-portal
- **Лицензия:** MIT (бесплатно)
