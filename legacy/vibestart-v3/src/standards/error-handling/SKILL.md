---
name: error-handling
description: "Error handling standard - structured errors, logging conventions, and error propagation patterns."
---

# Error Handling Standard

Structured error handling for reliability.

## Purpose

Defines:
- Error types and codes
- Logging conventions
- Error propagation patterns
- Recovery strategies

## Error Types

### Application Errors

Controlled errors that are part of business logic:

```typescript
class AppError extends Error {
  constructor(
    message: string,
    public code: string,
    public statusCode: number = 500,
    public details?: Record<string, unknown>
  ) {
    super(message);
    this.name = 'AppError';
  }
}
```

### Validation Errors

Input validation failures:

```typescript
class ValidationError extends AppError {
  constructor(message: string, details?: Record<string, unknown>) {
    super(message, 'VALIDATION_ERROR', 400, details);
    this.name = 'ValidationError';
  }
}
```

### Not Found Errors

Resource not found:

```typescript
class NotFoundError extends AppError {
  constructor(resource: string, id: string) {
    super(`${resource} not found: ${id}`, 'NOT_FOUND', 404);
    this.name = 'NotFoundError';
  }
}
```

### Authorization Errors

Permission denied:

```typescript
class AuthorizationError extends AppError {
  constructor(message: string = 'Unauthorized') {
    super(message, 'UNAUTHORIZED', 401);
    this.name = 'AuthorizationError';
  }
}
```

## Error Codes

### EH-001: Use Structured Error Codes

**Severity:** MANDATORY

Error codes follow pattern: `CATEGORY_SPECIFIC`

| Category | Prefix | Examples |
|----------|--------|----------|
| Validation | `VAL_` | VAL_INVALID_INPUT, VAL_MISSING_FIELD |
| Authentication | `AUTH_` | AUTH_INVALID_TOKEN, AUTH_EXPIRED |
| Authorization | `AUTHZ_` | AUTHZ_FORBIDDEN, AUTHZ_INSUFFICIENT |
| Database | `DB_` | DB_CONNECTION, DB_QUERY_FAILED |
| External | `EXT_` | EXT_API_ERROR, EXT_TIMEOUT |
| Internal | `INT_` | INT_CONFIG, INT_UNEXPECTED |

## Logging

### EH-002: Log with Context

**Severity:** MANDATORY

All error logs must include:
- Error code
- Semantic block
- Correlation ID
- Relevant context

```typescript
logger.error('[Module][function][BLOCK_ERROR] message', {
  errorCode: 'VAL_INVALID_INPUT',
  correlationId,
  field: 'email',
  value: '[REDACTED]',
});
```

### EH-003: Never Log Secrets

**Severity:** MANDATORY

Redact sensitive data:
- Passwords
- Tokens
- API keys
- Personal data

```typescript
// Bad
logger.error('Login failed', { password: userInput });

// Good
logger.error('Login failed', { password: '[REDACTED]' });
```

## Error Propagation

### EH-004: Propagate with Context

**Severity:** MANDATORY**

When re-throwing errors, preserve context:

```typescript
try {
  await this.db.query(sql);
} catch (error) {
  throw new AppError(
    'Failed to fetch user',
    'DB_QUERY_FAILED',
    500,
    { originalError: error.message, query: '[REDACTED]' }
  );
}
```

### EH-005: Handle at Boundaries

**Severity:** MANDATORY

Handle errors at module boundaries, not internally:

```typescript
// In route handler (Layer 3)
app.get('/users/:id', async (request, reply) => {
  try {
    const user = await userService.getById(request.params.id);
    return user;
  } catch (error) {
    if (error instanceof NotFoundError) {
      return reply.status(404).send({ error: error.code });
    }
    throw error; // Let error handler deal with it
  }
});
```

## Recovery Strategies

### Retry Pattern

For transient errors:

```typescript
async function withRetry<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3,
  delay: number = 1000
): Promise<T> {
  let lastError: Error;
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;
      if (i < maxRetries - 1) {
        await sleep(delay * Math.pow(2, i));
      }
    }
  }
  throw lastError;
}
```

### Circuit Breaker

For external services:

```typescript
class CircuitBreaker {
  private failures = 0;
  private state: 'CLOSED' | 'OPEN' | 'HALF_OPEN' = 'CLOSED';
  
  async execute<T>(fn: () => Promise<T>): Promise<T> {
    if (this.state === 'OPEN') {
      throw new AppError('Circuit breaker open', 'EXT_CIRCUIT_OPEN');
    }
    try {
      const result = await fn();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }
}
```

## Quick Reference

| Error Type | Code | Status |
|------------|------|--------|
| Validation | VAL_* | 400 |
| Unauthorized | AUTH_* | 401 |
| Forbidden | AUTHZ_* | 403 |
| Not Found | NOT_FOUND | 404 |
| Conflict | CONFLICT | 409 |
| Internal | INT_* | 500 |
| External | EXT_* | 502/503 |
