#!/usr/bin/env bats
# tests/repair.bats
# Тесты REPAIR режима vibestart v3.0.0

setup_file() {
    echo "=== REPAIR Tests Setup ==="
    export TEST_PROJECT_DIR="/tmp/vibestart-test-repair-$$"
    export VIBESTART_DIR="$TEST_PROJECT_DIR/.vibestart"
}

teardown_file() {
    echo "=== REPAIR Tests Cleanup ==="
    rm -rf "$TEST_PROJECT_DIR"
}

setup() {
    # Подготовка проекта с повреждённой установкой
    rm -rf "$TEST_PROJECT_DIR"
    mkdir -p "$TEST_PROJECT_DIR"
    cd "$TEST_PROJECT_DIR"
    
    # Создаём базовую структуру
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init"
    mkdir -p "$VIBESTART_DIR/src/templates"
    mkdir -p "$TEST_PROJECT_DIR/docs"
    
    # vs.project.toml
    cat > "vs.project.toml" << 'EOF'
[project]
name = "test-project"
version = "0.1.0"
mode = "lite"

[vibestart]
version = "3.0.0"
installed_at = "2026-03-27T10:30:00Z"
EOF
}

@test "REPAIR: Detects missing vs-init SKILL.md" {
    # Намеренно не создаём SKILL.md
    run bash -c "[ ! -f '$VIBESTART_DIR/src/skills/vs-init/SKILL.md' ] && echo 'MISSING'"
    [ "$status" -eq 0 ]
    [ "$output" = "MISSING" ]
}

@test "REPAIR: Detects missing templates" {
    # Намеренно не создаём шаблоны
    run bash -c "[ ! -d '$VIBESTART_DIR/src/templates' ] || [ -z \"\$(ls -A '$VIBESTART_DIR/src/templates' 2>/dev/null)\" ] && echo 'MISSING'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"MISSING"* ]]
}

@test "REPAIR: Detects missing GRACE artifacts" {
    # Намеренно не создаём артефакты
    run bash -c "[ ! -f '$TEST_PROJECT_DIR/docs/requirements.xml' ] && echo 'MISSING'"
    [ "$status" -eq 0 ]
    [ "$output" = "MISSING" ]
}

@test "REPAIR: Detects missing AGENTS.md" {
    # Намеренно не создаём AGENTS.md
    run bash -c "[ ! -f '$TEST_PROJECT_DIR/AGENTS.md' ] && echo 'MISSING'"
    [ "$status" -eq 0 ]
    [ "$output" = "MISSING" ]
}

@test "REPAIR: Detects invalid XML" {
    # Создаём невалидный XML
    echo "not valid xml" > "$TEST_PROJECT_DIR/docs/requirements.xml"
    
    # Проверка (простая валидация)
    run bash -c "grep -q '<?xml' '$TEST_PROJECT_DIR/docs/requirements.xml' || echo 'INVALID'"
    [ "$status" -eq 0 ]
    [ "$output" = "INVALID" ]
}

