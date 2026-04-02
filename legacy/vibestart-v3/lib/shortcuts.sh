#!/bin/bash
# lib/shortcuts.sh — GRACE Shortcuts
# MODULE_ID: M-SHORTCUTS
# CONTRACT:
#   PURPOSE: Create GRACE shortcuts ($exec, $plan, $fix, etc.)
#   SCOPE: Environment-specific shortcut creation
#   DEPENDS: M-UI
#   EXPORTS:
#     create_shortcuts() — Create environment-specific shortcuts
#     ask_shortcuts()    — Ask user if they want shortcuts

set -e

# Source dependencies
SHORTCUTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ui.sh
source "$SHORTCUTS_DIR/ui.sh"

# ═══════════════════════════════════════════════════════════════════════════
# Constants
# ═══════════════════════════════════════════════════════════════════════════

# GRACE shortcuts mapping
declare -A GRACE_SHORTCUTS=(
    ["\$init"]="grace-init"
    ["\$plan"]="grace-plan"
    ["\$exec"]="grace-execute"
    ["\$verify"]="grace-verification"
    ["\$refresh"]="grace-refresh"
    ["\$status"]="grace-status"
    ["\$fix"]="grace-fix"
    ["\$ask"]="grace-ask"
    ["\$review"]="grace-reviewer"
    ["\$explain"]="grace-explainer"
)

# ═══════════════════════════════════════════════════════════════════════════
# User Interaction
# ═══════════════════════════════════════════════════════════════════════════

# ask_shortcuts: Ask user if they want shortcuts
# USAGE: choice=$(ask_shortcuts "default")
# DEFAULT: enabled or skip
# RETURNS: enabled or skip
ask_shortcuts() {
    local default="${1:-enabled}"
    
    ui_section "GRACE Shortcuts"
    
    echo "  Creates quick commands: \$exec, \$plan, \$fix, etc."
    echo ""
    echo "  [1] Enable   - Create shortcuts"
    echo "  [2] Skip     - No shortcuts"
    echo ""
    
    local default_num="1"
    [[ "$default" == "skip" ]] && default_num="2"
    
    local choice
    read -p "  Choice [1-2] (default: $default_num): " choice
    
    case "${choice:-$default_num}" in
        1) echo "enabled" ;;
        2) echo "skip" ;;
        *) echo "$default" ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════
# Shortcut Creation
# ═══════════════════════════════════════════════════════════════════════════

# create_shortcuts: Create environment-specific shortcuts
# USAGE: create_shortcuts "environment"
# ENVIRONMENT: kilo, claude, codex, qwen, copilot
# RETURNS: 0 = success, 1 = failure
create_shortcuts() {
    local env="$1"
    
    ui_info "Creating GRACE shortcuts for $env..."
    
    case "$env" in
        kilo)
            create_shortcuts_kilo
            ;;
        claude|cursor)
            create_shortcuts_claude
            ;;
        codex)
            create_shortcuts_codex
            ;;
        qwen)
            create_shortcuts_qwen
            ;;
        copilot)
            create_shortcuts_copilot
            ;;
        *)
            ui_error "Unknown environment: $env"
            return 1
            ;;
    esac
    
    ui_success "GRACE shortcuts created"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Environment-Specific Shortcuts
# ═══════════════════════════════════════════════════════════════════════════

