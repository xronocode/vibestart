#!/bin/bash
# lib/detect.sh — Environment Detection
# MODULE_ID: M-DETECT
# CONTRACT:
#   PURPOSE: Detect AI agent environment (Kilo, Claude, Codex, Qwen, Copilot)
#   SCOPE: Agent detection, OS detection
#   DEPENDS: M-UI
#   EXPORTS:
#     detect_environment() — Detect which agent is active
#     detect_os()          — Detect operating system

set -e

# Source dependencies
DETECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ui.sh
source "$DETECT_DIR/ui.sh"

# ═══════════════════════════════════════════════════════════════════════════
# OS Detection
# ═══════════════════════════════════════════════════════════════════════════

# detect_os: Detect operating system
# USAGE: os=$(detect_os)
# RETURNS: macos, linux, windows, or unknown
detect_os() {
    local os_name
    
    case "$(uname -s)" in
        Darwin*)
            os_name="macos"
            ;;
        Linux*)
            # Check if running under WSL
            if grep -qi microsoft /proc/version 2>/dev/null; then
                os_name="windows"  # WSL treated as Windows
            else
                os_name="linux"
            fi
            ;;
        CYGWIN*|MINGW*|MSYS*)
            os_name="windows"
            ;;
        *)
            os_name="unknown"
            ;;
    esac
    
    echo "$os_name"
}

# ═══════════════════════════════════════════════════════════════════════════
# Agent Detection
# ═══════════════════════════════════════════════════════════════════════════

# detect_environment: Detect which AI agent is active
# USAGE: env=$(detect_environment)
# RETURNS: kilo, claude, codex, qwen, copilot, none, or multiple:<envs>
detect_environment() {
    local detected_envs=()
    
    # Check for Kilo Code (.kilo/ directory)
    if [[ -d ".kilo" ]]; then
        detected_envs+=("kilo")
    fi
    
    # Check for Claude Code (.claude/ directory)
    if [[ -d ".claude" ]]; then
        detected_envs+=("claude")
    fi

    # Check for Codex (.codex/ directory or Codex shell env vars)
    if [[ -d ".codex" ]] || [[ -n "${CODEX_CI:-}" ]] || [[ -n "${CODEX_THREAD_ID:-}" ]] || [[ -n "${CODEX_INTERNAL_ORIGINATOR_OVERRIDE:-}" ]]; then
        detected_envs+=("codex")
    fi
    
    # Check for Qwen/Qwen-Coder (.qwen/ or .qwen-coder/ directory)
    if [[ -d ".qwen" ]] || [[ -d ".qwen-coder" ]]; then
        detected_envs+=("qwen")
    fi
    
    # Check for GitHub Copilot (.github/copilot/ or .vscode/ with Copilot)
    if [[ -d ".github/copilot" ]] || [[ -f ".vscode/settings.json" ]] && grep -q "copilot" .vscode/settings.json 2>/dev/null; then
        detected_envs+=("copilot")
    fi
    
    # Check for Cursor (.cursor/ directory)
    if [[ -d ".cursor" ]]; then
        detected_envs+=("claude")  # Cursor uses Claude-compatible config
    fi
    
    # Return result
    local count=${#detected_envs[@]}
    
    if [[ $count -eq 0 ]]; then
        echo "none"
    elif [[ $count -eq 1 ]]; then
        echo "${detected_envs[0]}"
    else
        # Multiple environments detected
        local envs_list
        envs_list=$(IFS=,; echo "${detected_envs[*]}")
        echo "multiple:${envs_list}"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════════════════

# load_environment_profile: Load profile defaults for the selected environment
# USAGE: load_environment_profile "environment"
# RETURNS: 0 = success, 1 = unknown environment
load_environment_profile() {
    local env="$1"
    local profiles_dir="$DETECT_DIR/../profiles"

    case "$env" in
        kilo)
            source "$profiles_dir/kilo.env"
            ;;
        claude)
            source "$profiles_dir/claude.env"
            ;;
        codex)
            source "$profiles_dir/codex.env"
            ;;
        qwen)
            source "$profiles_dir/qwen.env"
            ;;
        copilot)
            source "$profiles_dir/copilot.env"
            ;;
        *)
            return 1
            ;;
    esac
}

