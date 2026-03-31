#!/bin/bash
# lib/marketplace.sh — GRACE Marketplace Downloader
# MODULE_ID: M-MARKETPLACE
# CONTRACT:
#   PURPOSE: Download and manage GRACE marketplace skills
#   SCOPE: Marketplace download, version management, clean cloning
#   DEPENDS: M-UI
#   EXPORTS:
#     ensure_marketplace()    — Download marketplace if not present
#     update_marketplace()    — Update to latest version
#     clone_clean()           — Clone using git archive (no .git)

set -e

# Source dependencies
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ui.sh
source "$SCRIPT_DIR/ui.sh"

# ═══════════════════════════════════════════════════════════════════════════
# Constants
# ═══════════════════════════════════════════════════════════════════════════

readonly MARKETPLACE_REPO="https://github.com/osovv/grace-marketplace.git"
readonly MARKETPLACE_BRANCH="${GRACE_MARKETPLACE_VERSION:-main}"
readonly MARKETPLACE_DIR="$HOME/.kilocode/skills/grace"

# ═══════════════════════════════════════════════════════════════════════════
# Clean Clone (git archive)
# ═══════════════════════════════════════════════════════════════════════════

# clone_clean: Clone repository without .git directory
# USAGE: clone_clean "repo_url" "target_dir" ["branch"]
# RETURNS: 0 = success, 1 = failure
clone_clean() {
    local repo_url="$1"
    local target_dir="$2"
    local branch="${3:-main}"
    
    ui_info "Cloning repository (clean, no .git)..."
    
    # Create temporary file for archive
    local tmp_archive
    tmp_archive=$(mktemp /tmp/grace-marketplace.XXXXXX.tar)
    
    # Download archive
    if ! git archive --remote="$repo_url" --output="$tmp_archive" "$branch" 2>/dev/null; then
        ui_error "Failed to download archive from $repo_url"
        rm -f "$tmp_archive"
        return 1
    fi
    
    # Create target directory
    mkdir -p "$target_dir"
    
    # Extract archive
    if ! tar -xf "$tmp_archive" -C "$target_dir" 2>/dev/null; then
        ui_error "Failed to extract archive"
        rm -f "$tmp_archive"
        return 1
    fi
    
    # Cleanup
    rm -f "$tmp_archive"
    
    ui_success "Repository cloned to $target_dir"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Marketplace Management
# ═══════════════════════════════════════════════════════════════════════════

# ensure_marketplace: Download marketplace if not present
# USAGE: ensure_marketplace
# RETURNS: 0 = success, 1 = failure
ensure_marketplace() {
    ui_section "GRACE Marketplace"
    
    # Check if already installed
    if [[ -d "$MARKETPLACE_DIR" ]]; then
        ui_info "Marketplace already installed at $MARKETPLACE_DIR"
        
        # Check version
        local current_branch
        current_branch=$(cd "$MARKETPLACE_DIR" && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
        
        if [[ "$current_branch" == "$MARKETPLACE_BRANCH" ]]; then
            ui_success "Using marketplace version: $MARKETPLACE_BRANCH"
            return 0
        else
            ui_info "Current: $current_branch, Requested: $MARKETPLACE_BRANCH"
            ui_info "Run with --update-marketplace to update"
        fi
        
        return 0
    fi
    
    # Download marketplace
    ui_info "Downloading GRACE marketplace (branch: $MARKETPLACE_BRANCH)..."
    
    # Method 1: Try git clone (faster for full clone)
    if git clone --branch "$MARKETPLACE_BRANCH" --depth 1 "$MARKETPLACE_REPO" "$MARKETPLACE_DIR" 2>/dev/null; then
        ui_success "Marketplace downloaded via git clone"
        
        # Remove .git directory to save space
        rm -rf "$MARKETPLACE_DIR/.git"
        ui_info "Removed .git directory to save space"
        
        return 0
    fi
    
    # Method 2: Fallback to git archive (if clone fails)
    ui_warning "Git clone failed, trying git archive..."
    
    mkdir -p "$MARKETPLACE_DIR"
    
    if clone_clean "$MARKETPLACE_REPO" "$MARKETPLACE_DIR" "$MARKETPLACE_BRANCH"; then
        ui_success "Marketplace downloaded via git archive"
        return 0
    fi
    
    # Method 3: Download ZIP as last resort
    ui_warning "Git archive failed, trying ZIP download..."
    
    local zip_url="https://github.com/osovv/grace-marketplace/archive/refs/heads/${MARKETPLACE_BRANCH}.zip"
    local tmp_zip
    
    tmp_zip=$(mktemp /tmp/grace-marketplace.XXXXXX.zip)
    
    if command -v curl &>/dev/null; then
        curl -L "$zip_url" -o "$tmp_zip" 2>/dev/null
    elif command -v wget &>/dev/null; then
        wget "$zip_url" -O "$tmp_zip" 2>/dev/null
    else
        ui_error "Neither curl nor wget available"
        rm -f "$tmp_zip"
        return 1
    fi
    
    # Extract ZIP
    if command -v unzip &>/dev/null; then
        mkdir -p "$MARKETPLACE_DIR"
        unzip -q "$tmp_zip" -d /tmp/grace-extract 2>/dev/null
        
        # Move extracted files (ZIP contains subdirectory)
        mv /tmp/grace-extract/grace-marketplace-*/* "$MARKETPLACE_DIR/" 2>/dev/null
        rm -rf /tmp/grace-extract
        rm -f "$tmp_zip"
        
        ui_success "Marketplace downloaded via ZIP"
        return 0
    else
        ui_error "unzip not available"
        rm -f "$tmp_zip"
        return 1
    fi
}

# update_marketplace: Update to latest version
# USAGE: update_marketplace
# RETURNS: 0 = success, 1 = failure
update_marketplace() {
    ui_section "Updating GRACE Marketplace"
    
    # Remove existing installation
    if [[ -d "$MARKETPLACE_DIR" ]]; then
        ui_info "Removing existing marketplace..."
        rm -rf "$MARKETPLACE_DIR"
    fi
    
    # Re-download
    if ensure_marketplace; then
        ui_success "Marketplace updated to $MARKETPLACE_BRANCH"
        return 0
    else
        ui_error "Failed to update marketplace"
        return 1
    fi
}

# get_marketplace_version: Get current marketplace version
# USAGE: version=$(get_marketplace_version)
# RETURNS: Version string or "unknown"
get_marketplace_version() {
    if [[ ! -d "$MARKETPLACE_DIR" ]]; then
        echo "not-installed"
        return 1
    fi
    
    # Try to get version from file
    if [[ -f "$MARKETPLACE_DIR/VERSION" ]]; then
        cat "$MARKETPLACE_DIR/VERSION"
        return 0
    fi
    
    # Try to get from git
    if [[ -d "$MARKETPLACE_DIR/.git" ]]; then
        (cd "$MARKETPLACE_DIR" && git describe --tags 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        return 0
    fi
    
    echo "unknown"
    return 0
}

# list_marketplace_skills: List available skills in marketplace
# USAGE: list_marketplace_skills
# RETURNS: 0 = success
list_marketplace_skills() {
    if [[ ! -d "$MARKETPLACE_DIR" ]]; then
        ui_error "Marketplace not installed"
        return 1
    fi
    
    ui_info "Available GRACE skills:"
    
    for skill_dir in "$MARKETPLACE_DIR"/skills/grace/*/; do
        if [[ -f "$skill_dir/SKILL.md" ]]; then
            local skill_name
            skill_name=$(basename "$skill_dir")
            echo "  - $skill_name"
        fi
    done
    
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f ensure_marketplace update_marketplace clone_clean get_marketplace_version list_marketplace_skills &>/dev/null || {
    echo "[MARKETPLACE] Error: Export validation failed" >&2
    exit 1
}
