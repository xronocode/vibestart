# vibestart

**From zero to vibe coding in one paste.**

vibestart — это фреймворк для управления ИИ-инструментарием разработки. Централизует конфигурацию, стандартизирует правила работы агента, и обеспечивает совместимость между проектами.

## Особенности v2.0

- **Без кода** — только TOML, XML, Markdown
- **Универсальность** — работает с Kilo Code, Cursor, Claude, и другими агентами
- **Конфликты** — обнаружение и разрешение 6 типов конфликтов
- **Миграция** — автоматический переход с v1.0 и grace-marketplace
- **Прозрачность** — Agent Transparency Protocol для отслеживания действий

## Установка

### Вариант 1: Клонирование

```bash
git clone https://github.com/xronocode/vibestart ~/.vibestart/framework
```

### Вариант 2: В проекте

Скопируйте содержимое `src/` в ваш проект или в `~/.vibestart/framework/`.

## Быстрый старт

В целевом проекте выполните через агента:

```
/vs-init
```

Агент:
1. Проверит целостность фреймворка
2. Обнаружит и разрешит конфликты
3. Создаст vs.project.toml
4. Сгенерирует AGENTS.md
5. Создаст docs/*.xml из шаблонов

## Структура

```
vibestart/
├── framework.toml          # Конфигурация фреймворка
├── standards/              # XML стандарты
│   ├── grace/             # GRACE методология
│   ├── architecture/      # Архитектурные принципы
│   ├── error-handling/    # Обработка ошибок
│   ├── git-workflow/      # Git практика
│   ├── agent-transparency/# Прозрачность действий
│   └── compatibility/     # Совместимость skills
├── templates/              # XML шаблоны для проектов
├── fragments/              # MD фрагменты для AGENTS.md
├── skills/                 # MD skills для агента
│   ├── vs-init/           # Инициализация + рендер AGENTS.md
│   └── grace/             # GRACE skills (улучшенные)
├── macros/                 # XML макросы
└── support/                # Вспомогательные файлы
```

## Skills

### Управление (vs-*)

| Skill | Описание |
|-------|----------|
| `vs-init` | Инициализация + миграция + конфликты + рендер AGENTS.md (все-in-one) |

### GRACE (улучшенные)

| Skill | Описание |
|-------|----------|
| `grace-init` | Bootstrap GRACE структуры |
| `grace-plan` | Проектирование модулей |
| `grace-execute` | Реализация |
| `grace-verification` | Тестирование |
| `grace-reviewer` | Code review |
| `grace-refresh` | Обновление графа |
| `grace-fix` | Исправление багов |
| `grace-status` | Статус GRACE |
| `grace-ask` | Вопросы о проекте |
| `grace-explainer` | Справочник методологии |

## Конфликтные ситуации

vs-init обнаруживает и разрешает:

1. **Skills** — дубликаты из разных источников
2. **AGENTS.md** — существующий vs сгенерированный
3. **Конфигурация** — множественные конфиг-файлы
4. **GRACE артефакты** — разные форматы/версии
5. **Session logs** — несовпадение формата
6. **Gitignore** — отсутствующие записи

## Миграция

### С v1.0

```
/vs-init --migrate
```

### С grace-marketplace

```
/vs-init
```

Автоматически обнаружит существующие skills и предложит:
1. Заменить на vibestart v2.0 (с backup)
2. Оставить оригинальные
3. Объединить вручную

## Поддерживаемые агенты

| Агент | Приоритет | Особенности |
|-------|-----------|-------------|
| Kilo Code | P1 | Полная поддержка |
| Cursor | P1 | Полная поддержка |
| Claude Code | P2 | Базовая поддержка |
| Windsurf | P3 | По запросу |
| Aider | P3 | По запросу |

## ConPort

Опциональная функция для долгосрочной памяти.

**Без ConPort:**
- docs/SESSION_LOG.md
- docs/TASK_LOG.md
- docs/decisions.xml

**С ConPort:**
- Семантический поиск
- Автоматические связи
- Статистика активности

Рекомендация: Solo проект → без ConPort, Команда → с ConPort.

## Credits

### Авторы

- **Dima** — [github.com/dmkononenko](https://github.com/dmkononenko)
- **Sergei** — [github.com/aka-NameRec](https://github.com/aka-NameRec)

### Благодарности

Проект основан на идеях и наработках:
- [ai-standards](https://github.com/aka-NameRec/ai-standards) — централизованные AI-настройки
- [GRACE marketplace](https://github.com/osovv/grace-marketplace) — GRACE методология

## Лицензия

MIT

## Ссылки

- Репозиторий: https://github.com/xronocode/vibestart
- GRACE marketplace: https://github.com/osovv/grace-marketplace
- ai-standards: https://github.com/aka-NameRec/ai-standards
