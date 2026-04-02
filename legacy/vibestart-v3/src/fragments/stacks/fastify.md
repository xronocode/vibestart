## Fastify Stack

<!-- Fragment: stacks/fastify.md -->

## Project Structure

```
src/
├── app.ts              # Fastify app factory
├── server.ts           # Server entry point
├── plugins/
│   ├── database.ts     # Database plugin
│   ├── auth.ts         # Authentication plugin
│   └── logging.ts      # Logging configuration
├── routes/
│   ├── index.ts        # Route registration
│   └── {module}.ts     # Module routes
├── schemas/
│   └── {module}.ts     # JSON schemas
├── services/
│   └── {module}.ts     # Business logic
└── types/
    └── {module}.ts     # TypeScript types
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Plugins | kebab-case | `rate-limit.ts` |
| Routes | kebab-case | `user-routes.ts` |
| Schemas | camelCase | `userSchemas.ts` |
| Services | PascalCase class | `UserService` |
| Hooks | camelCase | `onRequestAuth` |

## App Factory Pattern

```typescript
// app.ts
import Fastify, { FastifyInstance } from 'fastify';
import sensible from '@fastify/sensible';
import { userRoutes } from './routes/user.js';
import { databasePlugin } from './plugins/database.js';

export async function buildApp(): Promise<FastifyInstance> {
  const app = Fastify({
    logger: {
      level: process.env.LOG_LEVEL ?? 'info',
    },
  });

  // Register plugins
  await app.register(sensible);
  await app.register(databasePlugin);

  // Register routes
  await app.register(userRoutes, { prefix: '/api/users' });

  return app;
}
```

## Plugin Pattern

```typescript
// plugins/database.ts
import { FastifyPluginAsync } from 'fastify';
import { Pool } from 'pg';

declare module 'fastify' {
  interface FastifyInstance {
    db: Pool;
  }
}

export const databasePlugin: FastifyPluginAsync = async (fastify) => {
  const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
  });

  fastify.decorate('db', pool);

  fastify.addHook('onClose', async (instance) => {
    await instance.db.end();
  });
};
```

## Route with Schema

```typescript
// routes/user.ts
import { FastifyPluginAsync } from 'fastify';
import { userSchemas } from '../schemas/user.js';

export const userRoutes: FastifyPluginAsync = async (fastify) => {
  fastify.get('/:id', {
    schema: {
      params: userSchemas.getUserParams,
      response: {
        200: userSchemas.userResponse,
      },
    },
    preHandler: fastify.auth([fastify.verifyToken]),
  }, async (request, reply) => {
    const { id } = request.params;
    const user = await fastify.db.query('SELECT * FROM users WHERE id = $1', [id]);
    return user.rows[0];
  });
};
```

## Schema Definitions

```typescript
// schemas/user.ts
import { FromSchema } from 'json-schema-to-ts';

export const getUserParams = {
  type: 'object',
  required: ['id'],
  properties: {
    id: { type: 'string', format: 'uuid' },
  },
} as const;

export const userResponse = {
  type: 'object',
  properties: {
    id: { type: 'string' },
    name: { type: 'string' },
    email: { type: 'string', format: 'email' },
  },
} as const;

export type GetUserParams = FromSchema<typeof getUserParams>;
export type UserResponse = FromSchema<typeof userResponse>;
```

## Key Rules

1. **Encapsulation** — Use plugins for scoped functionality
2. **Schema validation** — All routes must have input/output schemas
3. **Hooks** — Use hooks for cross-cutting concerns (auth, logging)
4. **Error handling** — Use @fastify/sensible for HTTP errors

## Recommended Plugins

- `@fastify/sensible` — HTTP errors and utilities
- `@fastify/cors` — CORS support
- `@fastify/jwt` — JWT authentication
- `@fastify/rate-limit` — Rate limiting
- `@fastify/helmet` — Security headers

## Verification

- Run `tsc --noEmit` before commits
- All routes must have schema validation
- Use Fastify's built-in schema serialization
