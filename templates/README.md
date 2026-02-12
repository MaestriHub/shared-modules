# OpenAPI Generator Templates

This directory contains optional custom templates for `openapi-generator`.

If a generator-specific directory exists, `scripts/generate_dtos.sh` passes it via `-t`:
- `templates/swift6`
- `templates/kotlin`
- `templates/typescript-fetch`

Behavior:
- If a custom template file exists, it overrides the built-in one.
- If a file is missing, `openapi-generator` falls back to its built-in template.

Tip:
Start by copying only the template files you really need to customize.
