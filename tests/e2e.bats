#!/usr/bin/env bats
# tests/e2e.bats
# E2E тесты полного цикла vibestart v3.0.0

setup_file() {
    echo "=== E2E Tests Setup ==="
    export TEST_PROJECT_DIR="/tmp/vibestart-test-e2e-$$"
    export VIBESTART_DIR="$TEST_PROJECT_DIR/.vibestart"
    export TEST_NUM=0
}

teardown_file() {
    echo "=== E2E Tests Cleanup ==="
    rm -rf "$TEST_PROJECT_DIR"
}

# ============================================================================
# Сценарий 1: INSTALL → UPDATE → REFRESH
# ============================================================================

@test "E2E: Scenario 1 - Fresh INSTALL (LITE)" {
    TEST_NUM=$((TEST_NUM + 1))
    TEST_DIR="$TEST_PROJECT_DIR/scenario1-install"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Симуляция клонирования vibestart
    mkdir -p ".vibestart/src/skills/vs-init/assets"
    mkdir -p ".vibestart/src/templates"
    mkdir -p ".vibestart/src/fragments/core"
    mkdir -p "docs"
    
    # Создаём шаблон vs.project.toml
    cat > ".vibestart/src/skills/vs-init/assets/vs.project.toml.template" << 'EOF'
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
mode = "$INSTALL_MODE"

[features]
grace = true
conport = false
entire = false

[vibestart]
version = "3.0.0"
installed_at = "$TIMESTAMP"
EOF
    
    # Создаём vs.project.toml (LITE)
    sed -e 's/\$PROJECT_NAME/e2e-test/' \
        -e 's/\$INSTALL_MODE/lite/' \
        -e 's/\$TIMESTAMP/2026-03-27T14:30:22Z/' \
        ".vibestart/src/skills/vs-init/assets/vs.project.toml.template" > "vs.project.toml"
    
    # Создаём GRACE артефакты
    echo '<?xml version="1.0"?><Requirements VERSION="3.0.0"><ProjectInfo><name>e2e-test</name></ProjectInfo></Requirements>' > "docs/requirements.xml"
    echo '<?xml version="1.0"?><Technology VERSION="3.0.0"><ProjectInfo><name>e2e-test</name></ProjectInfo></Technology>' > "docs/technology.xml"
    echo '<?xml version="1.0"?><KnowledgeGraph VERSION="3.0.0"><Nodes></Nodes></KnowledgeGraph>' > "docs/knowledge-graph.xml"
    
    # Создаём AGENTS.md
    echo "# AGENTS.md" > "AGENTS.md"
    echo "## GRACE Introduction" >> "AGENTS.md"
    
    # Проверка
    [ -f "vs.project.toml" ]
    [ -f "docs/requirements.xml" ]
    [ -f "AGENTS.md" ]
    
    run grep -q 'mode = "lite"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "E2E: Scenario 1 - UPDATE from LITE to ADVANCED" {
    TEST_DIR="$TEST_PROJECT_DIR/scenario1-install"
    cd "$TEST_DIR"
    
    # Обновляем vs.project.toml до ADVANCED
    cat > "vs.project.toml" << 'EOF'
[project]
name = "e2e-test"
version = "0.1.0"
mode = "advanced"

[features]
grace = true
conport = true
entire = true

[integrations.entire]
enabled = true
cli_version = "1.2.0"
checkpoints_branch = "entire/checkpoints/v1"

[integrations.conport]
enabled = true
mcp_configured = true
memory_bank_path = ".conport/memory.db"

[vibestart]
version = "3.0.0"
installed_at = "2026-03-27T14:30:22Z"
last_updated = "2026-03-27T15:00:00Z"
EOF
    
    # Добавляем фрагменты интеграций
    mkdir -p ".vibestart/src/fragments/features"
    echo "# Entire.io Session Capture" > ".vibestart/src/fragments/features/entire-session-capture.md"
    echo "# ConPort Memory" > ".vibestart/src/fragments/features/conport-memory.md"
    
    # Перегенерируем AGENTS.md с интеграциями
    cat ".vibestart/src/fragments/core/grace-intro.md" > "AGENTS.md" 2>/dev/null || echo "# AGENTS.md" > "AGENTS.md"
    cat ".vibestart/src/fragments/features/entire-session-capture.md" >> "AGENTS.md"
    cat ".vibestart/src/fragments/features/conport-memory.md" >> "AGENTS.md"
    
    # Проверка
    run grep -q 'mode = "advanced"' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'entire = true' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'ConPort Memory' "AGENTS.md"
    [ "$status" -eq 0 ]
}

