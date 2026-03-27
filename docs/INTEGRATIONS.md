# vibestart Integrations

Полная документация по интеграциям vibestart с внешними инструментами.

---

## Обзор

vibestart v3.0.0 поддерживает две опциональные интеграции:

| Интеграция | Что даёт | Когда включать |
|------------|----------|----------------|
| **Entire.io** | Аудит AI-сессий, чекпоинты в Git | Для команды, аудит, compliance |
| **ConPort** | Долгосрочная память между сессиями | Для сложных проектов с долгой историей |

---

## Режимы установки

### LITE

**Включает:**
- GRACE методология
- XML артефакты
- vs-init
- Базовые GRACE-скиллы

**Не включает:**
- Entire.io
- ConPort

**Время установки:** 1-2 минуты

### ADVANCED

**Включает:**
- Всё из LITE
- Entire.io (опционально)
- ConPort (опционально)

**Время установки:** 10-15 минут

---

## Entire.io

### Что это

**Entire.io** — это инструмент для захвата и аудита сессий AI-агентов в Git workflow.

### Возможности

| Функция | Описание |
|---------|----------|
| **Session Capture** | Автоматический захват сессий AI-агентов |
| **Checkpoints** | Привязка сессий к коммитам Git |
| **Search** | Поиск по сессиям, промптам, файлам |
| **Rewind** | Откат к предыдущему checkpoint |
| **Resume** | Возобновление сессии с checkpoint |

### Требования

| Зависимость | Версия | Установка |
|-------------|--------|-----------|
| **Node.js** | >= 16 | https://nodejs.org |
| **entire CLI** | >= 1.0.0 | `npm install -g @entire/cli` |
| **Git** | >= 2.0 | Обычно предустановлен |

### Хранение данных

| Тип | Где хранится |
|-----|--------------|
| **Checkpoints** | Git branch: `entire/checkpoints/v1` |
| **Сессии** | В ветке entire/checkpoints/v1 |
| **Метаданные** | В commit message (AI-Checkpoint: xxx) |

### Настройка

**Автоматическая (через vs-init):**
```
[SKILL:vs-init] ADVANCED mode selected

Question 1: Entire.io (AI session audit)?
Enable Entire.io? [Y/n]: Y

Setting up Entire.io:
  ✓ Checking entire CLI installation
  ✓ Running: entire enable
  ✓ Verifying git hooks
  ✓ Creating branch: entire/checkpoints/v1
```

**Ручная:**
```bash
# Установить entire CLI
npm install -g @entire/cli

# Включить для проекта
cd /path/to/project
entire enable

# Проверить
entire status
```

### Использование

**Начать сессию:**
```bash
# Автоматически при работе с AI-агентом
# Claude Code, Cursor, Kilo Code
```

**Просмотр checkpoint'ов:**
```bash
# Список всех checkpoint'ов
entire list

# Показать детали
entire show <checkpoint-id>

# Поиск
entire search "keyword"
```

**Откат и возобновление:**
```bash
# Откатиться к checkpoint
entire rewind <checkpoint-id>

# Возобновить сессию
entire resume <checkpoint-id>
```

### Интеграция с агентами

| Агент | Поддержка |
|-------|-----------|
| **Claude Code** | ✅ Автоматически |
| **Cursor** | ✅ Автоматически |
| **Kilo Code** | ✅ Автоматически |
| **Gemini CLI** | ✅ Автоматически |
| **OpenCode** | ✅ Автоматически |

### Команды

| Команда | Описание |
|---------|----------|
| `entire enable` | Включить Entire.io для проекта |
| `entire record` | Начать запись сессии |
| `entire list` | Показать список checkpoint'ов |
| `entire show <id>` | Показать детали checkpoint |
| `entire search <query>` | Поиск по сессиям |
| `entire rewind <id>` | Откатиться к checkpoint |
| `entire resume <id>` | Возобновить сессию |
| `entire status` | Показать статус |

### Troubleshooting

**Issue: entire CLI not found**
```bash
npm install -g @entire/cli
```

**Issue: Git hooks not installed**
```bash
entire enable
```

**Issue: Branch not found**
```bash
# Ветка создаётся после первого коммита
git add .
git commit -m "chore: initial commit"
```

### Документация

- **Официальная:** https://docs.entire.io
- **GitHub:** https://github.com/entireio/cli
- **Лицензия:** MIT (бесплатно)

---

## ConPort

### Что это

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
| **ConPort MCP** | >= 1.0.0 | `pip install context-portal` |
| **Agent with MCP** | - | Claude Code, Kilo Code, Cursor |

### Хранение данных

| Тип | Где хранится |
|-----|--------------|
| **Memory Bank** | `.conport/memory.db` (SQLite) |
| **Воспоминания** | В SQLite базе данных |
| **MCP конфиг** | Зависит от агента (см. ниже) |

### Настройка MCP конфига

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

### Настройка

**Автоматическая (через vs-init):**
```
[SKILL:vs-init] ADVANCED mode selected

Question 2: ConPort (long-term memory)?
Enable ConPort? [Y/n]: Y

Setting up ConPort:
  ✓ Checking ConPort CLI installation
  ✓ Adding to MCP config
  ✓ Initializing Memory Bank
  ✓ Verifying connection
```

