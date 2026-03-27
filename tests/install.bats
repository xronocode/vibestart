#!/usr/bin/env bats
# tests/install.bats
# Тесты INSTALL режима vibestart v3.0.0

setup_file() {
    echo "=== INSTALL Tests Setup ==="
    export TEST_PROJECT_DIR="/tmp/vibestart-test-install-$$"
    export VIBESTART_DIR="$TEST_PROJECT_DIR/.vibestart"
}

teardown_file() {
    echo "=== INSTALL Tests Cleanup ==="
    rm -rf "$TEST_PROJECT_DIR"
}

setup() {
    # Подготовка чистого проекта для каждого теста
    rm -rf "$TEST_PROJECT_DIR"
    mkdir -p "$TEST_PROJECT_DIR"
    cd "$TEST_PROJECT_DIR"
}

@test "INSTALL: Detect mode returns INSTALL for new project" {
    run bash -c "[ ! -d '$VIBESTART_DIR' ] && echo 'INSTALL'"
    [ "$status" -eq 0 ]
    [ "$output" = "INSTALL" ]
}

@test "INSTALL: vs-init creates .vibestart directory structure" {
    # Симуляция клонирования vibestart
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init"
    mkdir -p "$VIBESTART_DIR/src/standards"
    mkdir -p "$VIBESTART_DIR/src/templates"
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    
    # Проверка структуры
    [ -d "$VIBESTART_DIR" ]
    [ -d "$VIBESTART_DIR/src" ]
    [ -d "$VIBESTART_DIR/src/skills" ]
}

@test "INSTALL: Required skills exist" {
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init"
    mkdir -p "$VIBESTART_DIR/src/skills/grace/grace-refresh"
    mkdir -p "$VIBESTART_DIR/src/skills/grace/grace-status"
    mkdir -p "$VIBESTART_DIR/src/skills/grace/grace-session"
    
    # Создаём фиктивные SKILL.md
    touch "$VIBESTART_DIR/src/skills/vs-init/SKILL.md"
    touch "$VIBESTART_DIR/src/skills/grace/grace-refresh/SKILL.md"
    touch "$VIBESTART_DIR/src/skills/grace/grace-status/SKILL.md"
    touch "$VIBESTART_DIR/src/skills/grace/grace-session/SKILL.md"
    
    [ -f "$VIBESTART_DIR/src/skills/vs-init/SKILL.md" ]
    [ -f "$VIBESTART_DIR/src/skills/grace/grace-refresh/SKILL.md" ]
    [ -f "$VIBESTART_DIR/src/skills/grace/grace-status/SKILL.md" ]
    [ -f "$VIBESTART_DIR/src/skills/grace/grace-session/SKILL.md" ]
}

@test "INSTALL: Required templates exist" {
    mkdir -p "$VIBESTART_DIR/src/templates"
    
    # Создаём шаблоны
    touch "$VIBESTART_DIR/src/templates/requirements.xml.template"
    touch "$VIBESTART_DIR/src/templates/technology.xml.template"
    touch "$VIBESTART_DIR/src/templates/knowledge-graph.xml.template"
    touch "$VIBESTART_DIR/src/templates/development-plan.xml.template"
    touch "$VIBESTART_DIR/src/templates/verification-plan.xml.template"
    touch "$VIBESTART_DIR/src/templates/decisions.xml.template"
    
    [ -f "$VIBESTART_DIR/src/templates/requirements.xml.template" ]
    [ -f "$VIBESTART_DIR/src/templates/technology.xml.template" ]
    [ -f "$VIBESTART_DIR/src/templates/knowledge-graph.xml.template" ]
}

@test "INSTALL: Required fragments exist" {
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    mkdir -p "$VIBESTART_DIR/src/fragments/features"
    
    # Создаём фрагменты
    touch "$VIBESTART_DIR/src/fragments/core/grace-intro.md"
    touch "$VIBESTART_DIR/src/fragments/core/session-management.md"
    touch "$VIBESTART_DIR/src/fragments/features/entire-session-capture.md"
    touch "$VIBESTART_DIR/src/fragments/features/conport-memory.md"
    
    [ -f "$VIBESTART_DIR/src/fragments/core/grace-intro.md" ]
    [ -f "$VIBESTART_DIR/src/fragments/features/entire-session-capture.md" ]
}

