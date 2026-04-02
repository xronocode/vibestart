## TypeScript Stack

<!-- Fragment: stacks/typescript.md -->

## Project Structure

```
src/
├── index.ts          # Entry point
├── modules/          # Feature modules
│   └── {module}/
│       ├── index.ts
│       ├── contract.ts    # Types and interfaces
│       └── impl.ts        # Implementation
└── shared/           # Shared utilities
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | kebab-case | `user-service.ts` |
| Classes | PascalCase | `UserService` |
| Interfaces | PascalCase with I prefix (optional) | `IUser` or `User` |
| Functions | camelCase | `getUserById` |
| Constants | SCREAMING_SNAKE | `MAX_RETRIES` |
| Types | PascalCase | `UserResponse` |

## Type Safety Rules

1. **No `any`** — Use `unknown` with type guards instead
2. **Strict mode** — Always enable `strict: true` in tsconfig.json
3. **Explicit return types** — For public functions
4. **Const assertions** — Use `as const` for literal types

## Recommended tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  }
}
```

## Module Pattern

```typescript
// contract.ts - Public interface
export interface UserService {
  getUser(id: string): Promise<User>;
  createUser(data: CreateUserDTO): Promise<User>;
}

// impl.ts - Implementation
import type { UserService } from './contract.js';
export class UserServiceImpl implements UserService {
  // Implementation
}

// index.ts - Public exports
export type { UserService, User, CreateUserDTO } from './contract.js';
export { UserServiceImpl } from './impl.js';
```

## Verification

- Run `tsc --noEmit` before commits
- All public functions must have explicit return types
- No `@ts-ignore` without documented justification
