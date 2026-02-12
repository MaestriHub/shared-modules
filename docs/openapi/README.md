# OpenAPI Contract Workflow (v3.2 YAML)

Workflow:
AI / Manual edits ← Redoc (preview)
      ↓
   OpenAPI (Git)  ← SOURCE OF TRUTH
      ↓
   Spectral (lint)
      ↓
   Stoplight (optional edit UI)
      ↓
   Merge
      ↓
   CI Generate SDK

Source of truth:
- `docs/openapi/split/*-3.2.yaml`

Derived artifact:
- `docs/openapi/dist/maetry-openapi-docs-3.2.yaml` (bundle for docs and code generation)
- Bundle is emitted with `openapi: 3.1.0` for better viewer compatibility.

Primary workflow:
1. Update contract in split YAML files.
2. Run `make openapi-check`.
3. Run `make openapi-dto-generate`.
4. Commit contract + generated DTOs in `modules/*DTOs` and release new Shared-Modules version.

Commands:
- `make install` - install tooling dependencies.
- `make openapi-lint` - lint split source files.
- `make openapi-bundle-docs` - rebuild docs bundle from split source.
- `make openapi-redocly-lint` - lint bundled docs spec with Redocly.
- `make openapi-docs-preview` - open local Redocly viewer at `http://localhost:18080` (default).
- `make openapi-docs-build` - build static HTML docs to `docs/openapi/dist/maetry-openapi-docs-3.2.html`.
- `make openapi-diff OLD=... NEW=...` - full diff between two specs (supports YAML).
- `make openapi-diff-summary OLD=... NEW=...` - compact diff summary.
- `make openapi-semver-plan OLD=... NEW=... [NO_CHANGE=none|patch]` - compute recommended bump (`major`/`minor`/`none|patch`).
- `make openapi-semver-bump OLD=... NEW=... [NO_CHANGE=none|patch]` - apply recommended bump to `modules/sdk-versions.json`.
- `make openapi-dto-generate` - generate DTOs for iOS/Android/TypeScript from bundled spec.
- `make openapi-check` - lint + bundle.
- `make openapi-release-prepare` - lint + bundle + DTO generation.
- `npm run openapi:lint` - lint split source files.
- `npm run openapi:bundle:docs` - rebuild docs bundle from split source.
- `npm run openapi:redocly:lint` - lint bundled docs spec with Redocly.
- `npm run openapi:docs:preview` - open local Redocly viewer at `http://localhost:18080` (default).
- You can override preview port: `OPENAPI_DOCS_PORT=8081 make openapi-docs-preview`.
- `npm run openapi:docs:build` - build static HTML docs to `docs/openapi/dist/maetry-openapi-docs-3.2.html`.
- `npm run openapi:diff -- <oldSpec> <newSpec>` - full diff between two specs.
- `npm run openapi:diff:summary -- <oldSpec> <newSpec>` - compact diff summary.
- `npm run openapi:semver:plan -- --old <oldSpec> --new <newSpec>` - compute recommended bump from OpenAPI diff.
- `npm run openapi:semver:bump -- --old <oldSpec> --new <newSpec>` - apply bump to `modules/sdk-versions.json`.
- `npm run openapi:rebuild` - alias to `openapi:bundle:docs`.
- `npm run openapi:dto:generate` - generate DTOs for iOS/Android/TypeScript from bundled spec.
- `npm run openapi:release:prepare` - lint + bundle + DTO generation.

Generated DTO module targets:
- `modules/SwiftDTOs/Sources/MaetryGeneratedDTOs/Models`
- `modules/KotlinDTOs/src/main/kotlin/com/maetry/generated/models`
- `modules/TypeScriptDTOs/src/models`

Optional custom templates:
- `templates/swift6`
- `templates/kotlin`
- `templates/typescript-fetch`

`scripts/generate_dtos.sh` uses these directories automatically (via `-t`) when they exist.
Missing template files fall back to the built-in `openapi-generator` templates.

SDK version source of truth:
- `modules/sdk-versions.json`
- Bump policy from diff:
  - `major` if any breaking changes are detected.
  - `minor` if changes exist and none are breaking.
  - `none` if no changes are detected (default).
  - You can force `patch` on no changes with `--no-change patch` (or `NO_CHANGE=patch` in Makefile).
