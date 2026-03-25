# Git Checkpoint Safety Tests

**Test Suite:** vs-init Git Checkpoint Feature  
**Version:** 1.0  
**Date:** 2026-03-25  
**Reference:** [SKILL.md](../SKILL.md) Steps 0.1-0.4, [vs-init-safety-improvements.md](../../../../plans/vs-init-safety-improvements.md)

---

## Overview

This test suite validates the Git checkpoint safety mechanism implemented in vs-init. The feature ensures users can rollback if initialization causes issues.

---

## Test Case 1.1: Git Repository Detected Correctly

### Description

Verify that vs-init correctly detects when the project is a Git repository.

### Test Steps

1. Create a temporary test directory
2. Initialize a Git repository with `git init`
3. Create a sample project structure with at least one file
4. Run vs-init Step 0.1: Check Git Status
5. Observe the detection output

### Test Data

```
Test Directory: temp-test-repo/
Files:
  - README.md (empty)
  - src/main.ts (minimal content)
```

### Expected Result

```
[SKILL:vs-init] Step 0.1: Checking git status...

Git status:
  • Repository: yes
  • Clean working directory: yes
  • Current branch: main (or master)
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory
2. Verify no residual files remain

---

## Test Case 1.2: Non-Git Directory Detected Correctly

### Description

Verify that vs-init correctly identifies when a project is NOT under Git version control.

### Test Steps

1. Create a temporary test directory WITHOUT `git init`
2. Create a sample project structure
3. Run vs-init Step 0.1: Check Git Status
4. Observe the detection output

### Test Data

```
Test Directory: temp-non-git-project/
Files:
  - package.json (minimal)
  - src/index.js (minimal)
```

### Expected Result

```
[SKILL:vs-init] Step 0.1: Checking git status...

Git status:
  • Repository: no
  • Clean working directory: N/A
  • Current branch: N/A
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.3: Dirty Repo Prompts User Action

### Description

Verify that vs-init detects uncommitted changes and prompts the user with appropriate options.

### Test Steps

1. Create a temporary Git repository
2. Make an initial commit
3. Modify a file WITHOUT committing
4. Run vs-init Step 0.2: Handle Git Repository State
5. Verify the prompt is displayed with all options

### Test Data

```
Test Directory: temp-dirty-repo/
Initial Commit:
  - README.md (content: "Initial")
Modification:
  - README.md (content: "Modified but not committed")
```

### Expected Result

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    UNCOMMITTED CHANGES DETECTED                           ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Your project has uncommitted changes that should be saved before          ║
║  vs-init modifies any files.                                               ║
║                                                                            ║
║  Changed files:                                                            ║
║    • README.md (modified)                                                  ║
║                                                                            ║
║  Options:                                                                  ║
║    [C] Commit changes now (RECOMMENDED)                                    ║
║    [S] Stash changes temporarily                                           ║
║    [A] Abort vs-init                                                       ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝

Your choice [C/S/A]:
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.4: Dirty Repo - Commit Option Works

### Description

Verify that selecting the Commit option correctly commits changes and proceeds.

### Test Steps

1. Create a temporary Git repository with uncommitted changes
2. Run vs-init Step 0.2
3. Select option [C] Commit changes now
4. Verify the commit is created
5. Verify vs-init proceeds to create safety tag

### Test Data

```
Test Directory: temp-commit-test/
Uncommitted files:
  - new-file.txt (new file)
  - modified-file.txt (modified)
```

### Expected Result

1. `git log` shows new commit with message "chore: pre-vs-init save"
2. `git status --porcelain` returns empty (clean state)
3. Safety tag is created after commit
4. vs-init proceeds to next step

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.5: Dirty Repo - Stash Option Works

### Description

Verify that selecting the Stash option correctly stashes changes and proceeds.

### Test Steps

1. Create a temporary Git repository with uncommitted changes
2. Run vs-init Step 0.2
3. Select option [S] Stash changes temporarily
4. Verify the stash is created
5. Verify working directory is clean
6. Verify vs-init proceeds to create safety tag

### Test Data

```
Test Directory: temp-stash-test/
Uncommitted files:
  - work-in-progress.ts (modified)
```

### Expected Result

1. `git stash list` shows new stash with message "pre-vs-init-backup"
2. `git status --porcelain` returns empty (clean state)
3. Safety tag is created after stash
4. vs-init proceeds to next step

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.6: Dirty Repo - Abort Option Works

### Description

Verify that selecting the Abort option correctly exits vs-init without making changes.

### Test Steps

1. Create a temporary Git repository with uncommitted changes
2. Run vs-init Step 0.2
3. Select option [A] Abort vs-init
4. Verify vs-init exits
5. Verify no files were modified