# create_shortcuts_kilo: Create Kilo-specific shortcuts
create_shortcuts_kilo() {
    local skills_dir=".kilo/skills"
    mkdir -p "$skills_dir"
    
    # Create shortcut skill files
    for shortcut in "${!GRACE_SHORTCUTS[@]}"; do
        local skill_name="${GRACE_SHORTCUTS[$shortcut]}"
        local skill_file="$skills_dir/${skill_name}.md"
        
        cat > "$skill_file" << SHORTCUT_EOF
# Shortcut: $shortcut

Uses external GRACE marketplace skill: \`$skill_name\`

\`\`\`
Use the $skill_name skill from GRACE marketplace
SHORTCUT_EOF
        
        ui_info "  Created $shortcut → $skill_name"
    done
    
    # Create shortcuts.md reference
    cat > ".kilo/shortcuts.md" << 'REFERENCE_EOF'
# GRACE Shortcuts Reference

Quick commands for common GRACE operations:

- `$init` - Initialize new GRACE project
- `$plan` - Design module architecture
- `$exec` - Execute implementation plan
- `$verify` - Define verification strategy
- `$refresh` - Sync code with docs
- `$status` - Check project health
- `$fix` - Debug with GRACE navigation
- `$ask` - Ask about project
- `$review` - Review code with contracts
- `$explain` - GRACE methodology reference

All shortcuts use external GRACE marketplace skills.
REFERENCE_EOF
    
    ui_success "Created ${#GRACE_SHORTCUTS[@]} shortcuts in .kilo/skills/"
}

# create_shortcuts_claude: Create Claude-specific shortcuts
create_shortcuts_claude() {
    local skills_dir=".claude/skills"
    mkdir -p "$skills_dir"
    
    # Create shortcut YAML files
    for shortcut in "${!GRACE_SHORTCUTS[@]}"; do
        local skill_name="${GRACE_SHORTCUTS[$shortcut]}"
        local skill_file="$skills_dir/${skill_name}.yaml"
        
        cat > "$skill_file" << SHORTCUT_EOF
name: $skill_name
description: GRACE shortcut - $shortcut
command: Use external GRACE marketplace skill: $skill_name
SHORTCUT_EOF
        
        ui_info "  Created $shortcut → $skill_name"
    done
    
    ui_success "Created ${#GRACE_SHORTCUTS[@]} shortcuts in .claude/skills/"
}

# create_shortcuts_qwen: Create Qwen-specific shortcuts
create_shortcuts_qwen() {
    local skills_dir=".qwen/skills"
    mkdir -p "$skills_dir"
    
    # Create shortcut JSON files
    for shortcut in "${!GRACE_SHORTCUTS[@]}"; do
        local skill_name="${GRACE_SHORTCUTS[$shortcut]}"
        local skill_file="$skills_dir/${skill_name}.json"
        
        cat > "$skill_file" << SHORTCUT_EOF
{
  "name": "$skill_name",
  "shortcut": "$shortcut",
  "description": "GRACE marketplace skill",
  "command": "Use external GRACE marketplace skill: $skill_name"
}
SHORTCUT_EOF
        
        ui_info "  Created $shortcut → $skill_name"
    done
    
    ui_success "Created ${#GRACE_SHORTCUTS[@]} shortcuts in .qwen/skills/"
}

# create_shortcuts_codex: Create Codex-specific shortcuts
create_shortcuts_codex() {
    local skills_dir=".codex/skills"
    mkdir -p "$skills_dir"

    for shortcut in "${!GRACE_SHORTCUTS[@]}"; do
        local skill_name="${GRACE_SHORTCUTS[$shortcut]}"
        local skill_file="$skills_dir/${skill_name}.md"

        cat > "$skill_file" << SHORTCUT_EOF
# $skill_name

**Shortcut:** \`$shortcut\`

Use the external GRACE marketplace skill: \`$skill_name\`

## Note

Codex marketplace skills are installed at \`~/.codex/skills/grace/\`.
SHORTCUT_EOF

        ui_info "  Created $shortcut → $skill_name"
    done

    ui_success "Created ${#GRACE_SHORTCUTS[@]} shortcuts in .codex/skills/"
}

# create_shortcuts_copilot: Create Copilot-specific shortcuts
create_shortcuts_copilot() {
    local skills_dir=".github/copilot/skills"
    mkdir -p "$skills_dir"
    
    # Create shortcut markdown files
    for shortcut in "${!GRACE_SHORTCUTS[@]}"; do
        local skill_name="${GRACE_SHORTCUTS[$shortcut]}"
        local skill_file="$skills_dir/${skill_name}.md"
        
        cat > "$skill_file" << SHORTCUT_EOF
# $skill_name

**Shortcut:** \`$shortcut\`

Use the external GRACE marketplace skill: \`$skill_name\`

## Usage

Trigger this shortcut by typing: \`$shortcut\`
SHORTCUT_EOF
        
        ui_info "  Created $shortcut → $skill_name"
    done
    
    ui_success "Created ${#GRACE_SHORTCUTS[@]} shortcuts in .github/copilot/skills/"
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f create_shortcuts ask_shortcuts create_shortcuts_kilo create_shortcuts_claude create_shortcuts_qwen create_shortcuts_codex create_shortcuts_copilot &>/dev/null || {
    echo "[SHORTCUTS] Error: Export validation failed" >&2
    exit 1
}
