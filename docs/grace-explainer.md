# GRACE Explainer

Справочник методологии GRACE для vibestart v3.0.

---

## Что такое GRACE

**GRACE** (Graph-RAG Anchored Code Engineering) — методология контрактной разработки с использованием графов знаний.

### Основные принципы

1. **Contract-first** — Сначала контракты, потом реализация
2. **Knowledge Graph** — Граф модулей и зависимостей
3. **Verification** — Тесты и верификация
4. **Semantic Markup** — Разметка кода для навигации

---

## GRACE Артефакты

| Артефакт | Файл | Описание |
|----------|------|----------|
| **Requirements** | `docs/requirements.xml` | Требования и use cases |
| **Technology** | `docs/technology.xml` | Технологический стек |
| **Development Plan** | `docs/development-plan.xml` | План разработки по модулям |
| **Knowledge Graph** | `docs/knowledge-graph.xml` | Граф модулей и зависимостей |
| **Verification Plan** | `docs/verification-plan.xml` | План тестирования |
| **Decisions** | `docs/decisions.xml` | Архитектурные решения |

---

## GRACE Скиллы

### Управление проектом

| Скилл | Команда | Описание |
|-------|---------|----------|
| **grace-init** | `/grace-init` | Bootstrap GRACE структуры |
| **grace-plan** | `/grace-plan` | Проектирование модулей |
| **grace-execute** | `/grace-execute` | Реализация модулей |
| **grace-verification** | `/grace-verification` | Тестирование |
| **grace-reviewer** | `/grace-reviewer` | Code review |
| **grace-refresh** | `/grace-refresh` | Синхронизация артефактов |
| **grace-status** | `/grace-status` | Статус проекта |
| **grace-ask** | `/grace-ask` | Вопросы о проекте |
| **grace-session** | `/grace-session` | Управление сессиями |

---

## vibestart v3.0 Особенности

### Режимы установки

| Режим | Описание | Включает |
|-------|----------|----------|
| **LITE** | Быстрый старт | GRACE + XML + vs-init |
| **ADVANCED** | Полная платформа | LITE + Entire.io + ConPort |

### Интеграции

#### Entire.io

**Что даёт:**
- Аудит AI-сессий
- Чекпоинты в Git
- Поиск по сессиям

**Настройка:**
```bash
npm install -g @entire/cli
entire enable
```

