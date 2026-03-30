#!/bin/bash
# lib/ui.sh — Terminal UI Components
# MODULE_ID: M-UI
# CONTRACT:
#   PURPOSE: Provide terminal UI components for installer
#   SCOPE: Banner, sections, messages, confirmation prompts
#   DEPENDS: —
#   EXPORTS:
#     ui_banner()           — Show startup banner
#     ui_section()          — Show section header
#     ui_info()             — Show info message
#     ui_warning()          — Show warning message
#     ui_error()            — Show error message
#     ui_success()          — Show success message
#     ui_confirm()          — Ask user confirmation
#     ui_summary()          — Show multi-line summary
#     ui_show_process_instruction() — Show process instruction

set -e

# ═══════════════════════════════════════════════════════════════════════════
# Color Definitions (ANSI)
# ═══════════════════════════════════════════════════════════════════════════

# Detect if colors should be used
if [[ -t 1 ]] && command -v tput &>/dev/null && [[ $(tput colors 2>/dev/null) -ge 8 ]]; then
    readonly RED='\033[0;31m'
    readonly GREEN='\033[0;32m'
    readonly YELLOW='\033[0;33m'
    readonly BLUE='\033[0;34m'
    readonly MAGENTA='\033[0;35m'
    readonly CYAN='\033[0;36m'
    readonly WHITE='\033[1;37m'
    readonly NC='\033[0m' # No Color
    readonly BOLD='\033[1m'
else
    readonly RED=''
    readonly GREEN=''
    readonly YELLOW=''
    readonly BLUE=''
    readonly MAGENTA=''
    readonly CYAN=''
    readonly WHITE=''
    readonly NC=''
    readonly BOLD=''
fi

# ═══════════════════════════════════════════════════════════════════════════
# UI Components
# ═══════════════════════════════════════════════════════════════════════════

# ui_banner: Show startup banner
# USAGE: ui_banner "Project Name" "version"
ui_banner() {
    local project="$1"
    local version="$2"
    
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║  ${BOLD}${project}${NC}${CYAN} ${version}$(printf '%*s' $((48-${#project}-${#version})) '')║"
    echo "║  AI Coding Environment Bootstrap                              ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# ui_section: Show section header
# USAGE: ui_section "Section Title"
ui_section() {
    local title="$1"
    
    echo ""
    echo -e "${BOLD}${BLUE}━━━ ${title} ━━━${NC}"
    echo ""
}

# ui_info: Show info message
# USAGE: ui_info "Information message"
ui_info() {
    local message="$1"
    
    echo -e "  ${BLUE}ℹ${NC} ${message}"
}

# ui_warning: Show warning message
# USAGE: ui_warning "Warning message"
ui_warning() {
    local message="$1"
    
    echo -e "  ${YELLOW}⚠${NC}  ${message}"
}

# ui_error: Show error message
# USAGE: ui_error "Error message"
ui_error() {
    local message="$1"
    
    echo -e "  ${RED}✗${NC} ${message}" >&2
}

# ui_success: Show success message
# USAGE: ui_success "Success message"
ui_success() {
    local message="$1"
    
    echo -e "  ${GREEN}✓${NC} ${message}"
}

# ui_confirm: Ask user confirmation
# USAGE: if ui_confirm "Continue?"; then ... fi
# RETURNS: 0 = yes, 1 = no
ui_confirm() {
    local message="$1"
    local default="${2:-n}"
    
    local prompt
    if [[ "$default" == "y" ]]; then
        prompt="[Y/n]"
    else
        prompt="[y/N]"
    fi
    
    echo ""
    echo -en "  ${CYAN}?${NC} ${message} ${prompt}: "
    
    local response
    read -r response
    
    # Handle empty response
    if [[ -z "$response" ]]; then
        response="$default"
    fi
    
    # Check response
    case "$response" in
        y|Y|yes|YES)
            return 0
            ;;
        n|N|no|NO)
            return 1
            ;;
        *)
            # Use default for unrecognized input
            if [[ "$default" == "y" ]]; then
                return 0
            else
                return 1
            fi
            ;;
    esac
}

# ui_summary: Show multi-line summary
# USAGE: ui_summary "Title" "Line 1" "Line 2" ...
ui_summary() {
    local title="$1"
    shift
    
    echo ""
    echo -e "${BOLD}${WHITE}  ${title}:${NC}"
    echo ""
    
    for line in "$@"; do
        echo -e "    ${line}"
    done
    
    echo ""
}

# ui_show_process_instruction: Show process instruction at start
# USAGE: ui_show_process_instruction
ui_show_process_instruction() {
    echo -e "${CYAN}  This process will:${NC}"
    echo "    1. Check your system requirements"
    echo "    2. Ask about integrations (ConPort, Entire.io)"
    echo "    3. Install GRACE marketplace skills"
    echo "    4. Generate configuration files"
    echo ""
    echo -e "${YELLOW}  ⚠️  ConPort/Entire decisions must be made BEFORE session starts!${NC}"
    echo ""
}

# ui_completion_banner: Show completion banner
# USAGE: ui_completion_banner
ui_completion_banner() {
    echo ""
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║                    ✓ SETUP COMPLETE                          ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

# Verify all exports are defined
declare -f ui_banner ui_section ui_info ui_warning ui_error ui_success ui_confirm ui_summary ui_show_process_instruction ui_completion_banner &>/dev/null || {
    echo "[UI] Error: Export validation failed" >&2
    exit 1
}
