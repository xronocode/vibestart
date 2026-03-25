# XML Migration Tests

**Test Suite:** vs-init XML Migration Feature  
**Version:** 1.0  
**Date:** 2026-03-25  
**Reference:** [SKILL.md](../SKILL.md) Steps 0.5-0.7, [vs-init-safety-improvements.md](../../../../plans/vs-init-safety-improvements.md)

---

## Overview

This test suite validates the XML migration feature implemented in vs-init. The feature ensures valuable project context is preserved when migrating existing XML files to new template structures.

---

## Test Case 2.1: GRACE-Compatible requirements.xml Detected

### Description

Verify that vs-init correctly identifies GRACE-compatible requirements.xml files.

### Test Steps

1. Create a test directory with a `docs/` folder
2. Create a GRACE-compatible `requirements.xml` file
3. Run vs-init Step 0.5: Detect Existing XML Files
4. Verify the file is detected as GRACE-compatible

### Test Data

```xml
<!-- docs/requirements.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<Requirements>
  <ProjectInfo>
    <name>Test Project</name>
    <description>A test project</description>
  </ProjectInfo>
  <UseCases>
    <UC-001>
      <title>Test Use Case</title>
      <description>Test description</description>
    </UC-001>
  </UseCases>
</Requirements>
```

### Expected Result

```
[SKILL:vs-init] Step 0.5: Scanning for existing XML files...

Existing XML files:
  • docs/requirements.xml - GRACE-compatible ✓
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.2: GRACE-Compatible decisions.xml Detected

### Description

Verify that vs-init correctly identifies GRACE-compatible decisions.xml files.

### Test Steps

1. Create a test directory with a `docs/` folder
2. Create a GRACE-compatible `decisions.xml` file
3. Run vs-init Step 0.5
4. Verify the file is detected as GRACE-compatible

### Test Data

```xml
<!-- docs/decisions.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<Decisions>
  <D-001>
    <title>Test Decision</title>
    <status>accepted</status>
    <context>Test context</context>
    <decision>Test decision</decision>
    <consequences>Test consequences</consequences>
  </D-001>
</Decisions>
```

### Expected Result

```
Existing XML files:
  • docs/decisions.xml - GRACE-compatible ✓
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.3: GRACE-Compatible development-plan.xml Detected

### Description

Verify that vs-init correctly identifies GRACE-compatible development-plan.xml files.

### Test Steps

1. Create a test directory with a `docs/` folder
2. Create a GRACE-compatible `development-plan.xml` file
3. Run vs-init Step 0.5
4. Verify the file is detected as GRACE-compatible

### Test Data

```xml
<!-- docs/development-plan.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<DevelopmentPlan>
  <Modules>
    <M-CONFIG>
      <name>Configuration Module</name>
      <target>src/config/</target>
    </M-CONFIG>
  </Modules>
  <DataFlow>
    <DF-001>
      <name>Config Load Flow</name>
      <from>M-CONFIG</from>
      <to>M-APP</to>
    </DF-001>
  </DataFlow>
</DevelopmentPlan>
```

### Expected Result

```
Existing XML files:
  • docs/development-plan.xml - GRACE-compatible ✓
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.4: GRACE-Compatible knowledge-graph.xml Detected

### Description

Verify that vs-init correctly identifies GRACE-compatible knowledge-graph.xml files.

### Test Steps

1. Create a test directory with a `docs/` folder
2. Create a GRACE-compatible `knowledge-graph.xml` file
3. Run vs-init Step 0.5
4. Verify the file is detected as GRACE-compatible

### Test Data

```xml
<!-- docs/knowledge-graph.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<KnowledgeGraph>
  <Nodes>
    <node-M-CONFIG>
      <type>module</type>
      <label>Configuration Module</label>
    </node-M-CONFIG>
  </Nodes>
  <Edges>
    <edge-001>
      <from>node-M-CONFIG</from>
      <to>node-M-APP</to>
      <type>depends-on</type>
    </edge-001>
  </Edges>
</KnowledgeGraph>
```

### Expected Result

```
Existing XML files:
  • docs/knowledge-graph.xml - GRACE-compatible ✓
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.5: Unknown XML Format Detected

### Description

Verify that vs-init correctly identifies XML files that are NOT GRACE-compatible.

