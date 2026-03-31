#!/bin/bash
# lib/preflight.sh — Pre-flight Validation
# MODULE_ID: M-PREFLIGHT
# CONTRACT:
#   PURPOSE: Validate system requirements before installation
#   SCOPE: Disk space, filesystem, dependencies, agent compatibility
#   DEPENDS: M-UI, M-DETECT
#   EXPORTS:
#     run_preflight()              — Run all pre-flight checks
#     check_disk_space()           — Check available disk space
#     check_filesystem()           — Detect tmpfs/ramdisk limitations
#     check_dependencies()         — Verify required tools
#     check_agent_compatibility()  — Verify agent shell type

set -e

# Source dependencies
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ui.sh
source "$SCRIPT_DIR/ui.sh"
# shellcheck source=detect.sh
source "$SCRIPT_DIR/detect.sh"

# ═══════════════════════════════════════════════════════════════════════════
# Constants
# ═══════════════════════════════════════════════════════════════════════════

readonly MIN_DISK_SPACE_FULL=$((1536 * 1024 * 1024))  # 1.5GB for ConPort Full
readonly MIN_DISK_SPACE_LITE=$((10 * 1024 * 1024))    # 10MB for ConPort Lite
readonly SMALL_FILESYSTEM_THRESHOLD=$((4 * 1024 * 1024 * 1024))  # 4GB

# ═══════════════════════════════════════════════════════════════════════════
# Disk Space Check
# ═══════════════════════════════════════════════════════════════════════════

