# GRACE Macros - Common Workflows

> Prefix `g-` indicates macro (sequence of skills), not a single skill.

## Macro: `g-init`
Полная инициализация GRACE проекта с нуля.

```bash
# Sequence:
$grace-init      # Создать структуру docs/
$grace-plan      # Спроектировать модули
$grace-verification  # Определить тесты
```

**Trigger:** Новый проект или полный ресет.

---

## Macro: `g-feature`
Добавление новой фичи с полным циклом.

```bash
# Sequence:
# 1. Обновить docs/requirements.xml (новый UseCase)
$grace-plan      # Пересчитать модули
$grace-verification  # Добавить тесты
$grace-execute   # Реализовать
$grace-reviewer  # Проверить
```

**Trigger:** Новая фича, новый UseCase.

---

## Macro: `g-drift`
Исправление дрейфа между кодом и документацией.

```bash
# Sequence:
$grace-status    # Показать дрейф
$grace-refresh   # Синхронизировать
$grace-verification  # Проверить тесты
```

**Trigger:** После длительной работы без GRACE, перед коммитом.

---

## Macro: `g-fix`
Исправление бага с трассировкой.

```bash
# Sequence:
$grace-fix       # Найти и исправить
$grace-verification  # Усилить тесты
$grace-refresh   # Обновить граф
```

**Trigger:** Баг репорт, падающий тест.

---

## Macro: `g-commit`
Безопасный коммит с проверками.

```bash
# Sequence:
$grace-status    # Проверить здоровье
$grace-reviewer  # Code review
$grace-verification  # Прогнать тесты
# Затем git commit
$grace-refresh   # Обновить session-log
```

**Trigger:** Перед каждым коммитом.

---

## Summary Table

| Macro | Sequence | When |
|-------|----------|------|
| `g-init` | init → plan → verification | Новый проект |
| `g-feature` | requirements → plan → verification → execute → reviewer | Новая фича |
| `g-drift` | status → refresh → verification | Дрейф кода |
| `g-fix` | fix → verification → refresh | Баг |
| `g-commit` | status → reviewer → verification → commit → refresh | Перед коммитом |

---

## Как использовать

В Kilo Code / другом агенте:

```
Запусти макрос g-feature для авторизации
```

Агент выполнит последовательность автоматически.