**Документация:** [INTEGRATIONS.md](INTEGRATIONS.md#entireio)

#### ConPort

**Что даёт:**
- Долгосрочная память
- Контекст между сессиями
- Миграция решений в GRACE

**Настройка:**
```bash
pip install context-portal
conport init --project .
```

**Документация:** [INTEGRATIONS.md](INTEGRATIONS.md#conport)

---

## vs-init Flow

### INSTALL режим

```
1. Git checkpoint safety
2. Детектирование конфликтов (6 типов)
3. Выбор режима (LITE/ADVANCED)
4. Создание vs.project.toml
5. Генерация AGENTS.md
6. Создание GRACE артефактов
7. Настройка интеграций (если ADVANCED)
```

### UPDATE режим

```
1. Git checkpoint safety
2. Чтение текущей конфигурации
3. Определение изменений
4. Backup текущей установки
5. Обновление файлов
6. Обновление интеграций
7. Финальная проверка
```

### REPAIR режим

```
1. Git checkpoint safety
2. Сканирование проблем
3. Исправление проблем
4. Финальная проверка
```

### MIGRATE режим

```
1. Git checkpoint safety
2. Чтение конфигурации v1.x
3. Миграция структуры
4. Миграция vs.project.toml
5. Миграция GRACE артефактов
6. Миграция AGENTS.md
7. Финальная проверка
```

### REFRESH режим

```
1. Git checkpoint safety
2. Чтение конфигурации
3. Backup AGENTS.md
4. Перегенерация AGENTS.md
5. Проверка GRACE артефактов
6. Проверка интеграций
7. Финальная проверка
```

---

## Конфликты

### 6 типов конфликтов

| Тип | Название | Что детектируем |
|-----|----------|-----------------|
| **CONF-001** | AGENTS.md exists | Существует ли AGENTS.md |
| **CONF-002** | GRACE artifacts exist | Существуют ли docs/*.xml |
| **CONF-003** | MCP servers configured | Настроены ли другие MCP серверы |
| **CONF-004** | Entire.io installed | Установлен ли Entire.io |
| **CONF-005** | ConPort installed | Установлен ли ConPort |
| **CONF-006** | Git hooks exist | Существуют ли Git хуки |

### Стратегии разрешения

| Тип | Стратегия 1 | Стратегия 2 | Стратегия 3 |
|-----|-------------|-------------|-------------|
| CONF-001 | Backup + replace | Merge | Skip |
| CONF-002 | Preserve + update | Replace | Skip |
| CONF-003 | Disable old + enable new | Keep old | Manual |
| CONF-004 | Skip | Reinstall | Check version |
| CONF-005 | Skip | Reinstall | Update config |
| CONF-006 | Merge hooks | Replace | Skip |

---

## GRACE Session Management

### Начало сессии

```bash
/grace-session start "Implement M-Auth module"
```

**Что происходит:**
1. Генерируется Session ID
2. Загружается контекст (ConPort если включён)
3. Загружаются GRACE контракты
4. Создаётся запись в session log
5. Начинается capture сессии (Entire.io если включён)

### Конец сессии

```bash
/grace-session end "Completed M-Auth contract and implementation"
```

**Что происходит:**
1. Записывается summary
2. Обновляется session log
3. Сохраняется в ConPort (если включён)
4. Link к checkpoint (Entire.io если включён)
5. Предлагается миграция решений в GRACE

---

## GRACE Markup Style

### TypeScript

```typescript
// [M-Auth][contract] Authentication contract
export interface IAuth {
  login(credentials: Credentials): Promise<Token>;
  logout(): Promise<void>;
}

// [M-Auth][impl] Authentication implementation
export class AuthService implements IAuth {
  async login(credentials: Credentials): Promise<Token> {
    // [D-003] JWT for authentication
    return this.jwtService.sign(credentials);
  }
}
```

### Python

```python
# [M-Auth][contract] Authentication contract
class IAuth(Protocol):
    def login(self, credentials: Credentials) -> Token: ...
    def logout(self) -> None: ...

# [M-Auth][impl] Authentication implementation
class AuthService:
    def login(self, credentials: Credentials) -> Token:
        # [D-003] JWT for authentication
        return self.jwt_service.sign(credentials)
```

---

## Best Practices

### GRACE Артефакты

1. **Храни артефакты актуальными** — запускай `/grace-refresh` после изменений
2. **Проверяй статус** — `/grace-status` перед началом работы
3. **Мигрируй решения** — важные решения из ConPort → decisions.xml

### Сессии

1. **Начинай сессию** — `/grace-session start "<task>"`
2. **Завершай с summary** — `/grace-session end "<summary>"`
3. **Проверяй контекст** — `/grace-session info` после перерыва

### Интеграции

1. **Entire.io** — commit часто для создания checkpoint'ов
2. **ConPort** — сохраняй важные решения через `conport store`
3. **Миграция** — мигрируй архитектурные решения в GRACE

---

## Troubleshooting

### vs-init не запускается

```
Проверь:
1. .vibestart/ существует
2. vs-init/SKILL.md существует
3. Агент имеет доступ к файловой системе
```

### Интеграции не работают

```
Entire.io:
  entire status
  entire enable

ConPort:
  conport status
  conport init --project .
```

### GRACE артефакты рассинхронизированы

```
/grace-refresh
```

### Session context не загружается

```
Проверь ConPort:
  conport list
  conport recall "<task>"
```

---

## Ссылки

- **README:** ../README.md
- **INTEGRATIONS.md:** INTEGRATIONS.md
- **GRACE Marketplace:** https://github.com/osovv/grace-marketplace
- **ConPort:** https://github.com/GreatScottyMac/context-portal
- **Entire.io:** https://github.com/entireio/cli