# check_disk_space: Check available disk space
# USAGE: check_disk_space [mode]
# MODE: full (default), lite
# RETURNS: 0 = OK, 1 = insufficient
# EXPORTS: RECOMMENDED_MODE (full/lite/skip)
check_disk_space() {
    local mode="${1:-full}"
    
    ui_info "Checking disk space..."
    
    local available_kb
    local available_bytes
    
    # Get available space in KB
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS: df output is in 512-byte blocks
        available_kb=$(($(df -k . | awk 'NR==2 {print $4}') * 1024))
        available_bytes=$((available_kb * 1024))
    else
        # Linux: df output is in 1K blocks
        available_kb=$(df -k . | awk 'NR==2 {print $4}')
        available_bytes=$((available_kb * 1024))
    fi
    
    local available_mb=$((available_bytes / 1024 / 1024))
    
    # Check against requirements
    if [[ "$mode" == "full" ]]; then
        if [[ $available_bytes -lt $MIN_DISK_SPACE_FULL ]]; then
            ui_warning "Insufficient disk space for ConPort Full (${available_mb}MB < 1536MB)"
            ui_info "Recommending ConPort Lite mode (requires only 10MB)"
            RECOMMENDED_MODE="lite"
            return 1
        else
            ui_success "Disk space OK for ConPort Full (${available_mb}MB available)"
            RECOMMENDED_MODE="full"
            return 0
        fi
    else
        if [[ $available_bytes -lt $MIN_DISK_SPACE_LITE ]]; then
            ui_error "Insufficient disk space even for ConPort Lite (${available_mb}MB < 10MB)"
            RECOMMENDED_MODE="skip"
            return 1
        else
            ui_success "Disk space OK for ConPort Lite (${available_mb}MB available)"
            RECOMMENDED_MODE="lite"
            return 0
        fi
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Filesystem Check
# ═══════════════════════════════════════════════════════════════════════════

# check_filesystem: Detect tmpfs/ramdisk limitations
# USAGE: check_filesystem
# RETURNS: 0 = OK, 1 = warning
check_filesystem() {
    ui_info "Checking filesystem..."
    
    local fs_type
    local mount_point
    
    # Get filesystem info
    if [[ "$OSTYPE" == "darwin"* ]]; then
        fs_type=$(df -T . 2>/dev/null | awk 'NR==2 {print $2}' || echo "unknown")
    else
        fs_type=$(df -T . | awk 'NR==2 {print $2}')
    fi
    
    # Get total size
    local total_kb
    if [[ "$OSTYPE" == "darwin"* ]]; then
        total_kb=$(df -k . | awk 'NR==2 {print $2}')
    else
        total_kb=$(df -k . | awk 'NR==2 {print $2}')
    fi
    
    local total_gb=$((total_kb / 1024 / 1024))
    
    # Check for tmpfs/ramdisk
    if [[ "$fs_type" == "tmpfs" ]] || [[ "$fs_type" == "ramfs" ]]; then
        ui_warning "Running on ${fs_type} - limited persistence"
        
        if [[ $total_gb -lt 4 ]]; then
            ui_warning "Small ${fs_type} detected (${total_gb}GB) - ConPort Lite recommended"
            return 1
        fi
    fi
    
    # Check total size
    if [[ $total_gb -lt 4 ]]; then
        ui_warning "Small filesystem detected (${total_gb}GB total)"
        ui_info "ConPort Lite recommended for limited storage"
        return 1
    fi
    
    ui_success "Filesystem OK (${fs_type}, ${total_gb}GB)"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Dependencies Check
# ═══════════════════════════════════════════════════════════════════════════

# check_dependencies: Verify required tools
# USAGE: check_dependencies
# RETURNS: 0 = OK, 1 = missing dependencies
check_dependencies() {
    ui_info "Checking dependencies..."
    
    local missing=()
    
    # Check bash version (4.0+ required)
    local bash_major="${BASH_VERSINFO[0]}"
    if [[ $bash_major -lt 4 ]]; then
        ui_error "Bash version too old (${BASH_VERSION}), 4.0+ required"
        missing+=("bash>=4.0")
    else
        ui_success "Bash ${BASH_VERSION}"
    fi
    
    # Check git
    if ! command -v git &>/dev/null; then
        ui_error "git not found"
        missing+=("git")
    else
        ui_success "git $(git --version | awk '{print $3}')"
    fi
    
    # Check curl or wget
    if command -v curl &>/dev/null; then
        ui_success "curl $(curl --version | head -1 | awk '{print $2}')"
    elif command -v wget &>/dev/null; then
        ui_success "wget $(wget --version | head -1 | awk '{print $3}')"
    else
        ui_error "Neither curl nor wget found"
        missing+=("curl or wget")
    fi
    
    # Check tar (for git archive extraction)
    if ! command -v tar &>/dev/null; then
        ui_error "tar not found"
        missing+=("tar")
    else
        ui_success "tar available"
    fi
    
    # Check python3 (optional, for ConPort)
    if command -v python3 &>/dev/null; then
        local python_version
        python_version=$(python3 --version 2>&1 | awk '{print $2}')
        ui_success "python3 ${python_version} (optional)"
    else
        ui_info "python3 not found (ConPort will be unavailable)"
    fi
    
    # Report result
    if [[ ${#missing[@]} -gt 0 ]]; then
        ui_error "Missing dependencies: ${missing[*]}"
        return 1
    fi
    
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Agent Compatibility Check
# ═══════════════════════════════════════════════════════════════════════════

# check_agent_compatibility: Verify agent shell type
# USAGE: check_agent_compatibility "environment"
# RETURNS: 0 = OK, 1 = incompatible
check_agent_compatibility() {
    local env="$1"
    
    ui_info "Checking agent compatibility..."
    
    # Check if we're in an interactive shell
    if [[ ! -t 0 ]] && [[ "$AUTO_MODE" != "true" ]]; then
        ui_warning "Not running in interactive terminal"
        ui_info "Use --auto flag for non-interactive installation"
    fi
    
    # Environment-specific checks
    case "$env" in
        kilo|claude|qwen|copilot)
            ui_success "Environment '$env' is supported"
            return 0
            ;;
        *)
            ui_error "Unknown environment: $env"
            return 1
            ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════
# Main Pre-flight Runner
# ═══════════════════════════════════════════════════════════════════════════

# run_preflight: Run all pre-flight checks
# USAGE: run_preflight
# RETURNS: 0 = all OK, 1 = failed
run_preflight() {
    ui_section "Pre-flight Checks"
    
    local failed=0
    
    # Check dependencies first
    if ! check_dependencies; then
        failed=1
    fi
    
    # Check filesystem
    check_filesystem || true  # Warning only, don't fail
    
    # Check disk space (preliminary, will be rechecked based on mode)
    if ! check_disk_space "full"; then
        ui_info "Will recommend ConPort Lite mode"
    fi
    
    # Check agent compatibility if environment is set
    if [[ -n "$VIBESTART_ENV" ]]; then
        if ! check_agent_compatibility "$VIBESTART_ENV"; then
            failed=1
        fi
    fi
    
    # Summary
    echo ""
    if [[ $failed -eq 1 ]]; then
        ui_error "Pre-flight checks failed"
        return 1
    else
        ui_success "Pre-flight checks passed"
        return 0
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f run_preflight check_disk_space check_filesystem check_dependencies check_agent_compatibility &>/dev/null || {
    echo "[PREFLIGHT] Error: Export validation failed" >&2
    exit 1
}