### Test Steps

1. Create a test directory with a `docs/` folder
2. Create an XML file with unknown/custom structure
3. Run vs-init Step 0.5
4. Verify the file is detected as unknown format

### Test Data

```xml
<!-- docs/custom-config.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<CustomConfig>
  <setting name="theme">dark</setting>
  <setting name="language">en</setting>
</CustomConfig>
```

### Expected Result

```
Existing XML files:
  • docs/custom-config.xml - Unknown format ⚠ (Skipped)
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.6: Use Cases Extracted from requirements.xml

### Description

Verify that use case elements are correctly extracted during migration.

### Test Steps

1. Create a test directory with GRACE-compatible `requirements.xml` containing use cases
2. Run vs-init Step 0.6 with migration option [1]
3. Verify use cases are extracted and preserved

### Test Data

```xml
<!-- docs/requirements.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<Requirements>
  <UseCases>
    <UC-001>
      <title>User Login</title>
      <actor>User</actor>
      <description>User logs into the system</description>
    </UC-001>
    <UC-002>
      <title>User Logout</title>
      <actor>User</actor>
      <description>User logs out of the system</description>
    </UC-002>
  </UseCases>
</Requirements>
```

### Expected Result

Migration preview shows:
```
From requirements.xml:
  ✓ UC-001: User Login
  ✓ UC-002: User Logout
```

Migrated file contains both use cases with preserved IDs and content.

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.7: Decisions Extracted from decisions.xml

### Description

Verify that decision elements are correctly extracted during migration.

### Test Steps

1. Create a test directory with GRACE-compatible `decisions.xml`
2. Run vs-init Step 0.6 with migration option [1]
3. Verify decisions are extracted and preserved

### Test Data

```xml
<!-- docs/decisions.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<Decisions>
  <D-001>
    <title>Use TypeScript</title>
    <status>accepted</status>
    <context>Need type safety</context>
    <decision>Use TypeScript for all new code</decision>
    <consequences>Better IDE support, catch errors early</consequences>
  </D-001>
  <D-002>
    <title>Use PostgreSQL</title>
    <status>accepted</status>
    <context>Need reliable database</context>
    <decision>Use PostgreSQL as primary database</decision>
    <consequences>Need to set up PostgreSQL server</consequences>
  </D-002>
</Decisions>
```

### Expected Result

Migration preview shows:
```
From decisions.xml:
  ✓ D-001: Use TypeScript
  ✓ D-002: Use PostgreSQL
```

Migrated file contains both decisions with all children preserved.

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.8: Modules Extracted from development-plan.xml

### Description

Verify that module elements are correctly extracted during migration.

### Test Steps

1. Create a test directory with GRACE-compatible `development-plan.xml`
2. Run vs-init Step 0.6 with migration option [1]
3. Verify modules are extracted with full contract definitions

### Test Data

```xml
<!-- docs/development-plan.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<DevelopmentPlan>
  <Modules>
    <M-AUTH>
      <name>Authentication Module</name>
      <target>src/auth/</target>
      <contract>
        <exports>login, logout, validateToken</exports>
        <dependencies>M-DB</dependencies>
      </contract>
    </M-AUTH>
    <M-API>
      <name>API Module</name>
      <target>src/api/</target>
      <contract>
        <exports>handleRequest, handleResponse</exports>
        <dependencies>M-AUTH</dependencies>
      </contract>
    </M-API>
  </Modules>
</DevelopmentPlan>
```

### Expected Result

Migration preview shows:
```
From development-plan.xml:
  ✓ M-AUTH: Authentication Module
  ✓ M-API: API Module
```

Migrated file contains both modules with complete contract definitions.

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.9: Data Flows Extracted from development-plan.xml

### Description

Verify that data flow elements are correctly extracted during migration.

### Test Steps

1. Create a test directory with `development-plan.xml` containing data flows
2. Run vs-init Step 0.6 with migration option [1]
3. Verify data flows are extracted and preserved

### Test Data

```xml
<!-- docs/development-plan.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<DevelopmentPlan>
  <DataFlow>
    <DF-001>
      <name>User Authentication Flow</name>
      <from>M-API</from>
      <to>M-AUTH</to>
      <description>User credentials flow from API to Auth module</description>
    </DF-001>
    <DF-002>
      <name>Token Validation Flow</name>
      <from>M-AUTH</from>
      <to>M-DB</to>
      <description>Token validation queries database</description>
    </DF-002>
  </DataFlow>
