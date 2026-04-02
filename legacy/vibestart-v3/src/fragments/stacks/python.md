## Python Stack

<!-- Fragment: stacks/python.md -->

## Project Structure

```
src/
├── __init__.py
├── main.py            # Entry point
├── modules/
│   └── {module}/
│       ├── __init__.py
│       ├── contract.py    # Protocols and types
│       └── impl.py        # Implementation
└── shared/
    └── __init__.py
```

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Modules | snake_case | `user_service.py` |
| Classes | PascalCase | `UserService` |
| Functions | snake_case | `get_user_by_id` |
| Constants | SCREAMING_SNAKE | `MAX_RETRIES` |
| Variables | snake_case | `user_count` |
| Private | _leading_underscore | `_internal_cache` |

## Type Hints

```python
from typing import Protocol, TypeAlias, Optional
from dataclasses import dataclass

# Use Protocol for interfaces
class UserService(Protocol):
    def get_user(self, id: str) -> User: ...
    def create_user(self, data: CreateUserDTO) -> User: ...

# Use TypeAlias for complex types
UserId: TypeAlias = str
JsonDict: TypeAlias = dict[str, Any]

# Use dataclasses for DTOs
@dataclass(frozen=True)
class User:
    id: UserId
    name: str
    email: str
```

## Dependency Management

Use `pyproject.toml` with `uv` or `poetry`:

```toml
[project]
name = "my-project"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = [
    "fastapi>=0.100.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "mypy>=1.0.0",
    "ruff>=0.1.0",
]
```

## Code Quality Tools

```bash
# Format
ruff format src/

# Lint
ruff check src/

# Type check
mypy src/

# Run all checks
ruff format --check src/ && ruff check src/ && mypy src/
```

## Module Pattern

```python
# contract.py - Public interface
from typing import Protocol

class UserService(Protocol):
    def get_user(self, id: str) -> User: ...

# impl.py - Implementation
from .contract import UserService

class UserServiceImpl:
    def get_user(self, id: str) -> User:
        # Implementation
        pass

# __init__.py - Public exports
from .contract import UserService
from .impl import UserServiceImpl

__all__ = ["UserService", "UserServiceImpl"]
```

## Verification

- Run `mypy src/` before commits
- All public functions must have type hints
- Use `ruff` for linting and formatting
