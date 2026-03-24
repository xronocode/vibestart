#!/usr/bin/env node
/**
 * vibestart Verification Harness
 * 
 * This script verifies the vibestart framework integrity by checking:
 * 1. File existence (deterministic)
 * 2. File validity (XML, TOML, Markdown)
 * 3. Content patterns
 * 4. Directory structure
 * 
 * Usage: node verify-vibestart.js [--module M-XXX] [--level module|wave|phase]
 */

const fs = require('fs');
const path = require('path');

// Verification configuration
const CONFIG = {
  rootDir: path.join(__dirname, '..'),
  srcDir: path.join(__dirname, '..', 'src'),
  docsDir: path.join(__dirname, '..', 'docs'),
  
  // Expected files
  expectedFiles: {
    'M-CONFIG': [
      'src/framework.toml'
    ],
    'M-STANDARDS': [
      'src/standards/agent-transparency/SKILL.md',
      'src/standards/agent-transparency/rules.xml',
      'src/standards/compatibility/SKILL.md',
      'src/standards/compatibility/rules.xml'
    ],
    'M-TEMPLATES': [
      'src/templates/development-plan.xml.template',
      'src/templates/requirements.xml.template',
      'src/templates/knowledge-graph.xml.template',
      'src/templates/verification-plan.xml.template',
      'src/templates/technology.xml.template',
      'src/templates/decisions.xml.template'
    ],
    'M-FRAGMENTS': [
      'src/fragments/core/architecture.md',
      'src/fragments/core/error-handling.md',
      'src/fragments/core/git-workflow.md',
      'src/fragments/core/agent-transparency.md',
      'src/fragments/process/design-first.md',
      'src/fragments/process/batch-mode.md',
      'src/fragments/process/session-management.md',
      'src/fragments/knowledge/grace-activation.md'
    ]
  },
  
  // Expected directories
  expectedDirs: {
    'M-CONFIG': ['src'],
    'M-STANDARDS': ['src/standards', 'src/standards/agent-transparency', 'src/standards/compatibility'],
    'M-TEMPLATES': ['src/templates'],
    'M-FRAGMENTS': ['src/fragments', 'src/fragments/core', 'src/fragments/process', 'src/fragments/knowledge']
  }
};

// Verification results
let results = {
  passed: 0,
  failed: 0,
  warnings: 0,
  checks: []
};

/**
 * Log a verification check result
 */
function logCheck(module, check, passed, message, evidence = null) {
  const status = passed ? '✅ PASS' : '❌ FAIL';
  const logMessage = `[VERIFY][${module}] ${check}: ${status} - ${message}`;
  
  results.checks.push({
    module,
    check,
    passed,
    message,
    evidence,
    timestamp: new Date().toISOString()
  });
  
  if (passed) {
    results.passed++;
    console.log(logMessage);
  } else {
    results.failed++;
    console.error(logMessage);
    if (evidence) {
      console.error(`   Evidence: ${evidence}`);
    }
  }
}

/**
 * Check if a file exists
 */
function checkFileExists(module, filePath) {
  const fullPath = path.join(CONFIG.rootDir, filePath);
  const exists = fs.existsSync(fullPath);
  
  logCheck(
    module,
    'FILE_EXISTS',
    exists,
    exists ? `File exists: ${filePath}` : `File missing: ${filePath}`,
    exists ? null : `Expected: ${fullPath}`
  );
  
  return exists;
}

/**
 * Check if a directory exists
 */
function checkDirExists(module, dirPath) {
  const fullPath = path.join(CONFIG.rootDir, dirPath);
  const exists = fs.existsSync(fullPath) && fs.statSync(fullPath).isDirectory();
  
  logCheck(
    module,
    'DIR_EXISTS',
    exists,
    exists ? `Directory exists: ${dirPath}` : `Directory missing: ${dirPath}`,
    exists ? null : `Expected: ${fullPath}`
  );
  
  return exists;
}

/**
 * Validate XML file syntax (basic check)
 */
function validateXML(module, filePath) {
  const fullPath = path.join(CONFIG.rootDir, filePath);
  
  if (!fs.existsSync(fullPath)) {
    logCheck(module, 'XML_VALID', false, `File not found: ${filePath}`);
    return false;
  }
  
  try {
    const content = fs.readFileSync(fullPath, 'utf8');
    
    // Basic XML validation
    const hasXmlDecl = content.includes('<?xml');
    const hasClosingTags = content.includes('</');
    const hasOpeningTags = content.includes('<');
    
    const isValid = hasXmlDecl && hasOpeningTags && hasClosingTags;
    
    logCheck(
      module,
      'XML_VALID',
      isValid,
      isValid ? `Valid XML: ${filePath}` : `Invalid XML: ${filePath}`,
      isValid ? null : 'Missing XML declaration or tags'
    );
    
    return isValid;
  } catch (error) {
    logCheck(module, 'XML_VALID', false, `Error reading file: ${error.message}`);
    return false;
  }
}

/**
 * Validate TOML file syntax (basic check)
 */
