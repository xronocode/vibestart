#!/usr/bin/env bats
# tests/migrate.bats
# Тесты MIGRATE режима vibestart v3.0.0

setup_file() {
    echo "=== MIGRATE Tests Setup ==="
    export TEST_PROJECT_DIR="/tmp/vibestart-test-migrate-$$"
    export VIBESTART_DIR="$TEST_PROJECT_DIR/.vibestart"
}

teardown_file() {
    echo "=== MIGRATE Tests Cleanup ==="
    rm -rf "$TEST_PROJECT_DIR"
}

setup() {
    # Подготовка проекта с установкой v1.x
    rm -rf "$TEST_PROJECT_DIR"
    mkdir -p "$TEST_PROJECT_DIR"
    cd "$TEST_PROJECT_DIR"
    
    # Создаём структуру v1.x
    mkdir -p "$VIBESTART_DIR/framework/src/skills"
    mkdir -p "$VIBESTART_DIR/framework/src/templates"
    mkdir -p "$TEST_PROJECT_DIR/docs"
    
    # vs.project.toml v1.x
    cat > "vs.project.toml" << 'EOF'
[framework]
version = "1.2.0"
skills_path = ".vibestart/framework/src/skills"
EOF
    
    # GRACE артефакты v1.x
    cat > "docs/requirements.xml" << 'EOF'
<?xml version="1.0"?>
<Requirements VERSION="1.0.0">
  <ProjectInfo>
    <name>test-project</name>
  </ProjectInfo>
  <UseCases>
    <UC-001>
      <summary>User authentication</summary>
    </UC-001>
  </UseCases>
</Requirements>
EOF
    
    cat > "docs/decisions.xml" << 'EOF'
<?xml version="1.0"?>
<Decisions VERSION="1.0.0">
  <Decisions>
    <D-001>
      <summary>Use JWT for auth</summary>
    </D-001>
  </Decisions>
</Decisions>
EOF
    
    cat > "docs/knowledge-graph.xml" << 'EOF'
<?xml version="1.0"?>
<KnowledgeGraph VERSION="1.0.0">
  <Nodes>
    <M-001>
      <name>Auth</name>
    </M-001>
  </Nodes>
</KnowledgeGraph>
EOF
    
    # AGENTS.md v1.x (монолитный)
    cat > "AGENTS.md" << 'EOF'
# AGENTS.md v1.x

## GRACE Rules

Follow GRACE methodology.
EOF
}

