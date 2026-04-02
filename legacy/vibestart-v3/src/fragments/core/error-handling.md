## Error Handling

<!-- Fragment: core/error-handling.md -->

All important logs must point back to semantic blocks:
```
logger.info(`[ModuleName][functionName][BLOCK_NAME] message`, {
  correlationId,
  stableField: value,
});
```

Rules:
- Prefer structured fields over prose-heavy log lines
- Redact secrets and high-risk payloads
- Treat missing log anchors on critical branches as a verification defect
- Update tests when log markers change intentionally

## Verification

All logs must point back to semantic blocks. Logs are evidence.
