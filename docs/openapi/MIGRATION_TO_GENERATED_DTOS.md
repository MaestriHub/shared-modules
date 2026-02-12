# Migration: Legacy DTOs -> Generated DTO Modules

Goal:
- Keep current clients/server working with legacy modules.
- Introduce generated DTOs from OpenAPI as the new contract-first path.

## Source of truth
- Contract source: `docs/openapi/split/*-3.2.yaml`
- Bundle for tooling/docs: `docs/openapi/dist/maetry-openapi-docs-3.2.yaml`

## New generated modules
- Swift: `modules/SwiftDTOs`
- Kotlin: `modules/KotlinDTOs`
- TypeScript: `modules/TypeScriptDTOs`

## Release flow
1. Update split YAML contract.
2. Run `npm run openapi:check`.
3. Run `npm run openapi:dto:generate`.
4. Publish new `Shared-Modules` version.
5. Upgrade consumers to that version.

## Consumer migration strategy
1. Keep legacy imports untouched at first.
2. Add generated module as additional dependency.
3. Start migrating feature-by-feature (endpoint by endpoint).
4. Use adapters/mappers where legacy model shapes differ.
5. Remove legacy DTO usage only after full parity and rollout.

## Compatibility notes
- Legacy modules to keep during migration:
  - `iOS-legacy/`
  - `android-legacy/`
  - root `Package.swift` for legacy Swift/Vapor integration
- Generator currently consumes OpenAPI 3.1 for codegen compatibility, while source contract remains 3.2 in split files.