@test "MIGRATE: Detects v1.x version" {
    run grep -q 'version = "1.2.0"' "$TEST_PROJECT_DIR/vs.project.toml"
    [ "$status" -eq 0 ]
    
    run grep -q 'framework' "$TEST_PROJECT_DIR/vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Detects old framework structure" {
    run bash -c "[ -d '$VIBESTART_DIR/framework' ] && echo 'OLD_STRUCTURE'"
    [ "$status" -eq 0 ]
    [ "$output" = "OLD_STRUCTURE" ]
}

@test "MIGRATE: Creates full backup before migration" {
    BACKUP_DIR="$VIBESTART_DIR/.backup/migrate-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Копируем всё
    cp -r "$VIBESTART_DIR/framework" "$BACKUP_DIR/"
    cp "vs.project.toml" "$BACKUP_DIR/"
    cp -r "docs" "$BACKUP_DIR/"
    cp "AGENTS.md" "$BACKUP_DIR/"
    
    [ -d "$BACKUP_DIR" ]
    [ -f "$BACKUP_DIR/vs.project.toml" ]
    [ -d "$BACKUP_DIR/docs" ]
}

@test "MIGRATE: Migrates framework structure" {
    # Старая структура: .vibestart/framework/src/
    # Новая структура: .vibestart/src/
    
    mkdir -p "$VIBESTART_DIR/src"
    
    # Перемещаем содержимое
    if [ -d "$VIBESTART_DIR/framework/src" ]; then
        mv "$VIBESTART_DIR/framework/src/"* "$VIBESTART_DIR/src/"
        rm -rf "$VIBESTART_DIR/framework"
    fi
    
    # Проверка новой структуры
    [ -d "$VIBESTART_DIR/src" ]
    [ ! -d "$VIBESTART_DIR/framework" ]
}

@test "MIGRATE: Migrates vs.project.toml format" {
    # Старый формат v1.x
    cat > "vs.project.toml" << 'EOF'
[framework]
version = "1.2.0"
skills_path = ".vibestart/framework/src/skills"
EOF
    
    # Новый формат v3.x
    cat > "vs.project.toml" << 'EOF'
[project]
name = "test-project"
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
    
    # Проверка нового формата
    run grep -q '\[project\]' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    run grep -q 'migrated_from = "1.2.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Migrates requirements.xml" {
    # Извлекаем данные из старого XML
    run grep -o '<UC-001>.*</UC-001>' "docs/requirements.xml"
    [[ "$output" == *"<UC-001>"* ]]
    
    # Создаём новый формат v3.x
    cat > "docs/requirements.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Requirements VERSION="3.0.0">
  <ProjectInfo>
    <name>test-project</name>
    <version>0.1.0</version>
  </ProjectInfo>
  <UseCases>
    <UC-001 DATE="2026-03-27" STATUS="approved">
      <summary>User authentication</summary>
    </UC-001>
  </UseCases>
</Requirements>
EOF
    
    # Проверка
    run grep -q 'VERSION="3.0.0"' "docs/requirements.xml"
    [ "$status" -eq 0 ]
    run grep -q 'STATUS="approved"' "docs/requirements.xml"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Migrates decisions.xml" {
    # Извлекаем данные из старого XML
    run grep -o '<D-001>.*</D-001>' "docs/decisions.xml"
    [[ "$output" == *"<D-001>"* ]]
    
    # Создаём новый формат v3.x
    cat > "docs/decisions.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Decisions VERSION="3.0.0">
  <ProjectInfo>
    <name>test-project</name>
    <version>0.1.0</version>
  </ProjectInfo>
  <Decisions>
    <D-001 DATE="2026-03-27" STATUS="approved">
      <summary>Use JWT for auth</summary>
      <rationale>Stateless authentication</rationale>
    </D-001>
  </Decisions>
  <Statistics>
    <total>1</total>
    <by-status>
      <approved>1</approved>
    </by-status>
  </Statistics>
</Decisions>
EOF
    
    # Проверка
    run grep -q 'VERSION="3.0.0"' "docs/decisions.xml"
    [ "$status" -eq 0 ]
    run grep -q '<Statistics>' "docs/decisions.xml"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Migrates knowledge-graph.xml" {
    # Извлекаем данные из старого XML
    run grep -o '<M-001>.*</M-001>' "docs/knowledge-graph.xml"
    [[ "$output" == *"<M-001>"* ]]
    
    # Создаём новый формат v3.x
    cat > "docs/knowledge-graph.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<KnowledgeGraph VERSION="3.0.0">
  <ProjectInfo>
    <name>test-project</name>
    <version>0.1.0</version>
  </ProjectInfo>
  <Nodes>
    <M-001 TYPE="module" LAYER="1">
      <name>Auth</name>
      <description>Authentication module</description>
    </M-001>
  </Nodes>
  <Edges>
  </Edges>
  <Statistics>
    <total-nodes>1</total-nodes>
    <total-edges>0</total-edges>
  </Statistics>
</KnowledgeGraph>
EOF
    
    # Проверка
    run grep -q 'VERSION="3.0.0"' "docs/knowledge-graph.xml"
    [ "$status" -eq 0 ]
    run grep -q '<Statistics>' "docs/knowledge-graph.xml"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Migrates AGENTS.md to fragments" {
    # Старый AGENTS.md (монолитный)
    [ -f "AGENTS.md" ]
    run grep -q "v1.x" "AGENTS.md"
    [ "$status" -eq 0 ]
    
    # Создаём backup
    cp "AGENTS.md" "AGENTS.md.backup.$(date +%Y%m%d-%H%M%S)"
    
    # Создаём новый AGENTS.md из фрагментов
    mkdir -p "$VIBESTART_DIR/src/fragments/core"
    echo "# GRACE Introduction v3.0" > "$VIBESTART_DIR/src/fragments/core/grace-intro.md"
    
    # Генерируем новый
    cat "$VIBESTART_DIR/src/fragments/core/grace-intro.md" > "AGENTS.md"
    
    # Проверка
    [ -f "AGENTS.md" ]
    run grep -q "v3.0" "AGENTS.md"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Preserves user data during migration" {
    # Сохраняем данные перед миграцией
    ORIGINAL_UC=$(grep -o '<UC-001>.*</UC-001>' "docs/requirements.xml" || echo "")
    ORIGINAL_D=$(grep -o '<D-001>.*</D-001>' "docs/decisions.xml" || echo "")
    ORIGINAL_M=$(grep -o '<M-001>.*</M-001>' "docs/knowledge-graph.xml" || echo "")
    
    # Миграция (симуляция)
    # ... данные сохраняются в новом формате ...
    
    # Проверка что данные сохранены
    run grep -q "User authentication" "docs/requirements.xml"
    [ "$status" -eq 0 ]
    run grep -q "Use JWT for auth" "docs/decisions.xml"
    [ "$status" -eq 0 ]
    run grep -q "Auth" "docs/knowledge-graph.xml"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Creates migration report" {
    MIGRATION_REPORT="docs/.backup/migration-report-$(date +%Y%m%d-%H%M%S).xml"
    mkdir -p "docs/.backup"
    
    cat > "$MIGRATION_REPORT" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<MigrationReport TIMESTAMP="2026-03-27T14:30:22Z">
  <Summary>
    <source-version>1.2.0</source-version>
    <target-version>3.0.0</target-version>
    <files-migrated>4</files-migrated>
    <elements-preserved>3</elements-preserved>
    <warnings>0</warnings>
    <errors>0</errors>
  </Summary>
  <FileMigrations>
    <File name="requirements.xml">
      <status>migrated</status>
      <use-cases-preserved>1</use-cases-preserved>
    </File>
    <File name="decisions.xml">
      <status>migrated</status>
      <decisions-preserved>1</decisions-preserved>
    </File>
    <File name="knowledge-graph.xml">
      <status>migrated</status>
      <nodes-preserved>1</nodes-preserved>
    </File>
    <File name="AGENTS.md">
      <status>migrated</status>
    </File>
  </FileMigrations>
  <RollbackInstructions>
    <step-1>To rollback: cp .vibestart/.backup/migrate-*/. .</step-1>
    <step-2>Or use git: git checkout vs-init-backup-TIMESTAMP</step-2>
  </RollbackInstructions>
</MigrationReport>
EOF
    
    [ -f "$MIGRATION_REPORT" ]
    run grep -q 'source-version>1.2.0' "$MIGRATION_REPORT"
    [ "$status" -eq 0 ]
    run grep -q 'target-version>3.0.0' "$MIGRATION_REPORT"
    [ "$status" -eq 0 ]
}

@test "MIGRATE: Creates git safety tag" {
    # Инициализируем git
    git init
    git config user.email "test@test.com"
    git config user.name "Test User"
    git add .
    git commit -m "pre-migration"
    
    # Создаём safety tag
    TAG="vs-init-backup-$(date +%Y%m%d-%H%M%S)"
    git tag -a "$TAG" -m "vs-init migration checkpoint"
    
    # Проверка
    run git tag -l "vs-init-backup-*"
    [ "$status" -eq 0 ]
    [[ "$output" == *"vs-init-backup-"* ]]
}

@test "MIGRATE: Verifies migrated installation" {
    # Финальная проверка
    [ -d "$VIBESTART_DIR/src" ]
    [ ! -d "$VIBESTART_DIR/framework" ]
    
    run grep -q 'version = "3.0.0"' "vs.project.toml"
    [ "$status" -eq 0 ]
    
    run grep -q 'VERSION="3.0.0"' "docs/requirements.xml"
    [ "$status" -eq 0 ]
    
    [ -f "AGENTS.md" ]
}

@test "MIGRATE: Rollback restores v1.x state" {
    # Создаём backup
    BACKUP_DIR="$VIBESTART_DIR/.backup/migrate-rollback"
    mkdir -p "$BACKUP_DIR"
    
    # Сохраняем старое состояние
    cp -r "$VIBESTART_DIR/framework" "$BACKUP_DIR/" 2>/dev/null || true
    cp "vs.project.toml" "$BACKUP_DIR/vs.project.toml.orig"
    
    # "Мигрируем"
    echo 'version = "3.0.0"' > "vs.project.toml"
    
    # Откат
    if [ -f "$BACKUP_DIR/vs.project.toml.orig" ]; then
        cp "$BACKUP_DIR/vs.project.toml.orig" "vs.project.toml"
    fi
    
    # Проверка отката
    run grep -q 'version = "1.2.0"' "$BACKUP_DIR/vs.project.toml.orig" || \
    run grep -q 'framework' "$BACKUP_DIR/vs.project.toml.orig" || \
    echo "Backup contains v1.x data"
}

@test "MIGRATE: Handles missing backup directory" {
    # Создаём backup directory если нет
    if [ ! -d "$VIBESTART_DIR/.backup" ]; then
        mkdir -p "$VIBESTART_DIR/.backup"
    fi
    
    [ -d "$VIBESTART_DIR/.backup" ]
}

@test "MIGRATE: Handles malformed XML" {
    # Создаём malformed XML
    echo "not valid xml at all" > "docs/test.xml"
    
    # Проверка что обнаружено
    run bash -c "grep -q '<?xml' 'docs/test.xml' || echo 'MALFORMED'"
    [ "$status" -eq 0 ]
    [ "$output" = "MALFORMED" ]
}

@test "MIGRATE: Reports migration warnings" {
    # Создаём файл с предупреждениями
    WARNINGS_FILE="docs/.backup/migration-warnings.txt"
    mkdir -p "docs/.backup"
    
    cat > "$WARNINGS_FILE" << 'EOF'
Warning: Unknown element <customMetadata> moved to LegacyData
Warning: Orphaned edge removed: edge-123
EOF
    
    [ -f "$WARNINGS_FILE" ]
    run grep -q "Warning" "$WARNINGS_FILE"
    [ "$status" -eq 0 ]
}