### Test Data

```
Test Directory: temp-abort-test/
Uncommitted files:
  - uncommitted.txt (new file)
```

### Expected Result

1. vs-init exits with appropriate message
2. No files are modified by vs-init
3. Uncommitted changes remain uncommitted
4. No safety tag is created

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.7: Clean Repo Creates Safety Tag

### Description

Verify that a clean Git repository results in a safety tag being created.

### Test Steps

1. Create a temporary Git repository
2. Make an initial commit
3. Ensure working directory is clean (`git status --porcelain` returns empty)
4. Run vs-init Step 0.2 and Step 0.3
5. Verify safety tag is created

### Test Data

```
Test Directory: temp-clean-repo/
Initial Commit:
  - README.md (content: "Test project")
  - src/index.ts (minimal content)
```

### Expected Result

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    CREATING SAFETY CHECKPOINT                             ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  ✓ Working directory is clean                                              ║
║                                                                            ║
║  Creating safety tag: vs-init-backup-YYYYMMDD-HHMMSS                       ║
║    → git tag -a vs-init-backup-YYYYMMDD-HHMMSS -m "vs-init checkpoint"    ║
║                                                                            ║
║  If something goes wrong, rollback with:                                   ║
║    git checkout vs-init-backup-YYYYMMDD-HHMMSS                             ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

1. `git tag -l "vs-init-backup-*"` shows the new tag
2. Tag message is "vs-init checkpoint"
3. vs-init proceeds to next step

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.8: No Git Offers Initialization Option

### Description

Verify that a non-Git project offers the option to initialize Git.

### Test Steps

1. Create a temporary directory WITHOUT Git
2. Create sample project files
3. Run vs-init Step 0.2
4. Verify the initialization prompt is displayed

### Test Data

```
Test Directory: temp-no-git/
Files:
  - package.json (minimal Node.js project)
  - src/index.js (minimal)
```

### Expected Result

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    NO GIT REPOSITORY DETECTED                             ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  This project is not under version control.                                ║
║                                                                            ║
║  ⚠️  WARNING: Without git, you cannot rollback if vs-init causes issues.  ║
║                                                                            ║
║  Strong recommendation: Initialize git first for safety.                   ║
║                                                                            ║
║  Options:                                                                  ║
║    [I] Initialize git with initial commit (RECOMMENDED)                    ║
║    [2] Continue without git safety net (NOT recommended)                   ║
║    [A] Abort vs-init                                                       ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝

Your choice [I/2/A]:
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.9: No Git - Initialize Option Works

### Description

Verify that selecting the Initialize option correctly sets up Git and proceeds.

### Test Steps

1. Create a temporary directory WITHOUT Git
2. Run vs-init Step 0.2
3. Select option [I] Initialize git with initial commit
4. Verify Git is initialized
5. Verify initial commit is created
6. Verify vs-init proceeds

### Test Data

```
Test Directory: temp-init-git/
Files:
  - project.config (minimal)
```

### Expected Result

1. `.git/` directory exists
2. `git log` shows commit with message "chore: initial commit before vs-init"
3. All existing files are tracked and committed
4. Safety tag is created after initialization
5. vs-init proceeds to next step

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.10: No Git - Continue Without Git Works

### Description

Verify that selecting the Continue option proceeds without Git safety net.

### Test Steps

1. Create a temporary directory WITHOUT Git
2. Run vs-init Step 0.2
3. Select option [2] Continue without git safety net
4. Verify vs-init proceeds with a warning
5. Verify no Git repository is created

### Test Data

```
Test Directory: temp-no-git-continue/
Files:
  - app.py (minimal Python file)
```

### Expected Result

1. Warning is logged about proceeding without safety net
2. No `.git/` directory is created
3. vs-init proceeds to Step 1 (Detect Environment)

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.11: Safety Tag Name Format Is Correct

### Description

Verify that safety tags follow the correct naming convention.

### Test Steps

1. Create a clean Git repository
2. Run vs-init to create safety tag
3. Verify tag name format matches specification

### Test Data

```
Tag Naming Convention: vs-init-backup-YYYYMMDD-HHMMSS
Example: vs-init-backup-20260325-172500
```

### Expected Result

1. Tag name matches regex pattern: `^vs-init-backup-\d{8}-\d{6}$`
2. Date portion (YYYYMMDD) represents current date
3. Time portion (HHMMSS) represents current time in 24-hour format

### Validation Commands