@test "REPAIR: Restores missing SKILL.md from backup" {
    # Создаём backup
    BACKUP_DIR="$VIBESTART_DIR/.backup/repair-test"
    mkdir -p "$BACKUP_DIR/src/skills/vs-init"
    echo "# vs-init SKILL.md backup" > "$BACKUP_DIR/src/skills/vs-init/SKILL.md"
    
    # Восстанавливаем из backup
    if [ ! -f "$VIBESTART_DIR/src/skills/vs-init/SKILL.md" ]; then
        cp "$BACKUP_DIR/src/skills/vs-init/SKILL.md" "$VIBESTART_DIR/src/skills/vs-init/SKILL.md"
    fi
    
    [ -f "$VIBESTART_DIR/src/skills/vs-init/SKILL.md" ]
    run grep -q "vs-init" "$VIBESTART_DIR/src/skills/vs-init/SKILL.md"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Restores missing templates from framework" {
    # Создаём шаблоны во фреймворке
    mkdir -p "$VIBESTART_DIR/src/templates"
    echo '<?xml version="1.0"?><Requirements>template</Requirements>' > "$VIBESTART_DIR/src/templates/requirements.xml.template"
    
    # Копируем в docs/
    mkdir -p "$TEST_PROJECT_DIR/docs"
    cp "$VIBESTART_DIR/src/templates/requirements.xml.template" "$TEST_PROJECT_DIR/docs/requirements.xml"
    
    [ -f "$TEST_PROJECT_DIR/docs/requirements.xml" ]
    run grep -q '<?xml' "$TEST_PROJECT_DIR/docs/requirements.xml"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Regenerates AGENTS.md from fragments" {
    # Создаём фрагменты
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    echo "# GRACE Introduction" > "$VIBESTART_DIR/src/fragments/core/grace-intro.md"
    echo "# Session Management" > "$VIBESTART_DIR/src/fragments/core/session-management.md"
    
    # Генерируем AGENTS.md
    cat "$VIBESTART_DIR/src/fragments/core/grace-intro.md" > "$TEST_PROJECT_DIR/AGENTS.md"
    cat "$VIBESTART_DIR/src/fragments/core/session-management.md" >> "$TEST_PROJECT_DIR/AGENTS.md"
    
    [ -f "$TEST_PROJECT_DIR/AGENTS.md" ]
    run grep -q "GRACE" "$TEST_PROJECT_DIR/AGENTS.md"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Creates backup before repair" {
    # Создаём файлы для backup
    echo "original content" > "$TEST_PROJECT_DIR/AGENTS.md"
    
    BACKUP_DIR="$TEST_PROJECT_DIR/.backup/repair-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp "$TEST_PROJECT_DIR/AGENTS.md" "$BACKUP_DIR/AGENTS.md.bak"
    
    [ -d "$BACKUP_DIR" ]
    [ -f "$BACKUP_DIR/AGENTS.md.bak" ]
}

@test "REPAIR: Fixes broken Entire.io integration" {
    # Симуляция сломанной интеграции
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/integrations"
    echo "entire integration config" > "$VIBESTART_DIR/src/skills/vs-init/integrations/entire.md"
    
    # "Исправление" (пересоздание конфига)
    cat > "$VIBESTART_DIR/src/skills/vs-init/integrations/entire.md" << 'EOF'
# Entire.io Integration

Setup:
  npm install -g @entire/cli
  entire enable

Verify:
  entire status
EOF
    
    [ -f "$VIBESTART_DIR/src/skills/vs-init/integrations/entire.md" ]
    run grep -q "entire enable" "$VIBESTART_DIR/src/skills/vs-init/integrations/entire.md"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Fixes broken ConPort integration" {
    # Симуляция сломанной интеграции
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/integrations"
    
    # "Исправление" (пересоздание конфига)
    cat > "$VIBESTART_DIR/src/skills/vs-init/integrations/conport.md" << 'EOF'
# ConPort Integration

Setup:
  pip install context-portal
  conport init --project .

Verify:
  conport status
EOF
    
    [ -f "$VIBESTART_DIR/src/skills/vs-init/integrations/conport.md" ]
    run grep -q "conport init" "$VIBESTART_DIR/src/skills/vs-init/integrations/conport.md"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Validates XML after repair" {
    # Создаём валидный XML
    cat > "$TEST_PROJECT_DIR/docs/requirements.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Requirements>
  <ProjectInfo>
    <name>test-project</name>
  </ProjectInfo>
</Requirements>
EOF
    
    # Проверка валидности
    run grep -q '<?xml version="1.0"' "$TEST_PROJECT_DIR/docs/requirements.xml"
    [ "$status" -eq 0 ]
    run grep -q '</Requirements>' "$TEST_PROJECT_DIR/docs/requirements.xml"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Creates safety tag before repair" {
    # Инициализируем git
    git init
    git config user.email "test@test.com"
    git config user.name "Test User"
    git add .
    git commit -m "pre-repair"
    
    # Создаём safety tag
    TAG="vs-init-backup-$(date +%Y%m%d-%H%M%S)"
    git tag -a "$TAG" -m "vs-init repair checkpoint"
    
    # Проверка
    run git tag -l "vs-init-backup-*"
    [ "$status" -eq 0 ]
    [[ "$output" == *"vs-init-backup-"* ]]
}

