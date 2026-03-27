# Entire.io Integration

Настройка Entire.io для аудита AI-сессий.

## Обзор

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

---

## Setup Инструкция

### Шаг 1: Проверка entire CLI

```bash
entire --version
```

Если не установлен:

```bash
npm install -g @entire/cli
```

### Шаг 2: Включение для проекта

```bash
cd /path/to/project
entire enable
```

### Шаг 3: Проверка хуков

```bash
# Проверка post-commit хука
cat .git/hooks/post-commit
```

Должен содержать вызов entire.

### Шаг 4: Проверка ветки

```bash
git branch -a
```

Должна появиться ветка `entire/checkpoints/v1` (после первого коммита).

---

## Verify Инструкция

### Проверка 1: entire CLI доступен

```bash
entire --version
```

**Ожидается:** Версия >= 1.0.0

### Проверка 2: Git хуки установлены

```bash
ls -la .git/hooks/post-commit
```

**Ожидается:** Файл существует и исполняемый

### Проверка 3: Ветка checkpoints существует

```bash
git branch -a | grep entire/checkpoints/v1
```

**Ожидается:** Ветка существует (после первого коммита)

### Проверка 4: Checkpoints захватываются

```bash
entire list
```

**Ожидается:** Список checkpoint'ов (может быть пустым до первого коммита)

---

## Использование с vibestart

### Включение в vs-init

При запуске `vs-init` в режиме ADVANCED:

```
[SKILL:vs-init] ADVANCED mode selected

Optional integrations:

Question 1: Entire.io (AI session audit)?
  • Free, MIT license
  • Stores in Git (entire/checkpoints/v1 branch)
  • Support: Claude Code, Cursor, Gemini CLI

Enable Entire.io? [Y/n]: Y

Setting up Entire.io:
  ✓ Checking entire CLI installation
  ✓ Running: entire enable
  ✓ Verifying git hooks
  ✓ Creating branch: entire/checkpoints/v1
```

### Фрагмент для AGENTS.md

Добавляется в `AGENTS.md` если Entire.io включён:

```markdown
## Session Capture с Entire.io

Этот проект использует Entire.io для аудита AI-сессий.

В конце каждой сессии:
1. Убедись что `entire record` активен
2. При коммите добавь AI-Checkpoint в message:
   ```
   AI-Checkpoint: <checkpoint_id>
   AI-Session: <session_id>
   ```
3. Для архитектурных решений вызови `migrate_to_grace()`
```

---

## Команды Entire.io

| Команда | Описание |
|---------|----------|
| `entire enable` | Включить Entire.io для проекта |
| `entire record` | Начать запись сессии |
| `entire list` | Показать список checkpoint'ов |
| `entire rewind <checkpoint>` | Откатиться к checkpoint |
| `entire resume <checkpoint>` | Возобновить сессию |
| `entire status` | Показать статус Entire.io |

---

## Интеграция с агентами

### Claude Code

Автоматически захватывает сессии после `entire enable`.

### Cursor

Автоматически захватывает сессии после `entire enable`.

### Kilo Code

Автоматически захватывает сессии после `entire enable`.

---

## Edge Cases

| Случай | Решение |
|--------|---------|
| entire CLI не найден | Предложить установку: `npm install -g @entire/cli` |
| Git хуки уже есть | Предложить объединить хуки |
| Ветка не создаётся | Проверить что был сделан коммит |
| entire list пуст | Это нормально до первого коммита |

---

## Отключение

```bash
# Удалить хуки
entire disable

# Удалить ветку checkpoint'ов
git branch -D entire/checkpoints/v1
```

---

## Документация

- **Официальная:** https://docs.entire.io
- **GitHub:** https://github.com/entireio/cli
- **Лицензия:** MIT (бесплатно)