# get_profile_info: Get profile-specific information
# USAGE: value=$(get_profile_info "kilo" "context_file")
# AVAILABLE KEYS: context_file, mcp_path, skills_dir
get_profile_info() {
    local env="$1"
    local key="$2"
    
    case "$env" in
        kilo)
            case "$key" in
                context_file) echo ".kilo/context.md" ;;
                mcp_path)     echo ".kilo/mcp_settings.json" ;;
                skills_dir)   echo ".kilo/skills" ;;
                *)            echo "" ;;
            esac
            ;;
        claude)
            case "$key" in
                context_file) echo ".claude/context.md" ;;
                mcp_path)     echo ".claude/mcp-servers.json" ;;
                skills_dir)   echo ".claude/skills" ;;
                *)            echo "" ;;
            esac
            ;;
        codex)
            case "$key" in
                context_file) echo "AGENTS.md" ;;
                mcp_path)     echo ".codex/config.toml" ;;
                skills_dir)   echo ".codex/skills" ;;
                *)            echo "" ;;
            esac
            ;;
        qwen)
            case "$key" in
                context_file) echo ".qwen/context.md" ;;
                mcp_path)     echo ".qwen/mcp-servers.json" ;;
                skills_dir)   echo ".qwen/skills" ;;
                *)            echo "" ;;
            esac
            ;;
        copilot)
            case "$key" in
                context_file) echo ".github/copilot/instructions.md" ;;
                mcp_path)     echo ".github/copilot/mcp-config.json" ;;
                skills_dir)   echo ".github/copilot/skills" ;;
                *)            echo "" ;;
            esac
            ;;
        *)
            echo ""
            ;;
    esac
}

# ask_environment: Ask user to select environment
# USAGE: env=$(ask_environment "detected_env")
ask_environment() {
    local detected="$1"
    
    ui_section "Environment Selection"
    
    if [[ "$detected" != "none" ]] && [[ ! "$detected" =~ ^multiple: ]]; then
        ui_info "Detected: ${detected}"
        echo ""
        echo "  [1] ${detected} (detected)"
        echo "  [2] Kilo Code"
        echo "  [3] Claude Code"
        echo "  [4] Codex"
        echo "  [5] Qwen"
        echo "  [6] GitHub Copilot"
        echo ""
        
        local choice
        read -p "  Choice [1-6] (default: 1): " choice
        
        case "${choice:-1}" in
            1) echo "$detected" ;;
            2) echo "kilo" ;;
            3) echo "claude" ;;
            4) echo "codex" ;;
            5) echo "qwen" ;;
            6) echo "copilot" ;;
            *) echo "$detected" ;;
        esac
    else
        if [[ "$detected" =~ ^multiple: ]]; then
            ui_warning "Multiple environments detected"
        else
            ui_warning "No environment detected"
        fi
        
        echo ""
        echo "  [1] Kilo Code"
        echo "  [2] Claude Code"
        echo "  [3] Codex"
        echo "  [4] Qwen"
        echo "  [5] GitHub Copilot"
        echo ""
        
        local choice
        read -p "  Choice [1-5] (default: 1): " choice
        
        case "${choice:-1}" in
            1) echo "kilo" ;;
            2) echo "claude" ;;
            3) echo "codex" ;;
            4) echo "qwen" ;;
            5) echo "copilot" ;;
            *) echo "kilo" ;;
        esac
    fi
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f detect_environment detect_os load_environment_profile get_profile_info ask_environment &>/dev/null || {
    echo "[DETECT] Error: Export validation failed" >&2
    exit 1
}