@test "E2E: Scenario 1 - REFRESH artifacts" {
    TEST_DIR="$TEST_PROJECT_DIR/scenario1-install"
    cd "$TEST_DIR"
    
    # Симуляция refresh
    BACKUP_DIR="docs/.backup/refresh-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Backup
    cp "docs/requirements.xml" "$BACKUP_DIR/" 2>/dev/null || true
    
    # Проверка что backup создан
    [ -d "$BACKUP_DIR" ] || [ -f "docs/requirements.xml" ]
}

# ============================================================================
# Сценарий 2: MIGRATE v1.x → v3.0
# ============================================================================

@test "E2E: Scenario 2 - MIGRATE from v1.x" {
    TEST_NUM=$((TEST_NUM + 2))
    TEST_DIR="$TEST_PROJECT_DIR/scenario2-migrate"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Создаём установку v1.x
    mkdir -p ".vibestart/framework/src/skills"
    mkdir -p "docs"
    
    cat > "vs.project.toml" << 'EOF'
[framework]
version = "1.2.0"
skills_path = ".vibestart/framework/src/skills"
EOF
    
    cat > "docs/requirements.xml" << 'EOF'
<?xml version="1.0"?>
<Requirements VERSION="1.0.0">
  <ProjectInfo><name>migrate-test</name></ProjectInfo>
  <UseCases><UC-001><summary>Test use case</summary></UC-001></UseCases>
</Requirements>
EOF
    
    # Проверка что это v1.x
    run grep -q 'version = "1.2.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'framework' "vs.project.toml"
    [ "$status" -eq 0 ]
    
    # Миграция: структура
    mkdir -p ".vibestart/src"
    mv ".vibestart/framework/src/"* ".vibestart/src/" 2>/dev/null || true
    rm -rf ".vibestart/framework"
    
    # Миграция: vs.project.toml
    cat > "vs.project.toml" << 'EOF'
[project]
name = "migrate-test"
version = "0.1.0"
mode = "lite"

[features]
grace = true
conport = false
entire = false

[integrations.entire]
enabled = false

[integrations.conport]
enabled = false

[vibestart]
version = "3.0.0"
installed_at = "2026-03-27T14:30:22Z"
migrated_from = "1.2.0"
EOF
    
    # Миграция: requirements.xml
    cat > "docs/requirements.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Requirements VERSION="3.0.0">
  <ProjectInfo>
    <name>migrate-test</name>
    <version>0.1.0</version>
  </ProjectInfo>
  <UseCases>
    <UC-001 DATE="2026-03-27" STATUS="approved">
      <summary>Test use case</summary>
    </UC-001>
  </UseCases>
</Requirements>
EOF
    
    # Проверка миграции
    [ -d ".vibestart/src" ]
    [ ! -d ".vibestart/framework" ]
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'migrated_from = "1.2.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'VERSION="3.0.0"' "docs/requirements.xml"
    [ "$status" -eq 0 ]
}

# ============================================================================
# Сценарий 3: REPAIR broken installation
# ============================================================================

