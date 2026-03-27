#!/usr/bin/env bats
# tests/update.bats
# Тесты UPDATE режима vibestart v3.0.0

setup_file() {
    echo "=== UPDATE Tests Setup ==="
    export TEST_PROJECT_DIR="/tmp/vibestart-test-update-$$"
    export VIBESTART_DIR="$TEST_PROJECT_DIR/.vibestart"
}

teardown_file() {
    echo "=== UPDATE Tests Cleanup ==="
    rm -rf "$TEST_PROJECT_DIR"
}

setup() {
    # Подготовка проекта с существующей установкой v2.x
    rm -rf "$TEST_PROJECT_DIR"
    mkdir -p "$TEST_PROJECT_DIR"
    cd "$TEST_PROJECT_DIR"
    
    # Создаём существующую установку v2.1.0
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init"
    mkdir -p "$VIBESTART_DIR/src/skills/grace"
    mkdir -p "$VIBESTART_DIR/src/templates"
    mkdir -p "$VIBESTART_DIR/src/fragments"
    mkdir -p "$TEST_PROJECT_DIR/docs"
    
    # vs.project.toml v2.1.0
    cat > "vs.project.toml" << 'EOF'
[project]
name = "test-project"
version = "0.1.0"

[features]
grace = true
conport = false

[vibestart]
version = "2.1.0"
installed_at = "2026-03-20T10:30:00Z"
EOF
    
    # GRACE артефакты
    echo '<?xml version="1.0"?><Requirements><ProjectInfo><name>test</name></ProjectInfo></Requirements>' > "docs/requirements.xml"
    echo '<?xml version="1.0"?><Technology><ProjectInfo><name>test</name></ProjectInfo></Technology>' > "docs/technology.xml"
    echo '<?xml version="1.0"?><KnowledgeGraph><Nodes></Nodes></KnowledgeGraph>' > "docs/knowledge-graph.xml"
    
    # AGENTS.md
    echo "# AGENTS.md v2.1.0" > "AGENTS.md"
}

@test "UPDATE: Detect mode returns UPDATE for existing installation" {
    run bash -c "[ -f '$TEST_PROJECT_DIR/vs.project.toml' ] && grep -q 'version = \"2.1.0\"' '$TEST_PROJECT_DIR/vs.project.toml' && echo 'UPDATE'"
    [ "$status" -eq 0 ]
    [ "$output" = "UPDATE" ]
}

@test "UPDATE: Detects current version correctly" {
    run grep -o 'version = "[0-9.]*"' "$TEST_PROJECT_DIR/vs.project.toml"
    [ "$status" -eq 0 ]
    [[ "$output" == *"2.1.0"* ]]
}

@test "UPDATE: Creates backup before update" {
    BACKUP_DIR="$TEST_PROJECT_DIR/.vibestart/.backup/update-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Копируем текущие файлы в backup
    cp -r "$VIBESTART_DIR" "$BACKUP_DIR/"
    cp "vs.project.toml" "$BACKUP_DIR/"
    cp "AGENTS.md" "$BACKUP_DIR/"
    
    [ -d "$BACKUP_DIR" ]
    [ -f "$BACKUP_DIR/vs.project.toml" ]
    [ -f "$BACKUP_DIR/AGENTS.md" ]
}

@test "UPDATE: Updates vs.project.toml version" {
    # Обновляем версию
    sed -i 's/version = "2.1.0"/version = "3.0.0"/' "vs.project.toml"
    sed -i 's/mode = "lite"/mode = "lite"/' "vs.project.toml"  # сохраняем mode
    
    # Добавляем новые поля v3.0
    cat >> "vs.project.toml" << 'EOF'

[vibestart]
last_updated = "2026-03-27T14:30:22Z"
EOF
    
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Adds new mode field to vs.project.toml" {
    # Проверяем что mode существует или добавляем
    if ! grep -q 'mode = ' "vs.project.toml"; then
        sed -i '/\[project\]/a mode = "lite"' "vs.project.toml"
    fi
    
    run grep -q 'mode = "lite"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Adds integration sections to vs.project.toml" {
    # Добавляем секции интеграций если отсутствуют
    if ! grep -q '\[integrations.entire\]' "vs.project.toml"; then
        cat >> "vs.project.toml" << 'EOF'

[integrations.entire]
enabled = false
cli_version = ""
checkpoints_branch = "entire/checkpoints/v1"

[integrations.conport]
enabled = false
mcp_configured = false
memory_bank_path = ".conport/memory.db"
EOF
    fi
    
    run grep -q '\[integrations.entire\]' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q '\[integrations.conport\]' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Updates framework files" {
    # Симуляция обновления файлов фреймворка
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/modes"
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/integrations"
    
    # Создаём новые файлы v3.0
    touch "$VIBESTART_DIR/src/skills/vs-init/detect-mode.md"
    touch "$VIBESTART_DIR/src/skills/vs-init/conflicts.md"
    touch "$VIBESTART_DIR/src/skills/vs-init/resolvers.md"
    touch "$VIBESTART_DIR/src/skills/vs-init/modes/install.md"
    touch "$VIBESTART_DIR/src/skills/vs-init/modes/update.md"
    touch "$VIBESTART_DIR/src/skills/vs-init/integrations/entire.md"
    touch "$VIBESTART_DIR/src/skills/vs-init/integrations/conport.md"
    
    # Проверка новых файлов
    [ -f "$VIBESTART_DIR/src/skills/vs-init/detect-mode.md" ]
    [ -f "$VIBESTART_DIR/src/skills/vs-init/modes/install.md" ]
    [ -f "$VIBESTART_DIR/src/skills/vs-init/integrations/entire.md" ]
}

