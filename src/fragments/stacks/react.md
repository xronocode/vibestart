## React Stack

<!-- Fragment: stacks/react.md -->

## Project Structure

```
src/
├── App.tsx
├── main.tsx
├── components/
│   ├── ui/              # Generic UI components
│   └── features/        # Feature-specific components
├── hooks/               # Custom hooks
├── pages/               # Page components (if using routing)
├── services/            # API services
├── stores/              # State management
├── types/               # TypeScript types
└── utils/               # Utility functions
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Components | PascalCase | `UserProfile.tsx` |
| Hooks | camelCase with use prefix | `useUserData.ts` |
| Utils | camelCase | `formatDate.ts` |
| Types | PascalCase | `UserResponse.ts` |
| Constants | SCREAMING_SNAKE | `API_ENDPOINTS.ts` |

## Component Pattern

```typescript
// Component file: UserProfile.tsx
import { FC, memo } from 'react';

interface UserProfileProps {
  userId: string;
  onEdit?: () => void;
}

export const UserProfile: FC<UserProfileProps> = memo(({ userId, onEdit }) => {
  // Component implementation
  return (
    <div>
      {/* JSX */}
    </div>
  );
});

UserProfile.displayName = 'UserProfile';
```

## Custom Hook Pattern

```typescript
// Hook file: useUserData.ts
import { useState, useEffect } from 'react';
import type { User } from '../types';

export function useUserData(userId: string) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    // Fetch logic
  }, [userId]);

  return { user, loading, error };
}
```

## State Management

- **Local state** — `useState` for component-specific state
- **Context** — `useContext` for shared state within a feature
- **External stores** — Zustand, Jotai, or Redux for global state

## Styling Approach

Choose one and be consistent:
- **Tailwind CSS** — Utility-first
- **CSS Modules** — Scoped styles
- **Styled Components** — CSS-in-JS

## Key Rules

1. **Memoization** — Use `memo`, `useMemo`, `useCallback` appropriately
2. **Key props** — Never use array index as key for dynamic lists
3. **Effects** — Keep effects focused, avoid effect chains
4. **Props** — Destructure in function signature

## Verification

- Run `tsc --noEmit` before commits
- Use React DevTools Profiler for performance checks
- All components must have explicit prop types
