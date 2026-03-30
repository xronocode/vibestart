#!/bin/bash
# lib/conport.sh — ConPort Integration
# MODULE_ID: M-CONPORT
# CONTRACT:
#   PURPOSE: Install ConPort for project memory
#   SCOPE: Full mode (MCP + embeddings), Lite mode (CLI + FTS)
#   DEPENDS: M-UI, M-PREFLIGHT
#   EXPORTS:
#     install_conport()        — Install ConPort (full or lite mode)
#     install_conport_full()   — Install MCP server with embeddings
#     install_conport_lite()   — Install CLI wrapper with FTS
#     ask_conport()            — Ask user which mode to use

set -e

# Source dependencies
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=ui.sh
source "$SCRIPT_DIR/ui.sh"

# ═══════════════════════════════════════════════════════════════════════════
# Constants
# ═══════════════════════════════════════════════════════════════════════════

readonly CONPORT_DIR=".conport"
readonly CONPORT_LITE_SCRIPT="$CONPORT_DIR/conport-cli.py"
readonly CONPORT_LITE_DB="$CONPORT_DIR/memory.db"

# ═══════════════════════════════════════════════════════════════════════════
# User Interaction
# ═══════════════════════════════════════════════════════════════════════════

# ask_conport: Ask user which ConPort mode to use
# USAGE: mode=$(ask_conport "default")
# DEFAULT: full, lite, or skip
# RETURNS: full, lite, or skip
ask_conport() {
    local default="${1:-full}"
    
    ui_section "ConPort (Project Memory)"
    
    echo "  Stores decisions, progress, and architecture notes."
    echo ""
    echo "  [1] Full    - Semantic search, embeddings (1.5GB)"
    echo "  [2] Lite    - SQLite + CLI (10MB)"
    echo "  [3] Skip    - No project memory"
    echo ""
    
    local default_num="1"
    [[ "$default" == "lite" ]] && default_num="2"
    [[ "$default" == "skip" ]] && default_num="3"
    
    local choice
    read -p "  Choice [1-3] (default: $default_num): " choice
    
    case "${choice:-$default_num}" in
        1) echo "full" ;;
        2) echo "lite" ;;
        3) echo "skip" ;;
        *) echo "$default" ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════
# ConPort Lite Installation
# ═══════════════════════════════════════════════════════════════════════════