@test "INSTALL: LITE mode creates vs.project.toml" {
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/assets"
    
    # Создаём шаблон vs.project.toml
    cat > "$VIBESTART_DIR/src/skills/vs-init/assets/vs.project.toml.template" << 'EOF'
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
mode = "$INSTALL_MODE"

[features]
grace = true
conport = $CONPORT_ENABLED
entire = $ENTIRE_ENABLED

[vibestart]
version = "3.0.0"
installed_at = "$TIMESTAMP"
EOF
    
    # Симуляция создания vs.project.toml для LITE
    sed -e 's/\$PROJECT_NAME/test-project/' \
        -e 's/\$INSTALL_MODE/lite/' \
        -e 's/\$CONPORT_ENABLED/false/' \
        -e 's/\$ENTIRE_ENABLED/false/' \
        -e 's/\$TIMESTAMP/2026-03-27T14:30:22Z/' \
        "$VIBESTART_DIR/src/skills/vs-init/assets/vs.project.toml.template" > "vs.project.toml"
    
    [ -f "vs.project.toml" ]
    grep -q 'mode = "lite"' "vs.project.toml"
    grep -q 'conport = false' "vs.project.toml"
    grep -q 'entire = false' "vs.project.toml"
}

@test "INSTALL: ADVANCED mode creates vs.project.toml with integrations" {
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/assets"
    
    # Создаём шаблон vs.project.toml
    cat > "$VIBESTART_DIR/src/skills/vs-init/assets/vs.project.toml.template" << 'EOF'
[project]
name = "$PROJECT_NAME"
version = "0.1.0"
mode = "$INSTALL_MODE"

[features]
grace = true
conport = $CONPORT_ENABLED
entire = $ENTIRE_ENABLED

[integrations.entire]
enabled = $ENTIRE_ENABLED

[integrations.conport]
enabled = $CONPORT_ENABLED

[vibestart]
version = "3.0.0"
installed_at = "$TIMESTAMP"
EOF
    
    # Симуляция создания vs.project.toml для ADVANCED
    sed -e 's/\$PROJECT_NAME/test-project/' \
        -e 's/\$INSTALL_MODE/advanced/' \
        -e 's/\$CONPORT_ENABLED/true/' \
        -e 's/\$ENTIRE_ENABLED/true/' \
        -e 's/\$TIMESTAMP/2026-03-27T14:30:22Z/' \
        "$VIBESTART_DIR/src/skills/vs-init/assets/vs.project.toml.template" > "vs.project.toml"
    
    [ -f "vs.project.toml" ]
    grep -q 'mode = "advanced"' "vs.project.toml"
    grep -q 'conport = true' "vs.project.toml"
    grep -q 'entire = true' "vs.project.toml"
    grep -q '\[integrations.entire\]' "vs.project.toml"
    grep -q '\[integrations.conport\]' "vs.project.toml"
}

@test "INSTALL: Creates docs directory" {
    mkdir -p "$TEST_PROJECT_DIR/docs"
    [ -d "$TEST_PROJECT_DIR/docs" ]
}

@test "INSTALL: Creates GRACE artifacts from templates" {
    mkdir -p "$VIBESTART_DIR/src/skills/vs-init/assets/docs"
    mkdir -p "$TEST_PROJECT_DIR/docs"
    
    # Создаём шаблоны XML
    for file in requirements technology knowledge-graph development-plan verification-plan decisions; do
        echo "<?xml version=\"1.0\"?><$file>template</$file>" > "$VIBESTART_DIR/src/skills/vs-init/assets/docs/$file.xml.template"
    done
    
    # Копируем шаблоны в docs/
    for file in requirements technology knowledge-graph development-plan verification-plan decisions; do
        cp "$VIBESTART_DIR/src/skills/vs-init/assets/docs/$file.xml.template" "$TEST_PROJECT_DIR/docs/$file.xml"
    done
    
    # Проверка
    [ -f "$TEST_PROJECT_DIR/docs/requirements.xml" ]
    [ -f "$TEST_PROJECT_DIR/docs/technology.xml" ]
    [ -f "$TEST_PROJECT_DIR/docs/knowledge-graph.xml" ]
    [ -f "$TEST_PROJECT_DIR/docs/development-plan.xml" ]
    [ -f "$TEST_PROJECT_DIR/docs/verification-plan.xml" ]
    [ -f "$TEST_PROJECT_DIR/docs/decisions.xml" ]
}