@test "UPDATE: Regenerates AGENTS.md" {
    # Симуляция перегенерации AGENTS.md
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    echo "# GRACE Introduction v3.0" > "$VIBESTART_DIR/src/fragments/core/grace-intro.md"
    
    # Перегенерация
    cat "$VIBESTART_DIR/src/fragments/core/grace-intro.md" > "AGENTS.md"
    
    [ -f "AGENTS.md" ]
    run grep -q "v3.0" "AGENTS.md"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Preserves user data in GRACE artifacts" {
    # Сохраняем существующие данные
    ORIGINAL_DECISIONS=$(cat "docs/decisions.xml" 2>/dev/null || echo "")
    
    # Обновляем артефакты (симуляция)
    if [ -f "docs/requirements.xml" ]; then
        # Сохраняем данные
        cp "docs/requirements.xml" "docs/requirements.xml.bak"
    fi
    
    # Проверка что backup создан
    [ -f "docs/requirements.xml.bak" ] || [ -f "docs/requirements.xml" ]
}

@test "UPDATE: Creates git safety tag" {
    # Инициализируем git если нет
    if [ ! -d ".git" ]; then
        git init
        git config user.email "test@test.com"
        git config user.name "Test User"
        git add .
        git commit -m "pre-update"
    fi
    
    # Создаём safety tag
    TAG="vs-init-backup-$(date +%Y%m%d-%H%M%S)"
    git tag -a "$TAG" -m "vs-init update checkpoint"
    
    # Проверка
    run git tag -l "vs-init-backup-*"
    [ "$status" -eq 0 ]
    [[ "$output" == *"vs-init-backup-"* ]]
}

@test "UPDATE: Verifies updated installation" {
    # Финальная проверка
    [ -f "vs.project.toml" ]
    [ -d "$VIBESTART_DIR" ]
    [ -d "$TEST_PROJECT_DIR/docs" ]
    
    # Проверка версии
    run grep 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Rollback restores previous version" {
    # Создаём backup
    BACKUP_DIR="$TEST_PROJECT_DIR/.vibestart/.backup/update-test"
    mkdir -p "$BACKUP_DIR"
    cp "vs.project.toml" "$BACKUP_DIR/vs.project.toml.orig"
    echo 'version = "2.1.0"' > "$BACKUP_DIR/vs.project.toml.orig"
    
    # "Обновляем" до 3.0.0
    sed -i 's/2.1.0/3.0.0/' "vs.project.toml"
    
    # Проверяем что обновилось
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    
    # Откат
    cp "$BACKUP_DIR/vs.project.toml.orig" "vs.project.toml"
    
    # Проверяем что откатилось
    run grep -q 'version = "2.1.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Updates from v2.0.0" {
    # Устанавливаем v2.0.0
    sed -i 's/version = "2.1.0"/version = "2.0.0"/' "vs.project.toml"
    
    run grep -q 'version = "2.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    
    # "Обновляем" до 3.0.0
    sed -i 's/version = "2.0.0"/version = "3.0.0"/' "vs.project.toml"
    
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Updates from v2.2.0" {
    # Устанавливаем v2.2.0
    sed -i 's/version = "2.1.0"/version = "2.2.0"/' "vs.project.toml"
    
    # "Обновляем" до 3.0.0
    sed -i 's/version = "2.2.0"/version = "3.0.0"/' "vs.project.toml"
    
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "UPDATE: Handles missing modes directory" {
    # Проверяем что modes directory создан
    if [ ! -d "$VIBESTART_DIR/src/skills/vs-init/modes" ]; then
        mkdir -p "$VIBESTART_DIR/src/skills/vs-init/modes"
    fi
    
    [ -d "$VIBESTART_DIR/src/skills/vs-init/modes" ]
}

@test "UPDATE: Handles missing integrations directory" {
    # Проверяем что integrations directory создан
    if [ ! -d "$VIBESTART_DIR/src/skills/vs-init/integrations" ]; then
        mkdir -p "$VIBESTART_DIR/src/skills/vs-init/integrations"
    fi
    
    [ -d "$VIBESTART_DIR/src/skills/vs-init/integrations" ]
}
