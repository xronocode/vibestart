## Node.js Stack

<!-- Fragment: stacks/node.md -->

## Project Structure

```
src/
├── index.ts            # Entry point
├── server.ts           # Server setup
├── routes/
│   ├── index.ts        # Route aggregator
│   └── {module}.ts     # Module routes
├── services/
│   └── {module}.ts     # Business logic
├── middleware/
│   └── {middleware}.ts # Express/Fastify middleware
├── schemas/
│   └── {module}.ts     # Request/response schemas
└── utils/
    └── {util}.ts       # Utilities
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | kebab-case | `user-routes.ts` |
| Classes | PascalCase | `UserService` |
| Functions | camelCase | `handleGetUser` |
| Constants | SCREAMING_SNAKE | `HTTP_STATUS` |
| Environment | SCREAMING_SNAKE | `DATABASE_URL` |

## Server Pattern

```typescript
// server.ts
import Fastify from 'fastify';
import { userRoutes } from './routes/user.js';

const server = Fastify({
  logger: true,
});

// Register routes
server.register(userRoutes, { prefix: '/users' });

// Start server
const start = async () => {
  try {
    await server.listen({ port: 3000 });
  } catch (err) {
    server.log.error(err);
    process.exit(1);
  }
};

start();
```

## Route Handler Pattern

```typescript
// routes/user.ts
import { FastifyPluginAsync } from 'fastify';
import { getUserSchema, createUserSchema } from '../schemas/user.js';

export const userRoutes: FastifyPluginAsync = async (fastify) => {
  fastify.get('/:id', {
    schema: getUserSchema,
    handler: async (request, reply) => {
      const { id } = request.params as { id: string };
      // Handler logic
      return { user: { id } };
    },
  });
};
```

## Error Handling

```typescript
// Custom error class
class AppError extends Error {
  constructor(
    public message: string,
    public statusCode: number = 500,
    public code: string = 'INTERNAL_ERROR'
  ) {
    super(message);
  }
}

// Error handler middleware
server.setErrorHandler((error, request, reply) => {
  if (error instanceof AppError) {
    return reply.status(error.statusCode).send({
      error: error.code,
      message: error.message,
    });
  }
  // Handle unexpected errors
  return reply.status(500).send({ error: 'INTERNAL_ERROR' });
});
```

## Environment Configuration

```typescript
// config.ts
import { z } from 'zod';

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'production', 'test']),
  PORT: z.string().transform(Number).default('3000'),
  DATABASE_URL: z.string(),
});

export const config = envSchema.parse(process.env);
```

## Key Rules

1. **Async/await** — Always use async/await, never raw Promises
2. **Validation** — Validate all inputs with schemas
3. **Logging** — Use structured logging with correlation IDs
4. **Graceful shutdown** — Handle SIGTERM/SIGINT properly

## Verification

- Run `tsc --noEmit` before commits
- All endpoints must have schema validation
- Use `node --import=tsx` for TypeScript execution
