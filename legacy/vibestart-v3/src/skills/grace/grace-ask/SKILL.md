---
name: grace-ask
description: "Answer a question about a GRACE project using full project context. Use when the user has a question about the codebase, architecture, modules, or implementation — loads all GRACE artifacts, navigates the knowledge graph, and provides a grounded answer with citations."
---

# grace-ask Skill

Answer questions about a GRACE project.

## Purpose

When you need to understand something about the project, grace-ask:
1. Loads all GRACE artifacts
2. Navigates the knowledge graph
3. Searches codebase for context
4. Provides grounded answer with citations

## Execution Flow

```
[SKILL:grace-ask] Loading project context...
```

---

## Step 1: Load Artifacts

```
[SKILL:grace-ask] Step 1/4: Loading artifacts...
[STANDARD:grace] Reading docs/ directory...
```

### Artifacts Loaded

```
Loaded:
  ✓ docs/requirements.xml — 5 use cases, 2 decisions
  ✓ docs/technology.xml — Stack: TypeScript, Node, Fastify
  ✓ docs/development-plan.xml — 15 modules across 4 phases
  ✓ docs/knowledge-graph.xml — 15 nodes, 12 edges
  ✓ docs/verification-plan.xml — 15 verification entries
  ✓ docs/decisions.xml — 3 architectural decisions
```

---

## Step 2: Parse Question

```
[SKILL:grace-ask] Step 2/4: Parsing question...
```

### Question Types

| Type | Example | Navigation |
|------|---------|------------|
| Architecture | "How is auth implemented?" | Graph traversal |
| Dependency | "What does UserService depend on?" | Edge lookup |
| Contract | "What does getById return?" | Module contract |
| Flow | "How does request flow?" | Edge chain |
| Status | "What's left to implement?" | Module status |
| Decision | "Why did we choose Fastify?" | Decisions.xml |

---

## Step 3: Navigate and Search

```
[SKILL:grace-ask] Step 3/4: Navigating context...
```

### Navigation Methods

1. **Graph traversal** — Follow edges in knowledge graph
2. **Contract lookup** — Find module in development plan
3. **Code search** — Find implementation details
4. **Decision lookup** — Find rationale in decisions.xml

### Example: "How is auth implemented?"

```
[STANDARD:grace] Searching knowledge graph...
  Found: M-Auth (CORE_LOGIC, Layer 1)

[STANDARD:grace] Looking up contract...
  Module: M-Auth
  Contract: Authentication and authorization
  Dependencies: M-Database, M-Logger, M-Cache

[STANDARD:grace] Tracing dependencies...
  M-Auth → M-Database (user lookup)
  M-Auth → M-Cache (session storage)
  M-Auth → M-Logger (audit logging)

[TOOL:filesystem] Reading src/modules/auth/contract.ts...
  Found: AuthService interface
  Methods: validateToken, createSession, revokeSession
```

---

## Step 4: Generate Answer

```
[SKILL:grace-ask] Step 4/4: Generating answer...
```

### Answer Format

```
╔═══════════════════════════════════════════════════════════════════════╗
║                          GRACE ASK RESPONSE                            ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  Question: How is auth implemented?                                    ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Answer:                                                               ║
║                                                                        ║
║  Authentication is handled by M-Auth module (CORE_LOGIC, Layer 1).     ║
║                                                                        ║
║  Architecture:                                                         ║
║    • Entry: Token validation via middleware                            ║
║    • Core: AuthService with 3 main methods                             ║
║    • Storage: Sessions cached in M-Cache                               ║
║    • Persistence: User data in M-Database                              ║
║                                                                        ║
║  Flow:                                                                 ║
║    1. Request → Middleware extracts token                              ║
║    2. AuthService.validateToken() verifies JWT                         ║
║    3. M-Cache checks session cache                                     ║
║    4. M-Database fetches user if cache miss                            ║
║    5. Request continues with user context                              ║
║                                                                        ║
║  ──────────────────────────────────────────────────────────────────── ║
║                                                                        ║
║  Sources:                                                              ║
║    • [1] docs/development-plan.xml#M-Auth                              ║
║    • [2] docs/knowledge-graph.xml#M-Auth-edges                         ║
║    • [3] src/modules/auth/contract.ts                                  ║
║    • [4] docs/decisions.xml#DEC-001                                    ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Common Questions

### Architecture Questions

```
Q: "What's the overall architecture?"
→ Traverses graph from ENTRY_POINT to DATA_LAYER

Q: "How do modules communicate?"
→ Analyzes edges and cross-links
```

### Dependency Questions

```
Q: "What does M-Auth depend on?"
→ Edge lookup: M-Auth → [M-Database, M-Cache, M-Logger]

Q: "What depends on M-Database?"
→ Reverse edge lookup: [M-Auth, M-User, M-Task] → M-Database
```

### Contract Questions

```
Q: "What does UserService.getById return?"
→ Contract lookup in development-plan.xml

Q: "What errors can createTask throw?"
→ Contract error section in development-plan.xml
```

### Status Questions

```
Q: "What's left to implement?"
→ Filter modules by STATUS != "done"

Q: "What's blocking Phase 2?"
→ Check Phase 1 gate status
```

---

## Usage

```bash
# Interactive question
/grace-ask

# With question
/grace-ask "How does authentication work?"

# Focus on specific area
/grace-ask --module=M-Auth "What are the dependencies?"

# List all modules
/grace-ask "List all modules and their status"
```

---

## Tips

1. **Be specific** — "How does auth validate tokens?" vs "Tell me about auth"
2. **Use module names** — Reference M-XXX when known
3. **Ask follow-ups** — Dig deeper into specific areas
4. **Request sources** — Get citations for verification