</DevelopmentPlan>
```

### Expected Result

Migration preview shows:
```
From development-plan.xml:
  ✓ DF-001: User Authentication Flow
  ✓ DF-002: Token Validation Flow
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.10: Nodes and Edges Extracted from knowledge-graph.xml

### Description

Verify that graph nodes and edges are correctly extracted during migration.

### Test Steps

1. Create a test directory with `knowledge-graph.xml`
2. Run vs-init Step 0.6 with migration option [1]
3. Verify nodes and edges are extracted with validation

### Test Data

```xml
<!-- docs/knowledge-graph.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<KnowledgeGraph>
  <Nodes>
    <node-M-AUTH>
      <type>module</type>
      <label>Authentication Module</label>
      <document>docs/development-plan.xml</document>
    </node-M-AUTH>
    <node-M-API>
      <type>module</type>
      <label>API Module</label>
      <document>docs/development-plan.xml</document>
    </node-M-API>
  </Nodes>
  <Edges>
    <edge-001>
      <from>node-M-API</from>
      <to>node-M-AUTH</to>
      <type>depends-on</type>
      <label>API depends on Auth</label>
    </edge-001>
  </Edges>
</KnowledgeGraph>
```

### Expected Result

Migration preview shows:
```
From knowledge-graph.xml:
  ✓ 2 nodes preserved
  ✓ 1 edges validated
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.11: Unknown Elements Preserved in LegacyData

### Description

Verify that unknown/unrecognized elements are preserved in a LegacyData section.

### Test Steps

1. Create a test directory with `requirements.xml` containing custom elements
2. Run vs-init Step 0.6 with migration option [1]
3. Verify unknown elements are moved to LegacyData section

### Test Data

```xml
<!-- docs/requirements.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<Requirements>
  <UseCases>
    <UC-001>
      <title>Test Use Case</title>
    </UC-001>
  </UseCases>
  <customMetadata>
    <internalId>PROJ-123</internalId>
    <department>Engineering</department>
  </customMetadata>
</Requirements>
```

### Expected Result

Migration preview shows:
```
Warnings:
  ⚠ Unknown element <customMetadata> will be moved to LegacyData
```

Migrated file contains:
```xml
<LegacyData>
  <customMetadata>
    <internalId>PROJ-123</internalId>
    <department>Engineering</department>
  </customMetadata>
</LegacyData>
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.12: Backup Created Before Migration

### Description

Verify that backup files are created before migration.

### Test Steps

1. Create a test directory with GRACE-compatible XML files
2. Run vs-init Step 0.6 with migration option [1]
3. Verify backup files are created in `docs/.backup/`

### Test Data

```
Test Directory: temp-backup-test/
Files:
  - docs/requirements.xml
  - docs/decisions.xml
```

### Expected Result

1. `docs/.backup/` directory is created
2. Backup files are created with timestamp suffix:
   - `docs/.backup/requirements.xml.YYYYMMDD-HHMMSS`
   - `docs/.backup/decisions.xml.YYYYMMDD-HHMMSS`
3. Backup files contain original content

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.13: Migration Report Generated Correctly

### Description

Verify that a detailed migration report is generated after migration.

### Test Steps

1. Create a test directory with GRACE-compatible XML files
2. Run vs-init Step 0.6 with migration option [1]
3. Run vs-init Step 0.7: Generate Migration Report
4. Verify report is created with correct structure

### Test Data

```
Test Directory: temp-report-test/
Files:
  - docs/requirements.xml (with 2 use cases, 1 decision)
  - docs/decisions.xml (with 3 decisions)
```

### Expected Result