**Ручная:**
```bash
# Установить ConPort
pip install context-portal

# Инициализировать для проекта
cd /path/to/project
conport init --project .

# Проверить
conport status
```

### Использование

**Сохранение воспоминания:**
```bash
conport store "Решили использовать FastAPI для API"
```

**Поиск воспоминаний:**
```bash
conport recall "API архитектура"
```

**Список воспоминаний:**
```bash
conport list
```

**Миграция решений в GRACE:**
```bash
conport migrate <memory_id>
```

### Интеграция с GRACE

**Миграция решений:**

Когда воспоминание становится архитектурным решением:

1. Агент определяет важное решение
2. Вызывает `conport migrate <memory_id>`
3. Создаётся запись в `docs/decisions.xml`
4. Обновляется `docs/knowledge-graph.xml`

**Пример:**
```xml
<!-- docs/decisions.xml -->
<D-003 DATE="2026-03-27" STATUS="approved">
  <summary>Использовать JWT для аутентификации</summary>
  <rationale>Stateless, подходит для REST API</rationale>
</D-003>
```

### Интеграция с агентами

| Агент | Поддержка |
|-------|-----------|
| **Claude Code** | ✅ Через MCP |
| **Kilo Code** | ✅ Через MCP |
| **Cursor** | ✅ Через MCP |

### Команды

| Команда | Описание |
|---------|----------|
| `conport init` | Инициализировать Memory Bank |
| `conport store <content>` | Сохранить воспоминание |
| `conport recall <query>` | Поиск воспоминаний |
| `conport list` | Показать все воспоминания |
| `conport status` | Показать статус |
| `conport migrate <id>` | Миграция в GRACE |

### Troubleshooting

**Issue: ConPort CLI not found**
```bash
pip install context-portal
```

**Issue: MCP config not found**
```
Проверьте путь к конфиго:
- Claude Code: ~/.claude/claude_desktop_config.json
- Kilo Code: .kilocode/mcp_settings.json
- Cursor: .cursor/mcp.json
```

**Issue: Memory Bank not created**
```bash
conport init --project .
```

### Документация

- **Официальная:** https://github.com/GreatScottyMac/context-portal
- **GitHub:** https://github.com/GreatScottyMac/context-portal
- **Лицензия:** MIT (бесплатно)

---

## Сравнение интеграций

| Критерий | Entire.io | ConPort |
|----------|-----------|---------|
| **Тип хранения** | Git branch | SQLite файл |
| **Что хранит** | Сессии, чекпоинты | Воспоминания, контекст |
| **Поиск** | По сессиям, файлам | Семантический |
| **Требования** | Node.js, npm | Python, pip |
| **Агенты** | Claude, Cursor, Kilo, Gemini | Claude, Kilo, Cursor |
| **Лицензия** | MIT | MIT |
| **Цена** | Бесплатно | Бесплатно |

---

## Когда включать интеграции

### Entire.io

**Включить если:**
- ✅ Командная разработка
- ✅ Нужен аудит AI-сессий
- ✅ Compliance требования
- ✅ Хотите отслеживать эволюцию кода

**Не включать если:**
- ❌ Соло проект
- ❌ Не нужен аудит
- ❌ Минимальное использование AI

### ConPort

**Включить если:**
- ✅ Сложный проект с долгой историей
- ✅ Много сессий с разными агентами
- ✅ Нужен контекст между сессиями
- ✅ Хотите семантический поиск по решениям

**Не включать если:**
- ❌ Простой проект
- ❌ Короткие сессии
- ❌ Не нужно помнить контекст

---

## Отключение интеграций

### Entire.io

```bash
# Удалить хуки
entire disable

# Удалить ветку checkpoint'ов
git branch -D entire/checkpoints/v1

# Удалить из vs.project.toml
[integrations.entire]
enabled = false
```

### ConPort

```bash
# Удалить из MCP конфига (вручную)

# Удалить Memory Bank
rm -rf .conport/

# Удалить из vs.project.toml
[integrations.conport]
enabled = false
```

---

## Вопросы и ответы

### Q: Можно ли включить интеграции позже?

**A:** Да, в любое время:
```bash
/vs-init --add-entire
/vs-init --add-conport
```

### Q: Можно ли использовать обе интеграции одновременно?

**A:** Да, они не конфликтуют:
- Entire.io хранит в Git
- ConPort хранит в SQLite

### Q: Нужно ли платить за интеграции?

**A:** Нет, обе бесплатные (MIT license).

### Q: Работают ли интеграции офлайн?

**A:** 
- Entire.io — ✅ Да (хранит в Git)
- ConPort — ✅ Да (локальный SQLite)

### Q: Как удалить интеграции?

**A:** См. раздел "Отключение интеграций" выше.

---

## Ссылки

- **vibestart README:** ../README.md
- **GRACE Explainer:** grace-explainer.md
- **Entire.io Docs:** https://docs.entire.io
- **ConPort Docs:** https://github.com/GreatScottyMac/context-portal