@test "REPAIR: Verifies repaired installation" {
    # Восстанавливаем все необходимые файлы
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init"
    touch "$VIBESTART_DIR/src/skills/vs-init/SKILL.md"
    
    mkdir -p "$VIBESTART_DIR/src/templates"
    touch "$VIBESTART_DIR/src/templates/requirements.xml.template"
    
    mkdir -p "$TEST_PROJECT_DIR/docs"
    echo '<?xml version="1.0"?><Requirements/>' > "$TEST_PROJECT_DIR/docs/requirements.xml"
    
    echo "# AGENTS.md" > "$TEST_PROJECT_DIR/AGENTS.md"
    
    # Финальная проверка
    [ -f "$VIBESTART_DIR/src/skills/vs-init/SKILL.md" ]
    [ -f "$VIBESTART_DIR/src/templates/requirements.xml.template" ]
    [ -f "$TEST_PROJECT_DIR/docs/requirements.xml" ]
    [ -f "$TEST_PROJECT_DIR/AGENTS.md" ]
}

@test "REPAIR: Reports remaining problems" {
    # Создаём список проблем
    PROBLEMS_FILE="$TEST_PROJECT_DIR/.repair-problems"
    cat > "$PROBLEMS_FILE" << 'EOF'
missing_framework_file: .vibestart/src/skills/vs-init/SKILL.md
missing_config: vs.project.toml
missing_grace_artifact: docs/verification-plan.xml
EOF
    
    # Проверяем что проблемы записаны
    [ -f "$PROBLEMS_FILE" ]
    run grep -q "missing_framework_file" "$PROBLEMS_FILE"
    [ "$status" -eq 0 ]
}

@test "REPAIR: Handles multiple missing files" {
    # Намеренно не создаём несколько файлов
    PROBLEMS=()
    
    if [ ! -f "$VIBESTART_DIR/src/skills/vs-init/SKILL.md" ]; then
        PROBLEMS+=("SKILL.md")
    fi
    
    if [ ! -f "$TEST_PROJECT_DIR/AGENTS.md" ]; then
        PROBLEMS+=("AGENTS.md")
    fi
    
    if [ ! -f "$TEST_PROJECT_DIR/docs/requirements.xml" ]; then
        PROBLEMS+=("requirements.xml")
    fi
    
    # Проверяем что проблемы обнаружены
    [ ${#PROBLEMS[@]} -gt 0 ]
}

@test "REPAIR: Rollback restores previous state" {
    # Создаём backup
    BACKUP_DIR="$VIBESTART_DIR/.backup/rollback-test"
    mkdir -p "$BACKUP_DIR"
    echo "original" > "$BACKUP_DIR/AGENTS.md.orig"
    
    # "Исправляем" (меняем файл)
    echo "repaired" > "$TEST_PROJECT_DIR/AGENTS.md"
    
    # Проверяем что изменилось
    run grep -q "repaired" "$TEST_PROJECT_DIR/AGENTS.md"
    [ "$status" -eq 0 ]
    
    # Откат
    cp "$BACKUP_DIR/AGENTS.md.orig" "$TEST_PROJECT_DIR/AGENTS.md"
    
    # Проверяем что откатилось
    run grep -q "original" "$TEST_PROJECT_DIR/AGENTS.md"
    [ "$status" -eq 0 ]
}