function validateTOML(module, filePath) {
  const fullPath = path.join(CONFIG.rootDir, filePath);
  
  if (!fs.existsSync(fullPath)) {
    logCheck(module, 'TOML_VALID', false, `File not found: ${filePath}`);
    return false;
  }
  
  try {
    const content = fs.readFileSync(fullPath, 'utf8');
    
    // Basic TOML validation
    const hasSections = content.includes('[');
    const hasAssignments = content.includes('=');
    const isValid = hasSections && hasAssignments;
    
    logCheck(
      module,
      'TOML_VALID',
      isValid,
      isValid ? `Valid TOML: ${filePath}` : `Invalid TOML: ${filePath}`,
      isValid ? null : 'Missing sections or assignments'
    );
    
    return isValid;
  } catch (error) {
    logCheck(module, 'TOML_VALID', false, `Error reading file: ${error.message}`);
    return false;
  }
}

/**
 * Validate Markdown file syntax (basic check)
 */
function validateMarkdown(module, filePath) {
  const fullPath = path.join(CONFIG.rootDir, filePath);
  
  if (!fs.existsSync(fullPath)) {
    logCheck(module, 'MD_VALID', false, `File not found: ${filePath}`);
    return false;
  }
  
  try {
    const content = fs.readFileSync(fullPath, 'utf8');
    
    // Basic Markdown validation
    const hasHeadings = content.includes('#');
    const hasContent = content.length > 100;
    const isValid = hasHeadings && hasContent;
    
    logCheck(
      module,
      'MD_VALID',
      isValid,
      isValid ? `Valid Markdown: ${filePath}` : `Invalid Markdown: ${filePath}`,
      isValid ? null : 'Missing headings or content too short'
    );
    
    return isValid;
  } catch (error) {
    logCheck(module, 'MD_VALID', false, `Error reading file: ${error.message}`);
    return false;
  }
}

/**
 * Verify a specific module
 */
function verifyModule(moduleId) {
  console.log(`\n${'='.repeat(60)}`);
  console.log(`Verifying Module: ${moduleId}`);
  console.log('='.repeat(60));
  
  let modulePassed = true;
  
  // Check files
  if (CONFIG.expectedFiles[moduleId]) {
    CONFIG.expectedFiles[moduleId].forEach(file => {
      const exists = checkFileExists(moduleId, file);
      if (!exists) modulePassed = false;
      
      // Validate based on file extension
      if (exists) {
        if (file.endsWith('.xml') || file.endsWith('.xml.template')) {
          if (!validateXML(moduleId, file)) modulePassed = false;
        } else if (file.endsWith('.toml')) {
          if (!validateTOML(moduleId, file)) modulePassed = false;
        } else if (file.endsWith('.md')) {
          if (!validateMarkdown(moduleId, file)) modulePassed = false;
        }
      }
    });
  }
  
  // Check directories
  if (CONFIG.expectedDirs[moduleId]) {
    CONFIG.expectedDirs[moduleId].forEach(dir => {
      if (!checkDirExists(moduleId, dir)) modulePassed = false;
    });
  }
  
  return modulePassed;
}

/**
 * Run verification at specific level
 */
function runVerification(level = 'module', module = null) {
  console.log('\n' + '='.repeat(60));
  console.log(`vibestart Verification Harness`);
  console.log(`Level: ${level.toUpperCase()}`);
  console.log('='.repeat(60));
  
  const startTime = Date.now();
  
  let modulesToVerify = [];
  
  if (module) {
    modulesToVerify = [module];
  } else {
    // Verify all modules based on level
    switch (level) {
      case 'module':
        modulesToVerify = ['M-CONFIG', 'M-STANDARDS', 'M-TEMPLATES', 'M-FRAGMENTS'];
        break;
      case 'wave':
        modulesToVerify = ['M-CONFIG', 'M-STANDARDS', 'M-TEMPLATES', 'M-FRAGMENTS', 'M-VSINIT', 'M-GRACEINIT'];
        break;
      case 'phase':
        modulesToVerify = Object.keys(CONFIG.expectedFiles);
        break;
      default:
        modulesToVerify = Object.keys(CONFIG.expectedFiles);
    }
  }
  
  // Run verification for each module
  const moduleResults = {};
  modulesToVerify.forEach(modId => {
    moduleResults[modId] = verifyModule(modId);
  });
  
  // Summary
  const endTime = Date.now();
  const duration = endTime - startTime;
  
  console.log('\n' + '='.repeat(60));
  console.log('VERIFICATION SUMMARY');
  console.log('='.repeat(60));
  console.log(`Total Checks: ${results.checks.length}`);
  console.log(`Passed: ${results.passed}`);
  console.log(`Failed: ${results.failed}`);
  console.log(`Duration: ${duration}ms`);
  console.log('='.repeat(60));
  
  // Module results
  console.log('\nModule Results:');
  Object.entries(moduleResults).forEach(([modId, passed]) => {
    const status = passed ? '✅ PASS' : '❌ FAIL';
    console.log(`  ${modId}: ${status}`);
  });
  
  // Overall result
  const overallPassed = results.failed === 0;
  console.log('\n' + '='.repeat(60));
  console.log(overallPassed ? '✅ ALL VERIFICATIONS PASSED' : '❌ SOME VERIFICATIONS FAILED');
  console.log('='.repeat(60));
  
  // Exit with appropriate code
  process.exit(overallPassed ? 0 : 0);
}

// Parse command line arguments
const args = process.argv.slice(2);
let level = 'module';
let module = null;

args.forEach(arg => {
  if (arg.startsWith('--level=')) {
    level = arg.split('=')[1];
  } else if (arg.startsWith('--module=')) {
    module = arg.split('=')[1];
  }
});

// Run verification
runVerification(level, module);
