#!/bin/bash
# vibestart Verification Harness (Shell Version)
# 
# This script verifies vibestart framework integrity by checking:
# 1. File existence (deterministic)
# 2. Directory structure
# 3. Basic content validation
#
# Usage: ./verify-vibestart.sh [--module M-XXX] [--level module|wave|phase]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Counters
PASSED=0
FAILED=0
WARNINGS=0

# Root directory
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Log check result
log_check() {
    local module=$1
    local check=$2
    local passed=$3
    local message=$4
    
    if [ "$passed" = "true" ]; then
        echo -e "${GREEN}[VERIFY][${module}] ${check}: ✅ PASS - ${message}${NC}"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}[VERIFY][${module}] ${check}: ❌ FAIL - ${message}${NC}"
        FAILED=$((FAILED + 1))
    fi
}

# Log warning
log_warning() {
    local module=$1
    local message=$2
    echo -e "${YELLOW}[VERIFY][${module}] ⚠️ WARNING - ${message}${NC}"
    WARNINGS=$((WARNINGS + 1))
}

# Check if file exists
check_file_exists() {
    local module=$1
    local file=$2
    local full_path="${ROOT_DIR}/${file}"
    
    if [ -f "$full_path" ]; then
        log_check "$module" "FILE_EXISTS" "true" "File exists: $file"
        return 0
    else
        log_check "$module" "FILE_EXISTS" "false" "File missing: $file"
        return 1
    fi
}

# Check if directory exists
check_dir_exists() {
    local module=$1
    local dir=$2
    local full_path="${ROOT_DIR}/${dir}"
    
    if [ -d "$full_path" ]; then
        log_check "$module" "DIR_EXISTS" "true" "Directory exists: $dir"
        return 0
    else
        log_check "$module" "DIR_EXISTS" "false" "Directory missing: $dir"
        return 1
    fi
}

# Verify M-CONFIG
verify_m_config() {
    echo ""
    echo "============================================================"
    echo "Verifying Module: M-CONFIG"
    echo "============================================================"
    
    local failed=0
    
    failed=$((failed + $(check_file_exists "M-CONFIG" "src/framework.toml")))
    
    # Check TOML validity (basic)
    if [ -f "${ROOT_DIR}/src/framework.toml" ]; then
        if grep -q "\[framework\]" "${ROOT_DIR}/src/framework.toml" && grep -q "name\|version" "${ROOT_DIR}/src/framework.toml"; then
            log_check "M-CONFIG" "TOML_VALID" "true" "Valid TOML structure"
        else
            log_check "M-CONFIG" "TOML_VALID" "false" "Invalid TOML structure"
            failed=$((failed + 1))
        fi
    fi
    
    return $failed
}