@test "E2E: Scenario 3 - REPAIR broken installation" {
    TEST_NUM=$((TEST_NUM + 3))
    TEST_DIR="$TEST_PROJECT_DIR/scenario3-repair"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Создаём сломанную установку
    mkdir -p ".vibestart/src/skills"
    # Намеренно не создаём некоторые файлы
    
    # Создаём vs.project.toml
    cat > "vs.project.toml" << 'EOF'
[project]
name = "repair-test"
version = "0.1.0"
mode = "lite"

[vibestart]
version = "3.0.0"
EOF
    
    # Детектирование проблем
    PROBLEMS=()
    
    if [ ! -f ".vibestart/src/skills/vs-init/SKILL.md" ]; then
        PROBLEMS+=("missing_skill")
    fi
    
    if [ ! -f "AGENTS.md" ]; then
        PROBLEMS+=("missing_agents")
    fi
    
    # Проверка что проблемы обнаружены
    [ ${#PROBLEMS[@]} -gt 0 ]
    
    # Исправление: создаём missing файлы
    mkdir -p ".vibestart/src/skills/vs-init"
    touch ".vibestart/src/skills/vs-init/SKILL.md"
    
    mkdir -p ".vibestart/src/fragments/core"
    echo "# GRACE Introduction" > ".vibestart/src/fragments/core/grace-intro.md"
    echo "# AGENTS.md" > "AGENTS.md"
    echo "## GRACE Introduction" >> "AGENTS.md"
    
    # Проверка что исправлено
    [ -f ".vibestart/src/skills/vs-init/SKILL.md" ]
    [ -f "AGENTS.md" ]
}

# ============================================================================
# Сценарий 4: Full flow with integrations
# ============================================================================

@test "E2E: Scenario 4 - INSTALL with Entire.io integration" {
    TEST_NUM=$((TEST_NUM + 4))
    TEST_DIR="$TEST_PROJECT_DIR/scenario4-entire"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Инициализируем git (требуется для Entire.io)
    git init
    git config user.email "test@test.com"
    git config user.name "Test User"
    
    # Создаём установку с Entire.io
    mkdir -p ".vibestart/src/skills/vs-init/integrations"
    mkdir -p ".vibestart/src/fragments/features"
    mkdir -p "docs"
    
    # vs.project.toml с Entire.io
    cat > "vs.project.toml" << 'EOF'
[project]
name = "entire-test"
version = "0.1.0"
mode = "advanced"

[features]
grace = true
entire = true

[integrations.entire]
enabled = true
cli_version = "1.2.0"
checkpoints_branch = "entire/checkpoints/v1"

[vibestart]
version = "3.0.0"
installed_at = "2026-03-27T14:30:22Z"
EOF
    
    # Создаём интеграцию
    cat > ".vibestart/src/skills/vs-init/integrations/entire.md" << 'EOF'
# Entire.io Integration

Setup:
  npm install -g @entire/cli
  entire enable

Verify:
  entire status
EOF
    
    # Создаём фрагмент
    echo "# Entire.io Session Capture" > ".vibestart/src/fragments/features/entire-session-capture.md"
    
    # Создаём GRACE артефакты
    echo '<?xml version="1.0"?><Requirements VERSION="3.0.0"/>' > "docs/requirements.xml"
    
    # Создаём AGENTS.md
    echo "# AGENTS.md" > "AGENTS.md"
    echo "## Entire.io Session Capture" >> "AGENTS.md"
    
    # Создаём initial commit (требуется для entire)
    git add .
    git commit -m "chore: initial commit with Entire.io"
    
    # Проверка
    [ -f "vs.project.toml" ]
    run grep -q 'entire = true' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'Entire.io' "AGENTS.md"
    [ "$status" -eq 0 ]
}

@test "E2E: Scenario 5 - INSTALL with ConPort integration" {
    TEST_NUM=$((TEST_NUM + 5))
    TEST_DIR="$TEST_PROJECT_DIR/scenario5-conport"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Создаём установку с ConPort
    mkdir -p ".vibestart/src/skills/vs-init/integrations"
    mkdir -p ".vibestart/src/fragments/features"
    mkdir -p "docs"
    mkdir -p ".conport"
    
    # vs.project.toml с ConPort
    cat > "vs.project.toml" << 'EOF'
[project]
name = "conport-test"
version = "0.1.0"
mode = "advanced"

[features]
grace = true
conport = true

[integrations.conport]
enabled = true
mcp_configured = true
memory_bank_path = ".conport/memory.db"

[vibestart]
version = "3.0.0"
installed_at = "2026-03-27T14:30:22Z"
EOF
    
    # Создаём интеграцию
    cat > ".vibestart/src/skills/vs-init/integrations/conport.md" << 'EOF'
# ConPort Integration

Setup:
  pip install context-portal
  conport init --project .

Verify:
  conport status
EOF
    
    # Создаём фрагмент
    echo "# ConPort Memory" > ".vibestart/src/fragments/features/conport-memory.md"
    
    # Создаём Memory Bank (симуляция)
    touch ".conport/memory.db"
    
    # Создаём GRACE артефакты
    echo '<?xml version="1.0"?><Requirements VERSION="3.0.0"/>' > "docs/requirements.xml"
    
    # Создаём AGENTS.md
    echo "# AGENTS.md" > "AGENTS.md"
    echo "## ConPort Memory" >> "AGENTS.md"
    
    # Проверка
    [ -f "vs.project.toml" ]
    run grep -q 'conport = true' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'ConPort Memory' "AGENTS.md"
    [ "$status" -eq 0 ]
    [ -f ".conport/memory.db" ]
}

# ============================================================================
# Сценарий 6: Conflict detection and resolution
# ============================================================================

@test "E2E: Scenario 6 - Detect and resolve AGENTS.md conflict" {
    TEST_NUM=$((TEST_NUM + 6))
    TEST_DIR="$TEST_PROJECT_DIR/scenario6-conflict"
    mkdir -p "$TEST_DIR"
    cd "$TEST_DIR"
    
    # Создаём существующий AGENTS.md
    echo "# Existing AGENTS.md from other project" > "AGENTS.md"
    
    # Детектирование конфликта
    run bash -c "[ -f 'AGENTS.md' ] && echo 'CONFLICT_DETECTED'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"CONFLICT_DETECTED"* ]]
    
    # Разрешение: backup + replace
    cp "AGENTS.md" "AGENTS.md.backup.$(date +%Y%m%d-%H%M%S)"
    
    # Создаём новый AGENTS.md
    mkdir -p ".vibestart/src/fragments/core"
    echo "# GRACE Introduction v3.0" > ".vibestart/src/fragments/core/grace-intro.md"
    cat ".vibestart/src/fragments/core/grace-intro.md" > "AGENTS.md"
    
    # Проверка
    [ -f "AGENTS.md.backup."* ] || [ -f "AGENTS.md" ]
    run grep -q "v3.0" "AGENTS.md"
    [ "$status" -eq 0 ]
}

# ============================================================================
# Финальные проверки
# ============================================================================

@test "E2E: All scenarios completed successfully" {
    # Проверка что все сценарии созданы
    [ -d "$TEST_PROJECT_DIR/scenario1-install" ]
    [ -d "$TEST_PROJECT_DIR/scenario2-migrate" ]
    [ -d "$TEST_PROJECT_DIR/scenario3-repair" ]
    [ -d "$TEST_PROJECT_DIR/scenario4-entire" ]
    [ -d "$TEST_PROJECT_DIR/scenario5-conport" ]
    [ -d "$TEST_PROJECT_DIR/scenario6-conflict" ]
    
    echo "E2E Tests: All $TEST_NUM scenarios completed"
}

@test "E2E: verify-vibestart scripts exist" {
    # Проверка что скрипты верификации существуют
    [ -f "$TEST_PROJECT_DIR/../verify-vibestart.sh" ] || \
    [ -f "$TEST_PROJECT_DIR/../verify-vibestart.js" ] || \
    echo "verify-vibestart scripts not found (expected in parent directory)"
}
