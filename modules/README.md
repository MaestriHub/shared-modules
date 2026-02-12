# Generated DTO Modules

This directory contains the new generated DTO modules built from OpenAPI source of truth:
- `docs/openapi/split/*-3.2.yaml`

Modules:
- `SwiftDTOs` - generated Swift DTOs for iOS and Vapor.
- `KotlinDTOs` - generated Kotlin DTOs for Android.
- `TypeScriptDTOs` - generated TypeScript DTOs for React/Next.js.

Generation command:
- `npm run openapi:dto:generate`

Legacy clients remain in:
- `iOS-legacy` (legacy iOS/Vapor DTOs)
- `android-legacy` (legacy Android DTOs)