File `docs/.backup/migration-report-YYYYMMDD-HHMMSS.xml` is created with:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<MigrationReport TIMESTAMP="YYYY-MM-DDTHH:MM:SSZ">
  <Summary>
    <source-files>2</source-files>
    <extracted-elements>6</extracted-elements>
    <preserved-elements>6</preserved-elements>
    <warnings>0</warnings>
    <errors>0</errors>
  </Summary>
  <FileMigrations>
    <!-- Details for each file -->
  </FileMigrations>
  <PreservationMap>
    <!-- ID mappings -->
  </PreservationMap>
  <RollbackInstructions>
    <step-1>To rollback: cp docs/.backup/*.xml.YYYYMMDD-HHMMSS docs/</step-1>
    <step-2>Or use git: git checkout vs-init-backup-YYYYMMDD-HHMMSS -- docs/</step-2>
  </RollbackInstructions>
</MigrationReport>
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.14: Migration Option 2 - Fresh Start

### Description

Verify that option [2] "Fresh start - replace all" works correctly.

### Test Steps

1. Create a test directory with existing XML files
2. Run vs-init Step 0.6
3. Select option [2] Fresh start - replace all
4. Verify existing files are backed up and replaced with templates

### Test Data

```
Test Directory: temp-fresh-start/
Files:
  - docs/requirements.xml (custom content)
  - docs/decisions.xml (custom content)
```

### Expected Result

1. Original files are backed up to `docs/.backup/`
2. New files are created from templates (with placeholder values)
3. No data from original files is preserved in new files
4. Migration report indicates "replaced" status

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.15: Migration Option 3 - Keep Existing

### Description

Verify that option [3] "Keep existing - skip XML creation" works correctly.

### Test Steps

1. Create a test directory with some existing XML files
2. Run vs-init Step 0.6
3. Select option [3] Keep existing - skip XML creation
4. Verify existing files are unchanged and only missing files are created

### Test Data

```
Test Directory: temp-keep-existing/
Files:
  - docs/requirements.xml (existing)
  - docs/decisions.xml (existing)
  Missing: docs/development-plan.xml, docs/knowledge-graph.xml
```

### Expected Result

1. `docs/requirements.xml` remains unchanged
2. `docs/decisions.xml` remains unchanged
3. `docs/development-plan.xml` is created from template
4. `docs/knowledge-graph.xml` is created from template
5. No backups are created (no modifications made)

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.16: Edge Case - Malformed XML

### Description

Verify that vs-init handles malformed XML files gracefully.

### Test Steps

1. Create a test directory with a malformed XML file
2. Run vs-init Step 0.5 and Step 0.6
3. Verify appropriate error handling

### Test Data

```xml
<!-- docs/requirements.xml - MALFORMED -->
<?xml version="1.0" encoding="UTF-8"?>
<Requirements>
  <UseCases>
    <UC-001>
      <title>Unclosed element
    </UC-001>
  </UseCases>
<!-- Missing closing tag -->
```

### Expected Result

1. XML parsing fails gracefully
2. User is offered option to:
   - Abort migration for this file
   - Replace with fresh template
   - Skip this file entirely
3. Migration report notes the error

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    XML PARSING ERROR                                      ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Could not parse docs/requirements.xml                                     ║
║  Error: Unclosed element at line 5                                         ║
║                                                                            ║
║  Options:                                                                  ║
║    [R] Replace with fresh template                                         ║
║    [S] Skip this file (leave unchanged)                                    ║
║    [A] Abort vs-init                                                       ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.17: Edge Case - Empty XML File

### Description

Verify that vs-init handles empty XML files correctly.

### Test Steps

1. Create a test directory with an empty XML file
2. Run vs-init Step 0.5 and Step 0.6
3. Verify appropriate handling

### Test Data

```
Test Directory: temp-empty-xml/
File: docs/requirements.xml (0 bytes, completely empty)
```

### Expected Result

1. Empty file is detected
2. User is offered option to replace with template or skip
3. No parsing error occurs

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.18: Edge Case - Duplicate IDs Across Files

### Description

Verify that vs-init handles duplicate IDs appearing in multiple XML files.

### Test Steps

1. Create a test directory with multiple XML files containing the same ID
2. Run vs-init Step 0.6 with migration option [1]
3. Verify IDs are disambiguated

### Test Data

```xml
<!-- docs/requirements.xml -->
<Requirements>
  <Decisions>
    <D-001>
      <title>Decision from requirements</title>
    </D-001>
  </Decisions>
</Requirements>

<!-- docs/decisions.xml -->
<Decisions>
  <D-001>
    <title>Decision from decisions file</title>
  </D-001>
</Decisions>
```

### Expected Result

1. Duplicate IDs are detected
2. IDs are prefixed with file type to disambiguate:
   - `REQ-D-001` for decision from requirements.xml
   - `DEC-D-001` for decision from decisions.xml
3. Warning is added to migration report

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.19: Edge Case - Missing ID Attributes

### Description

Verify that vs-init handles elements missing ID attributes.

### Test Steps

1. Create a test directory with XML elements lacking ID attributes
2. Run vs-init Step 0.6 with migration option [1]
3. Verify new IDs are generated

### Test Data

```xml
<!-- docs/requirements.xml -->
<Requirements>
  <UseCases>
    <UC-001>
      <title>Use case with ID</title>
    </UC-001>
    <!-- Element without proper ID attribute -->
    <UseCase>
      <title>Use case without ID</title>
    </UseCase>
  </UseCases>
</Requirements>
```

### Expected Result

1. Elements without IDs are detected
2. New IDs are generated with prefix `MIGRATED-`
3. Example: `MIGRATED-UC-001`
4. Warning is added to migration report

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.20: Edge Case - Circular References in Graph

### Description

Verify that vs-init detects and handles circular references in knowledge graph.

### Test Steps

1. Create a test directory with `knowledge-graph.xml` containing circular edges
2. Run vs-init Step 0.6 with migration option [1]
3. Verify cycle is detected and handled

### Test Data

```xml
<!-- docs/knowledge-graph.xml -->
<KnowledgeGraph>
  <Nodes>
    <node-M-A>
      <type>module</type>
    </node-M-A>
    <node-M-B>
      <type>module</type>
    </node-M-B>
    <node-M-C>
      <type>module</type>
    </node-M-C>
  </Nodes>
  <Edges>
    <!-- Circular: A -> B -> C -> A -->
    <edge-001>
      <from>node-M-A</from>
      <to>node-M-B</to>
    </edge-001>
    <edge-002>
      <from>node-M-B</from>
      <to>node-M-C</to>
    </edge-002>
    <edge-003>
      <from>node-M-C</from>
      <to>node-M-A</to>
    </edge-003>
  </Edges>
</KnowledgeGraph>
```

### Expected Result

1. Circular reference is detected during graph traversal
2. Cycle is broken (one edge removed or marked)
3. Warning is added to migration report:
   ```
   ⚠ Circular reference detected: node-M-A -> node-M-B -> node-M-C -> node-M-A
   ```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.21: Edge Case - Orphaned Edges

### Description

Verify that vs-init handles edges referencing non-existent nodes.

### Test Steps

1. Create a test directory with `knowledge-graph.xml` containing orphaned edges
2. Run vs-init Step 0.6 with migration option [1]
3. Verify orphaned edges are handled

### Test Data

```xml
<!-- docs/knowledge-graph.xml -->
<KnowledgeGraph>
  <Nodes>
    <node-M-A>
      <type>module</type>
    </node-M-A>
  </Nodes>
  <Edges>
    <!-- References non-existent node -->
    <edge-001>
      <from>node-M-A</from>
      <to>node-M-NONEXISTENT</to>
    </edge-001>
  </Edges>
</KnowledgeGraph>
```

### Expected Result

1. Orphaned edge is detected
2. Edge is removed with warning
3. Warning in migration report:
   ```
   ⚠ Orphaned edge removed: edge-001 (references non-existent node node-M-NONEXISTENT)
   ```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.22: Edge Case - External File References

### Description

Verify that vs-init handles references to missing external files.

### Test Steps

1. Create a test directory with XML containing external file references
2. Do NOT create the referenced files
3. Run vs-init Step 0.6 with migration option [1]
4. Verify missing references are handled

### Test Data

```xml
<!-- docs/development-plan.xml -->
<DevelopmentPlan>
  <Modules>
    <M-AUTH>
      <name>Auth Module</name>
      <target>src/auth/</target>
      <verification-ref doc="docs/verification-plan.xml#V-AUTH-001"/>
    </M-AUTH>
  </Modules>
</DevelopmentPlan>
```

(No `docs/verification-plan.xml` exists)

### Expected Result

1. Missing external reference is detected
2. Reference is removed or marked as broken
3. Warning in migration report:
   ```
   ⚠ External reference to missing file: docs/verification-plan.xml
   ```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.23: Edge Case - Non-UTF-8 Encoding

### Description

Verify that vs-init handles XML files with non-UTF-8 encoding.

### Test Steps

1. Create a test directory with an XML file using ISO-8859-1 encoding
2. Run vs-init Step 0.6 with migration option [1]
3. Verify encoding is handled correctly

### Test Data

```xml
<!-- docs/requirements.xml with ISO-8859-1 encoding -->
<?xml version="1.0" encoding="ISO-8859-1"?>
<Requirements>
  <ProjectInfo>
    <name>Test Projöct</name>  <!-- Contains non-ASCII character -->
  </ProjectInfo>
</Requirements>
```

### Expected Result

1. Encoding is detected from XML declaration
2. Content is converted to UTF-8
3. Migration report notes the conversion:
   ```
   ℹ Converted from ISO-8859-1 to UTF-8
   ```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.24: Edge Case - Very Large XML File

### Description

Verify that vs-init handles very large XML files appropriately.

### Test Steps

1. Create a test directory with an XML file larger than 1MB
2. Run vs-init Step 0.6 with migration option [1]
3. Verify appropriate handling

### Test Data

```
Test Directory: temp-large-xml/
File: docs/requirements.xml (> 1MB, containing many use cases)
```

### Expected Result

1. Large file size is detected
2. User is warned and offered options:
   - Proceed with full migration (may be slow)
   - Partial migration (first N elements)
   - Skip this file

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    LARGE FILE WARNING                                     ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  docs/requirements.xml is 1.5MB - this may take a while to migrate.       ║
║                                                                            ║
║  Options:                                                                  ║
║    [F] Full migration (may be slow)                                        ║
║    [P] Partial migration (first 100 elements)                              ║
║    [S] Skip this file                                                      ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.25: Edge Case - Binary Content in XML

### Description

Verify that vs-init handles XML files containing binary content (Base64 or CDATA).

### Test Steps

1. Create a test directory with XML containing binary/embedded content
2. Run vs-init Step 0.6 with migration option [1]
3. Verify binary content is preserved

### Test Data

```xml
<!-- docs/requirements.xml -->
<Requirements>
  <UseCases>
    <UC-001>
      <title>Diagram Use Case</title>
      <diagram>
        <![CDATA[
        Base64 encoded image data...
        iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJ...
        ]]>
      </diagram>
    </UC-001>
  </UseCases>
</Requirements>
```

### Expected Result

1. CDATA/Base64 content is detected
2. Content is preserved as-is in LegacyData section
3. Warning in migration report:
   ```
   ℹ Binary content preserved in LegacyData
   ```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.26: Constraints Extracted from requirements.xml

### Description

Verify that constraint elements are correctly extracted during migration.

### Test Steps

1. Create a test directory with `requirements.xml` containing constraints
2. Run vs-init Step 0.6 with migration option [1]
3. Verify constraints are extracted

### Test Data

```xml
<!-- docs/requirements.xml -->
<Requirements>
  <Constraints>
    <technical>
      <constraint id="TC-001">
        <title>Must use HTTPS</title>
        <description>All API calls must use HTTPS</description>
      </constraint>
    </technical>
    <business>
      <constraint id="BC-001">
        <title>GDPR Compliance</title>
        <description>Must comply with GDPR regulations</description>
      </constraint>
    </business>
  </Constraints>
</Requirements>
```

### Expected Result

Migration preview shows:
```
From requirements.xml:
  ✓ 1 technical constraints
  ✓ 1 business constraints
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.27: Glossary Terms Extracted from requirements.xml

### Description

Verify that glossary terms are correctly extracted during migration.

### Test Steps

1. Create a test directory with `requirements.xml` containing glossary
2. Run vs-init Step 0.6 with migration option [1]
3. Verify glossary terms are extracted

### Test Data

```xml
<!-- docs/requirements.xml -->
<Requirements>
  <Glossary>
    <term id="G-001">
      <word>API</word>
      <definition>Application Programming Interface</definition>
    </term>
    <term id="G-002">
      <word>GRACE</word>
      <definition>Graph-based Architecture for Context-Aware Execution</definition>
    </term>
  </Glossary>
</Requirements>
```

### Expected Result

Migration preview shows:
```
From requirements.xml:
  ✓ Glossary with 2 terms
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Case 2.28: Rollback Using Migration Report

### Description

Verify that rollback instructions in migration report work correctly.

### Test Steps

1. Create a test directory with existing XML files
2. Run vs-init with migration option [1]
3. Note the backup file paths from migration report
4. Execute rollback: copy backup files back to docs/
5. Verify original files are restored

### Test Data

```
Test Directory: temp-rollback-migration/
Original files:
  - docs/requirements.xml (with custom content)
  - docs/decisions.xml (with custom content)
```

### Expected Result

1. Rollback command from report works:
   ```bash
   cp docs/.backup/*.xml.YYYYMMDD-HHMMSS docs/
   ```
2. Original file contents are restored
3. Migrated files are replaced with originals

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the test directory

---

## Test Summary

| Test Case | Description | Status |
|-----------|-------------|--------|
| 2.1 | GRACE-Compatible requirements.xml Detected | [ ] Pass / [ ] Fail |
| 2.2 | GRACE-Compatible decisions.xml Detected | [ ] Pass / [ ] Fail |
| 2.3 | GRACE-Compatible development-plan.xml Detected | [ ] Pass / [ ] Fail |
| 2.4 | GRACE-Compatible knowledge-graph.xml Detected | [ ] Pass / [ ] Fail |
| 2.5 | Unknown XML Format Detected | [ ] Pass / [ ] Fail |
| 2.6 | Use Cases Extracted from requirements.xml | [ ] Pass / [ ] Fail |
| 2.7 | Decisions Extracted from decisions.xml | [ ] Pass / [ ] Fail |
| 2.8 | Modules Extracted from development-plan.xml | [ ] Pass / [ ] Fail |
| 2.9 | Data Flows Extracted from development-plan.xml | [ ] Pass / [ ] Fail |
| 2.10 | Nodes and Edges Extracted from knowledge-graph.xml | [ ] Pass / [ ] Fail |
| 2.11 | Unknown Elements Preserved in LegacyData | [ ] Pass / [ ] Fail |
| 2.12 | Backup Created Before Migration | [ ] Pass / [ ] Fail |
| 2.13 | Migration Report Generated Correctly | [ ] Pass / [ ] Fail |
| 2.14 | Migration Option 2 - Fresh Start | [ ] Pass / [ ] Fail |
| 2.15 | Migration Option 3 - Keep Existing | [ ] Pass / [ ] Fail |
| 2.16 | Edge Case - Malformed XML | [ ] Pass / [ ] Fail |
| 2.17 | Edge Case - Empty XML File | [ ] Pass / [ ] Fail |
| 2.18 | Edge Case - Duplicate IDs Across Files | [ ] Pass / [ ] Fail |
| 2.19 | Edge Case - Missing ID Attributes | [ ] Pass / [ ] Fail |
| 2.20 | Edge Case - Circular References in Graph | [ ] Pass / [ ] Fail |
| 2.21 | Edge Case - Orphaned Edges | [ ] Pass / [ ] Fail |
| 2.22 | Edge Case - External File References | [ ] Pass / [ ] Fail |
| 2.23 | Edge Case - Non-UTF-8 Encoding | [ ] Pass / [ ] Fail |
| 2.24 | Edge Case - Very Large XML File | [ ] Pass / [ ] Fail |
| 2.25 | Edge Case - Binary Content in XML | [ ] Pass / [ ] Fail |
| 2.26 | Constraints Extracted from requirements.xml | [ ] Pass / [ ] Fail |
| 2.27 | Glossary Terms Extracted from requirements.xml | [ ] Pass / [ ] Fail |
| 2.28 | Rollback Using Migration Report | [ ] Pass / [ ] Fail |

---

## Test Execution Log

| Date | Tester | Environment | Results | Notes |
|------|--------|-------------|---------|-------|
| | | | | |

---

## Related Documents

- [SKILL.md](../SKILL.md) - Implementation specification
- [vs-init-safety-improvements.md](../../../../plans/vs-init-safety-improvements.md) - Design specification
- [git-checkpoint.test.md](./git-checkpoint.test.md) - Git checkpoint tests