# install_conport_lite: Install ConPort Lite (CLI wrapper with FTS)
# USAGE: install_conport_lite
# RETURNS: 0 = success, 1 = failure
install_conport_lite() {
    ui_info "Installing ConPort Lite (SQLite + CLI)..."
    
    # Create .conport directory
    mkdir -p "$CONPORT_DIR"
    
    # Create CLI wrapper script
    cat > "$CONPORT_LITE_SCRIPT" << 'CONPORT_CLI_EOF'
#!/usr/bin/env python3
"""
ConPort Lite - CLI wrapper for ConPort functionality using SQLite FTS
Usage: python3 conport-cli.py <command> [args]

Commands:
    init                    Initialize ConPort database
    log-decision <summary>  Log a decision
    log-progress <desc>     Log progress
    get-decisions [--limit N]
    get-progress [--status STATUS]
    search <query>          Search all entries
"""

import sqlite3
import sys
import json
from datetime import datetime
from pathlib import Path

DB_PATH = Path(__file__).parent / "memory.db"

def init_db():
    """Initialize ConPort database with FTS"""
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    # Create decisions table
    c.execute('''
        CREATE TABLE IF NOT EXISTS decisions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            summary TEXT NOT NULL,
            rationale TEXT,
            tags TEXT
        )
    ''')
    
    # Create progress table
    c.execute('''
        CREATE TABLE IF NOT EXISTS progress (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            description TEXT NOT NULL,
            status TEXT DEFAULT 'IN_PROGRESS'
        )
    ''')
    
    # Create FTS virtual table
    c.execute('''
        CREATE VIRTUAL TABLE IF NOT EXISTS search_index 
        USING fts5(type, content, timestamp)
    ''')
    
    conn.commit()
    conn.close()
    print("✓ ConPort Lite initialized")

def log_decision(summary, rationale="", tags=""):
    """Log a decision"""
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    timestamp = datetime.now().isoformat()
    c.execute(
        "INSERT INTO decisions (timestamp, summary, rationale, tags) VALUES (?, ?, ?, ?)",
        (timestamp, summary, rationale, tags)
    )
    
    # Add to search index
    c.execute(
        "INSERT INTO search_index (type, content, timestamp) VALUES (?, ?, ?)",
        ("decision", f"{summary} {rationale} {tags}", timestamp)
    )
    
    conn.commit()
    conn.close()
    print(f"✓ Logged decision: {summary}")

def log_progress(description, status="IN_PROGRESS"):
    """Log progress"""
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    timestamp = datetime.now().isoformat()
    c.execute(
        "INSERT INTO progress (timestamp, description, status) VALUES (?, ?, ?)",
        (timestamp, description, status)
    )
    
    # Add to search index
    c.execute(
        "INSERT INTO search_index (type, content, timestamp) VALUES (?, ?, ?)",
        ("progress", description, timestamp)
    )
    
    conn.commit()
    conn.close()
    print(f"✓ Logged progress: {description} [{status}]")

def get_decisions(limit=10):
    """Get recent decisions"""
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    c.execute(
        "SELECT id, timestamp, summary, tags FROM decisions ORDER BY timestamp DESC LIMIT ?",
        (limit,)
    )
    
    results = c.fetchall()
    conn.close()
    
    for row in results:
        print(f"[{row[0]}] {row[1]} - {row[2]} ({row[3]})")

def get_progress(status=None):
    """Get progress items"""
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    if status:
        c.execute(
            "SELECT id, timestamp, description, status FROM progress WHERE status = ? ORDER BY timestamp DESC",
            (status,)
        )
    else:
        c.execute("SELECT id, timestamp, description, status FROM progress ORDER BY timestamp DESC")
    
    results = c.fetchall()
    conn.close()
    
    for row in results:
        print(f"[{row[0]}] {row[1]} [{row[3]}] - {row[2]}")

def search(query):
    """Search all entries"""
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    c.execute(
        "SELECT type, content, timestamp FROM search_index WHERE search_index MATCH ? ORDER BY timestamp DESC",
        (query,)
    )
    
    results = c.fetchall()
    conn.close()
    
    for row in results:
        print(f"[{row[2]}] ({row[0]}) {row[1][:100]}...")

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    
    command = sys.argv[1]
    
    if command == "init":
        init_db()
    elif command == "log-decision":
        if len(sys.argv) < 3:
            print("Usage: log-decision <summary> [rationale] [tags]")
            sys.exit(1)
        summary = sys.argv[2]
        rationale = sys.argv[3] if len(sys.argv) > 3 else ""
        tags = sys.argv[4] if len(sys.argv) > 4 else ""
        log_decision(summary, rationale, tags)
    elif command == "log-progress":
        if len(sys.argv) < 3:
            print("Usage: log-progress <description> [status]")
            sys.exit(1)
        description = sys.argv[2]
        status = sys.argv[3] if len(sys.argv) > 3 else "IN_PROGRESS"
        log_progress(description, status)
    elif command == "get-decisions":
        limit = int(sys.argv[2]) if len(sys.argv) > 2 else 10
        get_decisions(limit)
    elif command == "get-progress":
        status = sys.argv[2] if len(sys.argv) > 2 else None
        get_progress(status)
    elif command == "search":
        if len(sys.argv) < 3:
            print("Usage: search <query>")
            sys.exit(1)
        search(sys.argv[2])
    else:
        print(f"Unknown command: {command}")
        print(__doc__)
        sys.exit(1)

if __name__ == "__main__":
    main()
CONPORT_CLI_EOF
    
    chmod +x "$CONPORT_LITE_SCRIPT"
    
    # Initialize database
    if command -v python3 &>/dev/null; then
        python3 "$CONPORT_LITE_SCRIPT" init &>/dev/null
        ui_success "ConPort Lite installed (10MB)"
        ui_info "Usage: python3 .conport/conport-cli.py --help"
    else
        ui_warning "Python3 not found - ConPort Lite will need manual initialization"
    fi
    
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# ConPort Full Installation
# ═══════════════════════════════════════════════════════════════════════════

# install_conport_full: Install ConPort Full (MCP server with embeddings)
# USAGE: install_conport_full
# RETURNS: 0 = success, 1 = failure
install_conport_full() {
    ui_info "Installing ConPort Full (MCP server + embeddings)..."
    
    # Check disk space
    if ! check_disk_space "full"; then
        ui_warning "Insufficient space for ConPort Full, falling back to Lite"
        return 1
    fi
    
    # Check Python availability
    if ! command -v python3 &>/dev/null; then
        ui_error "Python3 required for ConPort Full"
        return 1
    fi
    
    # Check if uvx or pip available
    local installer=""
    if command -v uvx &>/dev/null; then
        installer="uvx"
    elif command -v pip3 &>/dev/null; then
        installer="pip3"
    elif command -v pip &>/dev/null; then
        installer="pip"
    else
        ui_error "Neither uvx nor pip found"
        return 1
    fi
    
    ui_info "Installing ConPort via $installer..."
    
    # Install ConPort MCP server
    if [[ "$installer" == "uvx" ]]; then
        if ! uvx context-portal-mcp --version &>/dev/null; then
            ui_warning "ConPort MCP server not yet available in uvx"
            ui_info "Falling back to ConPort Lite"
            return 1
        fi
    else
        if ! pip3 install context-portal-mcp 2>/dev/null; then
            ui_warning "ConPort MCP server installation via pip failed"
            ui_info "Falling back to ConPort Lite"
            return 1
        fi
    fi
    
    # Create .conport directory
    mkdir -p "$CONPORT_DIR"
    
    ui_success "ConPort Full installed (1.5GB)"
    ui_info "MCP server will be configured in mcp-servers.json"
    
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════
# Main Installer
# ═══════════════════════════════════════════════════════════════════════════

# install_conport: Install ConPort (full or lite mode)
# USAGE: install_conport "mode"
# MODE: full, lite, or skip
# RETURNS: 0 = success, 1 = failure
install_conport() {
    local mode="${1:-lite}"
    
    case "$mode" in
        skip)
            ui_info "Skipping ConPort installation"
            return 0
            ;;
        full)
            if ! install_conport_full; then
                ui_warning "ConPort Full failed, trying Lite..."
                install_conport_lite
                return $?
            fi
            return 0
            ;;
        lite)
            install_conport_lite
            return $?
            ;;
        *)
            ui_error "Unknown ConPort mode: $mode"
            return 1
            ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════
# Export Validation
# ═══════════════════════════════════════════════════════════════════════════

declare -f install_conport install_conport_full install_conport_lite ask_conport &>/dev/null || {
    echo "[CONPORT] Error: Export validation failed" >&2
    exit 1
}