```bash
# List tags matching pattern
git tag -l "vs-init-backup-*"

# Verify tag format with regex
git tag -l "vs-init-backup-*" | grep -E '^vs-init-backup-[0-9]{8}-[0-9]{6}$'
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Delete the test tag: `git tag -d vs-init-backup-*`
2. Remove the temporary test directory

---

## Test Case 1.12: Edge Case - Detached HEAD State

### Description

Verify that vs-init handles detached HEAD state correctly.

### Test Steps

1. Create a Git repository with at least one commit
2. Checkout a specific commit by hash (detached HEAD): `git checkout <commit-hash>`
3. Run vs-init Step 0.1 and Step 0.2
4. Verify appropriate handling

### Test Data

```
Test Directory: temp-detached-head/
Commits:
  - Commit 1: Initial commit
  - Commit 2: Add feature
Action: git checkout <commit-1-hash>
```

### Expected Result

1. Detection: `git symbolic-ref -q HEAD` fails (indicates detached HEAD)
2. User is prompted to checkout a branch first
3. vs-init does not proceed until user is on a branch

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    DETACHED HEAD DETECTED                                 ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  You are in detached HEAD state.                                           ║
║                                                                            ║
║  vs-init requires you to be on a branch to create a safety checkpoint.    ║
║                                                                            ║
║  Options:                                                                  ║
║    [B] Checkout/create a branch                                            ║
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

1. Checkout main branch: `git checkout main`
2. Remove the temporary test directory

---

## Test Case 1.13: Edge Case - Merge Conflicts

### Description

Verify that vs-init detects and handles merge conflicts.

### Test Steps

1. Create a Git repository
2. Create a merge conflict scenario:
   - Create branch `feature`, make changes, commit
   - Switch to main, make conflicting changes, commit
   - Attempt merge: `git merge feature` (creates conflict)
3. Run vs-init Step 0.1 and Step 0.2
4. Verify appropriate handling

### Test Data

```
Test Directory: temp-merge-conflict/
Main branch file: README.md (content: "Version A")
Feature branch file: README.md (content: "Version B")
```

### Expected Result

1. Detection: `git ls-files -u` returns non-empty output
2. User is required to resolve conflicts before proceeding

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    MERGE CONFLICTS DETECTED                               ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Your repository has unresolved merge conflicts.                           ║
║                                                                            ║
║  Conflicted files:                                                         ║
║    • README.md                                                             ║
║                                                                            ║
║  You must resolve these conflicts before vs-init can proceed.              ║
║                                                                            ║
║  Options:                                                                  ║
║    [A] Abort vs-init (resolve conflicts manually first)                    ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Abort the merge: `git merge --abort`
2. Remove the temporary test directory

---

## Test Case 1.14: Edge Case - Submodule Directory

### Description

Verify that vs-init handles projects with Git submodules.

### Test Steps

1. Create a main Git repository
2. Add a submodule: `git submodule add <url> lib/submodule`
3. Commit the submodule addition
4. Run vs-init Step 0.1 and Step 0.2
5. Verify submodule is detected and handled correctly

### Test Data

```
Test Directory: temp-with-submodule/
Structure:
  - main-repo files
  - lib/submodule (Git submodule)
