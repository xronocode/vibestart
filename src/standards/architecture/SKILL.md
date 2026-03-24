---
name: architecture
description: "Layered architecture standard - module types, layer dependencies, and architectural constraints for maintainable code."
---

# Architecture Standard

Layered architecture for maintainable code.

## Purpose

Defines:
- Module types and their responsibilities
- Layer dependencies and constraints
- Architectural patterns
- Code organization rules

## Module Types

### Layer 0: Foundation

| Type | Description | Examples |
|------|-------------|----------|
| UTILITY | Pure functions, no state | formatters, validators, parsers |
| DATA_LAYER | Data persistence | database, cache, file storage |

### Layer 1: Core

| Type | Description | Examples |
|------|-------------|----------|
| CORE_LOGIC | Business rules | services, processors |
| DOMAIN | Domain models | entities, value objects |

### Layer 2: Integration

| Type | Description | Examples |
|------|-------------|----------|
| INTEGRATION | External services | API clients, third-party integrations |

### Layer 3: Interface

| Type | Description | Examples |
|------|-------------|----------|
| ENTRY_POINT | API routes, CLI | controllers, handlers |
| UI_COMPONENT | User interface | React components, views |

## Dependency Rules

### AR-001: Respect Layer Boundaries

**Severity:** MANDATORY

```
Layer 0 → No dependencies
Layer 1 → Layer 0 only
Layer 2 → Layer 0, 1
Layer 3 → Layer 0, 1, 2
```

**Valid:**
```
UserService (Layer 1) → Database (Layer 0) ✓
```

**Invalid:**
```
Database (Layer 0) → UserService (Layer 1) ✗
```

### AR-002: No Circular Dependencies

**Severity:** MANDATORY

Modules must not form circular dependency chains.

**Invalid:**
```
A → B → C → A ✗
```

### AR-003: Single Responsibility

**Severity:** RECOMMENDED

Each module should have one clear purpose.

### AR-004: Interface Segregation

**Severity:** RECOMMENDED

Prefer small, focused interfaces over large ones.

## Directory Structure

```
src/
├── config/           # Configuration (Layer 0)
├── database/         # Data layer (Layer 0)
├── modules/          # Feature modules
│   ├── auth/         # Auth module (Layer 1)
│   ├── user/         # User module (Layer 1)
│   └── task/         # Task module (Layer 1)
├── integrations/     # External services (Layer 2)
├── routes/           # API routes (Layer 3)
└── index.ts          # Entry point
```

## Module Structure

```
src/modules/{module}/
├── index.ts          # Public exports
├── contract.ts       # Interface/types
├── impl.ts           # Implementation
├── errors.ts         # Error definitions
└── {module}.test.ts  # Tests
```

## Patterns

### Repository Pattern

For data access:
```typescript
interface UserRepository {
  findById(id: string): Promise<User | null>;
  save(user: User): Promise<void>;
}
```

### Service Pattern

For business logic:
```typescript
interface UserService {
  getUser(id: string): Promise<User>;
  createUser(data: CreateUserDTO): Promise<User>;
}
```

### Factory Pattern

For complex object creation:
```typescript
interface UserFactory {
  create(data: CreateUserDTO): User;
}
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| God Object | Does too much | Split into focused modules |
| Spaghetti Code | Unclear flow | Use layered architecture |
| Copy-Paste | Duplication | Extract to shared module |
| Hardcoded Values | Inflexible | Use configuration |

## Quick Reference

| Layer | Types | Can Depend On |
|-------|-------|---------------|
| 0 | UTILITY, DATA_LAYER | None |
| 1 | CORE_LOGIC, DOMAIN | Layer 0 |
| 2 | INTEGRATION | Layer 0, 1 |
| 3 | ENTRY_POINT, UI_COMPONENT | All layers |