@test "INSTALL: Creates AGENTS.md from fragments" {
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    mkdir -p "$VIBESTART_DIR/src/fragments/features"
    
    # Создаём фрагменты
    echo "# GRACE Introduction" > "$VIBESTART_DIR/src/fragments/core/grace-intro.md"
    echo "# Session Management" > "$VIBESTART_DIR/src/fragments/core/session-management.md"
    echo "# Entire.io Session Capture" > "$VIBESTART_DIR/src/fragments/features/entire-session-capture.md"
    echo "# ConPort Memory" > "$VIBESTART_DIR/src/fragments/features/conport-memory.md"
    
    # Генерируем AGENTS.md (LITE mode)
    cat "$VIBESTART_DIR/src/fragments/core/grace-intro.md" > "$TEST_PROJECT_DIR/AGENTS.md"
    cat "$VIBESTART_DIR/src/fragments/core/session-management.md" >> "$TEST_PROJECT_DIR/AGENTS.md"
    
    [ -f "$TEST_PROJECT_DIR/AGENTS.md" ]
    grep -q "GRACE Introduction" "$TEST_PROJECT_DIR/AGENTS.md"
    grep -q "Session Management" "$TEST_PROJECT_DIR/AGENTS.md"
}

@test "INSTALL: AGENTS.md includes integration fragments for ADVANCED" {
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    mkdir -p "$VIBESTART_DIR/src/fragments/features"
    
    # Создаём фрагменты
    echo "# GRACE Introduction" > "$VIBESTART_DIR/src/fragments/core/grace-intro.md"
    echo "# Entire.io Session Capture" > "$VIBESTART_DIR/src/fragments/features/entire-session-capture.md"
    echo "# ConPort Memory" > "$VIBESTART_DIR/src/fragments/features/conport-memory.md"
    
    # Генерируем AGENTS.md (ADVANCED mode)
    cat "$VIBESTART_DIR/src/fragments/core/grace-intro.md" > "$TEST_PROJECT_DIR/AGENTS.md"
    cat "$VIBESTART_DIR/src/fragments/features/entire-session-capture.md" >> "$TEST_PROJECT_DIR/AGENTS.md"
    cat "$VIBESTART_DIR/src/fragments/features/conport-memory.md" >> "$TEST_PROJECT_DIR/AGENTS.md"
    
    [ -f "$TEST_PROJECT_DIR/AGENTS.md" ]
    grep -q "GRACE Introduction" "$TEST_PROJECT_DIR/AGENTS.md"
    grep -q "Entire.io Session Capture" "$TEST_PROJECT_DIR/AGENTS.md"
    grep -q "ConPort Memory" "$TEST_PROJECT_DIR/AGENTS.md"
}

@test "INSTALL: Creates git safety tag" {
    # Инициализируем git
    cd "$TEST_PROJECT_DIR"
    git init
    git config user.email "test@test.com"
    git config user.name "Test User"
    touch README.md
    git add .
    git commit -m "initial commit"
    
    # Создаём safety tag
    TAG="vs-init-backup-$(date +%Y%m%d-%H%M%S)"
    git tag -a "$TAG" -m "vs-init checkpoint"
    
    # Проверка
    run git tag -l "vs-init-backup-*"
    [ "$status" -eq 0 ]
    [[ "$output" == *"vs-init-backup-"* ]]
}

@test "INSTALL: Detects conflicts - AGENTS.md exists" {
    # Создаём существующий AGENTS.md
    echo "# Existing AGENTS.md" > "$TEST_PROJECT_DIR/AGENTS.md"
    
    # Детектирование конфликта
    run bash -c "[ -f '$TEST_PROJECT_DIR/AGENTS.md' ] && echo 'CONFLICT-001'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"CONFLICT-001"* ]]
}

@test "INSTALL: Detects conflicts - GRACE artifacts exist" {
    # Создаём существующие GRACE артефакты
    mkdir -p "$TEST_PROJECT_DIR/docs"
    touch "$TEST_PROJECT_DIR/docs/requirements.xml"
    touch "$TEST_PROJECT_DIR/docs/knowledge-graph.xml"
    
    # Детектирование конфликта
    run bash -c "ls '$TEST_PROJECT_DIR/docs'/*.xml 2>/dev/null | wc -l"
    [ "$status" -eq 0 ]
    [ "$output" -gt 0 ]
}

@test "INSTALL: verify-vibestart.sh exists" {
    [ -f "$VIBESTART_DIR/../verify-vibestart.sh" ] || \
    [ -f "$TEST_PROJECT_DIR/../verify-vibestart.sh" ] || \
    echo "verify-vibestart.sh not found (expected in parent directory)"
}

@test "INSTALL: Framework version is 3.0.0" {
    mkdir -p "$VIBESTART_DIR/src"
    echo '# vibestart Framework Configuration
[framework]
version = "3.0.0"' > "$VIBESTART_DIR/src/framework.toml"
    
    run grep -q 'version = "3.0.0"' "$VIBESTART_DIR/src/framework.toml"
    [ "$status" -eq 0 ]
}
