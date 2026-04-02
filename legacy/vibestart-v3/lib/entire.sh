#!/bin/bash
# lib/entire.sh — Entire.io Integration
# MODULE_ID: M-ENTIRE
# CONTRACT:
#   PURPOSE: Install Entire.io for library documentation
#   SCOPE: CLI installation, git hooks setup
#   DEPENDS: M-UI, M-DETECT
#   EXPORTS:
#     install_entire() — Install Entire.io CLI and git hooks
#     ask_entire()     — Ask user if they want Entire.io

set -e

# Source dependencies
ENTIRE_MODULE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ui.sh
source "$ENTIRE_MODULE_DIR/ui.sh"
# shellcheck source=detect.sh
source "$ENTIRE_MODULE_DIR/detect.sh"

# ═══════════════════════════════════════════════════════════════════════════
# User Interaction
# ═══════════════════════════════════════════════════════════════════════════

# ask_entire: Ask user if they want Entire.io
# USAGE: choice=$(ask_entire "os" "default")
# DEFAULT: enabled or skip
# RETURNS: enabled or skip
ask_entire() {
    local os="$1"
    local default="${2:-enabled}"
    
    ui_section "Entire.io (Library Documentation)"
    
    if [[ "$os" == "windows" ]]; then
        ui_warning "Entire.io is not supported on Windows"
        echo "skip"
        return 0
    fi
    
    echo "  Provides API documentation and library context."
    echo ""
    echo "  [1] Enable   - Install Entire.io MCP server"
    echo "  [2] Skip     - No library docs integration"
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
# Entire.io Installation
# ═══════════════════════════════════════════════════════════════════════════

# install_entire: Install Entire.io CLI and git hooks
# USAGE: install_entire
# RETURNS: 0 = success, 1 = failure
install_entire() {
    ui_info "Installing Entire.io..."
    
    # Check OS support
    local os
    os=$(detect_os)
    
    if [[ "$os" == "windows" ]]; then
        ui_error "Entire.io is not supported on Windows (use WSL)"
        return 1
    fi
    
    # Check if git repository
    if [[ ! -d ".git" ]]; then
        ui_warning "Not a git repository - Entire.io requires git"
        return 1
    fi
    
    # Check npm availability
    if ! command -v npm &>/dev/null; then
        ui_error "npm required for Entire.io installation"
        return 1
    fi
    
    # Install Entire.io CLI
    ui_info "Installing @entire/cli via npm..."
    
    if ! npm install -g @entire/cli 2>/dev/null; then
        ui_warning "Global installation failed, trying local..."
        
        if ! npm install --save-dev @entire/cli 2>/dev/null; then
            ui_error "Failed to install Entire.io CLI"
            return 1
        fi
    fi
    
    # Verify installation
    if ! command -v entire &>/dev/null; then
        ui_warning "Entire.io CLI not in PATH - may need manual configuration"
    fi
    
    # Initialize Entire.io in repository
    ui_info "Initializing Entire.io..."
    
    if command -v entire &>/dev/null; then
        entire init 2>/dev/null || true
    fi
    
    # Install git hooks
    install_entire_hooks
    
    ui_success "Entire.io installed and configured"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Git Hooks
# ═══════════════════════════════════════════════════════════════════════════

# install_entire_hooks: Install git hooks for Entire.io
# USAGE: install_entire_hooks
# RETURNS: 0 = success, 1 = failure
install_entire_hooks() {
    ui_info "Installing Entire.io git hooks..."
    
    # Create .git/hooks directory if needed
    mkdir -p .git/hooks
    
    # Create post-commit hook
    cat > .git/hooks/post-commit << 'ENTIRE_HOOK_EOF'
#!/bin/bash
# Entire.io post-commit hook
# Automatically creates checkpoint after each commit

# Check if entire CLI is available
if command -v entire &>/dev/null; then
    # Get commit message
    commit_msg=$(git log -1 --pretty=%B)
    
    # Create checkpoint with commit reference
    entire checkpoint "Auto-checkpoint: $commit_msg" 2>/dev/null || true
fi

# Exit cleanly
exit 0
ENTIRE_HOOK_EOF
    
    chmod +x .git/hooks/post-commit
    
    # Create pre-push hook (optional)
    cat > .git/hooks/pre-push << 'ENTIRE_PUSH_HOOK_EOF'
#!/bin/bash
# Entire.io pre-push hook
# Syncs checkpoints before push

# Check if entire CLI is available
if command -v entire &>/dev/null; then
    entire sync 2>/dev/null || true
fi

# Exit cleanly
exit 0
ENTIRE_PUSH_HOOK_EOF
    
    chmod +x .git/hooks/pre-push
    
    ui_success "Git hooks installed"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════════════════

# check_entire_health: Check if Entire.io is working
# USAGE: check_entire_health
# RETURNS: 0 = healthy, 1 = issues
check_entire_health() {
    if ! command -v entire &>/dev/null; then
        ui_warning "Entire.io CLI not found in PATH"
        return 1
    fi
    
    if ! entire --version &>/dev/null; then
        ui_warning "Entire.io CLI not responding"
        return 1
    fi
    
    ui_success "Entire.io is healthy"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f install_entire ask_entire install_entire_hooks check_entire_health &>/dev/null || {
    echo "[ENTIRE] Error: Export validation failed" >&2
    exit 1
}