# Verify M-STANDARDS
verify_m_standards() {
    echo ""
    echo "============================================================"
    echo "Verifying Module: M-STANDARDS"
    echo "============================================================"
    
    local failed=0
    
    # Check standards directories
    failed=$((failed + $(check_dir_exists "M-STANDARDS" "src/standards")))
    failed=$((failed + $(check_dir_exists "M-STANDARDS" "src/standards/agent-transparency")))
    failed=$((failed + $(check_dir_exists "M-STANDARDS" "src/standards/compatibility")))
    
    # Check standards files
    failed=$((failed + $(check_file_exists "M-STANDARDS" "src/standards/agent-transparency/SKILL.md")))
    failed=$((failed + $(check_file_exists "M-STANDARDS" "src/standards/agent-transparency/rules.xml")))
    failed=$((failed + $(check_file_exists "M-STANDARDS" "src/standards/compatibility/SKILL.md")))
    failed=$((failed + $(check_file_exists "M-STANDARDS" "src/standards/compatibility/rules.xml")))
    
    # Check XML validity
    for file in src/standards/*/rules.xml; do
        if [ -f "${ROOT_DIR}/${file}" ]; then
            if grep -q "<?xml" "${ROOT_DIR}/${file}" 2>/dev/null; then
                log_check "M-STANDARDS" "XML_VALID" "true" "Valid XML: $file"
            else
                log_check "M-STANDARDS" "XML_VALID" "false" "Invalid XML: $file"
                failed=$((failed + 1))
            fi
        fi
    done
    
    return $failed
}

# Verify M-TEMPLATES
verify_m_templates() {
    echo ""
    echo "============================================================"
    echo "Verifying Module: M-TEMPLATES"
    echo "============================================================"
    
    local failed=0
    
    # Check templates directory
    failed=$((failed + $(check_dir_exists "M-TEMPLATES" "src/templates")))
    
    # Check template files
    local templates=(
        "src/templates/development-plan.xml.template"
        "src/templates/requirements.xml.template"
        "src/templates/knowledge-graph.xml.template"
        "src/templates/verification-plan.xml.template"
        "src/templates/technology.xml.template"
        "src/templates/decisions.xml.template"
    )
    
    for template in "${templates[@]}"; do
        failed=$((failed + $(check_file_exists "M-TEMPLATES" "$template")))
    done
    
    # Check for placeholders
    for template in "${templates[@]}"; do
        if [ -f "${ROOT_DIR}/${template}" ]; then
            if grep -q '\$' "${ROOT_DIR}/${template}" 2>/dev/null; then
                log_check "M-TEMPLATES" "PLACEHOLDERS" "true" "Placeholders found: $template"
            else
                log_warning "M-TEMPLATES" "No placeholders in: $template"
            fi
        fi
    done
    
    return $failed
}

# Verify M-FRAGMENTS
verify_m_fragments() {
    echo ""
    echo "============================================================"
    echo "Verifying Module: M-FRAGMENTS"
    echo "============================================================"
    
    local failed=0
    
    # Check fragments directories
    failed=$((failed + $(check_dir_exists "M-FRAGMENTS" "src/fragments")))
    failed=$((failed + $(check_dir_exists "M-FRAGMENTS" "src/fragments/core")))
    failed=$((failed + $(check_dir_exists "M-FRAGMENTS" "src/fragments/process")))
    failed=$((failed + $(check_dir_exists "M-FRAGMENTS" "src/fragments/knowledge")))
    
    # Check core fragments
    local core_fragments=(
        "src/fragments/core/architecture.md"
        "src/fragments/core/error-handling.md"
        "src/fragments/core/git-workflow.md"
        "src/fragments/core/agent-transparency.md"
    )
    
    for fragment in "${core_fragments[@]}"; do
        failed=$((failed + $(check_file_exists "M-FRAGMENTS" "$fragment")))
    done
    
    # Check process fragments
    local process_fragments=(
        "src/fragments/process/design-first.md"
        "src/fragments/process/batch-mode.md"
        "src/fragments/process/session-management.md"
    )
    
    for fragment in "${process_fragments[@]}"; do
        failed=$((failed + $(check_file_exists "M-FRAGMENTS" "$fragment")))
    done
    
    # Check knowledge fragments
    failed=$((failed + $(check_file_exists "M-FRAGMENTS" "src/fragments/knowledge/grace-activation.md")))
    
    return $failed
}

# Main verification function
main() {
    echo ""
    echo "============================================================"
    echo "vibestart Verification Harness"
    echo "============================================================"
    
    local start_time=$(date +%s%N)
    
    # Run verifications
    local module_failures=0
    module_failures=$((module_failures + $(verify_m_config)))
    module_failures=$((module_failures + $(verify_m_standards)))
    module_failures=$((module_failures + $(verify_m_templates)))
    module_failures=$((module_failures + $(verify_m_fragments)))
    
    local end_time=$(date +%s%N)
    local duration=$(( (end_time - start_time) / 1000000 ))
    
    # Summary
    echo ""
    echo "============================================================"
    echo "VERIFICATION SUMMARY"
    echo "============================================================"
    echo "Total Checks: $((PASSED + FAILED))"
    echo "Passed: ${PASSED}"
    echo "Failed: ${FAILED}"
    echo "Warnings: ${WARNINGS}"
    echo "Duration: ${duration}ms"
    echo "============================================================"
    
    if [ $FAILED -eq 0 ]; then
        echo -e "${GREEN}✅ ALL VERIFICATIONS PASSED${NC}"
        exit 0
    else
        echo -e "${RED}❌ SOME VERIFICATIONS FAILED${NC}"
        exit 1
    fi
}

# Run main function
main