```

### Expected Result

1. Detection: `.git` file exists (not directory) in submodule folder
2. Submodule status is checked
3. Same Git safety rules apply to main repository
4. Safety tag is created on main repository

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Deinitialize submodule: `git submodule deinit -f lib/submodule`
2. Remove submodule directory and entry
3. Remove the temporary test directory

---

## Test Case 1.15: Edge Case - Bare Repository

### Description

Verify that vs-init correctly identifies and handles bare Git repositories.

### Test Steps

1. Create a bare Git repository: `git init --bare`
2. Run vs-init Step 0.1 and Step 0.2
3. Verify appropriate handling

### Test Data

```
Test Directory: temp-bare-repo.git/
Type: Bare repository (no working directory)
```

### Expected Result

1. Detection: `git rev-parse --is-bare-repository` returns "true"
2. vs-init skips or aborts with appropriate message (bare repos have no working directory)

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    BARE REPOSITORY DETECTED                               ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  This is a bare Git repository with no working directory.                  ║
║                                                                            ║
║  vs-init is not applicable to bare repositories.                           ║
║                                                                            ║
║  Aborting vs-init.                                                         ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary bare repository

---

## Test Case 1.16: Edge Case - Tag Creation Fails

### Description

Verify that vs-init handles tag creation failure gracefully.

### Test Steps

1. Create a Git repository
2. Simulate tag creation failure (e.g., invalid characters in tag name, permissions issue)
3. Run vs-init Step 0.3
4. Verify graceful handling

### Test Data

```
Test Directory: temp-tag-fail/
Scenario: Tag creation command returns non-zero exit code
```

### Expected Result

1. Warning is displayed about tag creation failure
2. vs-init proceeds without tag (with warning logged)
3. User is informed about lack of safety checkpoint

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                    WARNING: TAG CREATION FAILED                           ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║  Could not create safety tag.                                              ║
║                                                                            ║
║  Proceeding without safety checkpoint.                                     ║
║  Consider manually creating a backup before continuing.                    ║
║                                                                            ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Remove the temporary test directory

---

## Test Case 1.17: Edge Case - Staged But Uncommitted Changes

### Description

Verify that vs-init detects staged but uncommitted changes.

### Test Steps

1. Create a Git repository with initial commit
2. Modify a file and stage it: `git add <file>`
3. Do NOT commit
4. Run vs-init Step 0.1 and Step 0.2
5. Verify staged changes are included in dirty state detection

### Test Data

```
Test Directory: temp-staged-changes/
Initial Commit: README.md
Staged Change: README.md (modified and staged with git add)
```

### Expected Result

1. Detection: `git diff --cached` returns non-empty output
2. Staged changes are included in uncommitted changes prompt
3. File is listed as "staged" in the prompt

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Unstage changes: `git reset HEAD`
2. Remove the temporary test directory

---

## Test Case 1.18: Rollback Using Safety Tag Works

### Description

Verify that the safety tag can be used to rollback changes made by vs-init.

### Test Steps

1. Create a clean Git repository
2. Run vs-init to create safety tag
3. Make note of the tag name
4. Simulate vs-init making changes (create/modify files)
5. Execute rollback: `git checkout vs-init-backup-YYYYMMDD-HHMMSS`
6. Verify files are restored to pre-init state

### Test Data

```
Test Directory: temp-rollback-test/
Pre-init state: README.md only
Post-init state: README.md, AGENTS.md, vs.project.toml, docs/
```

### Expected Result

1. Rollback command executes successfully
2. All files created by vs-init are removed
3. All files modified by vs-init are restored
4. Working directory matches pre-init state

### Validation Commands

```bash
# Verify rollback
git checkout vs-init-backup-*

# Check file list matches original
ls -la

# Verify file contents
cat README.md
```

### Actual Result

| Run | Status | Notes |
|-----|--------|-------|
| 1 | [ ] Pass / [ ] Fail | |
| 2 | [ ] Pass / [ ] Fail | |

### Cleanup Steps

1. Checkout main branch
2. Delete safety tag
3. Remove the temporary test directory

---

## Test Summary

| Test Case | Description | Status |
|-----------|-------------|--------|
| 1.1 | Git Repository Detected Correctly | [ ] Pass / [ ] Fail |
| 1.2 | Non-Git Directory Detected Correctly | [ ] Pass / [ ] Fail |
| 1.3 | Dirty Repo Prompts User Action | [ ] Pass / [ ] Fail |
| 1.4 | Dirty Repo - Commit Option Works | [ ] Pass / [ ] Fail |
| 1.5 | Dirty Repo - Stash Option Works | [ ] Pass / [ ] Fail |
| 1.6 | Dirty Repo - Abort Option Works | [ ] Pass / [ ] Fail |
| 1.7 | Clean Repo Creates Safety Tag | [ ] Pass / [ ] Fail |
| 1.8 | No Git Offers Initialization Option | [ ] Pass / [ ] Fail |
| 1.9 | No Git - Initialize Option Works | [ ] Pass / [ ] Fail |
| 1.10 | No Git - Continue Without Git Works | [ ] Pass / [ ] Fail |
| 1.11 | Safety Tag Name Format Is Correct | [ ] Pass / [ ] Fail |
| 1.12 | Edge Case - Detached HEAD State | [ ] Pass / [ ] Fail |
| 1.13 | Edge Case - Merge Conflicts | [ ] Pass / [ ] Fail |
| 1.14 | Edge Case - Submodule Directory | [ ] Pass / [ ] Fail |
| 1.15 | Edge Case - Bare Repository | [ ] Pass / [ ] Fail |
| 1.16 | Edge Case - Tag Creation Fails | [ ] Pass / [ ] Fail |
| 1.17 | Edge Case - Staged But Uncommitted | [ ] Pass / [ ] Fail |
| 1.18 | Rollback Using Safety Tag Works | [ ] Pass / [ ] Fail |

---

## Test Execution Log

| Date | Tester | Environment | Results | Notes |
|------|--------|-------------|---------|-------|
| | | | | |

---

## Related Documents

- [SKILL.md](../SKILL.md) - Implementation specification
- [vs-init-safety-improvements.md](../../../../plans/vs-init-safety-improvements.md) - Design specification
- [xml-migration.test.md](./xml-migration.test.md) - XML migration tests
