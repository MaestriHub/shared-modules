#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SHARED_MODULES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SPEC_PATH="$SHARED_MODULES_DIR/docs/openapi/dist/maetry-openapi-docs-3.2.yaml"
MODULES_DIR="$SHARED_MODULES_DIR/modules"
SWIFT_OUT_DIR="$MODULES_DIR/SwiftDTOs/Sources/MaetryGeneratedDTOs/Models"
KOTLIN_OUT_DIR="$MODULES_DIR/KotlinDTOs/src/main/kotlin/com/maetry/generated/models"
TS_OUT_DIR="$MODULES_DIR/TypeScriptDTOs/src/models"
TEMPLATES_DIR="$SHARED_MODULES_DIR/templates"
SWIFT_TEMPLATE_DIR="$TEMPLATES_DIR/swift6"
KOTLIN_TEMPLATE_DIR="$TEMPLATES_DIR/kotlin"
TS_TEMPLATE_DIR="$TEMPLATES_DIR/typescript-fetch"

if [[ ! -f "$SPEC_PATH" ]]; then
  echo "Bundled OpenAPI spec not found. Building from split specs..."
  node "$SHARED_MODULES_DIR/scripts/bundle_openapi_for_docs.mjs"
fi

if [[ ! -f "$SPEC_PATH" ]]; then
  echo "Spec file not found: $SPEC_PATH" >&2
  exit 1
fi

if ! command -v openapi-generator >/dev/null 2>&1; then
  if command -v openapi-generator-cli >/dev/null 2>&1; then
    OPENAPI_GENERATOR_BIN="openapi-generator-cli"
  else
    echo "openapi-generator or openapi-generator-cli is required" >&2
    exit 1
  fi
else
  OPENAPI_GENERATOR_BIN="openapi-generator"
fi

if [[ -z "${JAVA_HOME:-}" ]]; then
  if command -v /usr/libexec/java_home >/dev/null 2>&1; then
    export JAVA_HOME="$(/usr/libexec/java_home -v 25 2>/dev/null || /usr/libexec/java_home 2>/dev/null || true)"
  fi
fi

if [[ -n "${JAVA_HOME:-}" ]]; then
  export PATH="$JAVA_HOME/bin:$PATH"
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/maetry-openapi-gen.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT

SPEC_FOR_GENERATION="$TMP_DIR/maetry-openapi-for-codegen.yaml"
ruby -ryaml -e '
  doc = YAML.safe_load(File.read(ARGV[0]), aliases: true)
  doc["openapi"] = "3.1.0"
  File.write(ARGV[1], YAML.dump(doc))
' "$SPEC_PATH" "$SPEC_FOR_GENERATION"

mkdir -p "$SWIFT_OUT_DIR" "$KOTLIN_OUT_DIR" "$TS_OUT_DIR"
find "$SWIFT_OUT_DIR" -type f -name '*.swift' -delete
find "$KOTLIN_OUT_DIR" -type f -name '*.kt' -delete
find "$TS_OUT_DIR" -type f -name '*.ts' -delete

SWIFT_TEMPLATE_ARGS=()
KOTLIN_TEMPLATE_ARGS=()
TS_TEMPLATE_ARGS=()

if [[ -d "$SWIFT_TEMPLATE_DIR" ]]; then
  SWIFT_TEMPLATE_ARGS=(-t "$SWIFT_TEMPLATE_DIR")
fi

if [[ -d "$KOTLIN_TEMPLATE_DIR" ]]; then
  KOTLIN_TEMPLATE_ARGS=(-t "$KOTLIN_TEMPLATE_DIR")
fi

if [[ -d "$TS_TEMPLATE_DIR" ]]; then
  TS_TEMPLATE_ARGS=(-t "$TS_TEMPLATE_DIR")
fi

IOS_TMP_OUT="$TMP_DIR/ios"
"$OPENAPI_GENERATOR_BIN" generate \
  -i "$SPEC_FOR_GENERATION" \
  -g swift6 \
  -o "$IOS_TMP_OUT" \
  "${SWIFT_TEMPLATE_ARGS[@]}" \
  --global-property models,modelDocs=false,modelTests=false,apis=false,supportingFiles=false

if [[ -d "$IOS_TMP_OUT/Sources/OpenAPIClient/Models" ]]; then
  cp -R "$IOS_TMP_OUT/Sources/OpenAPIClient/Models/." "$SWIFT_OUT_DIR/"
fi

ANDROID_TMP_OUT="$TMP_DIR/android"
"$OPENAPI_GENERATOR_BIN" generate \
  -i "$SPEC_FOR_GENERATION" \
  -g kotlin \
  -o "$ANDROID_TMP_OUT" \
  "${KOTLIN_TEMPLATE_ARGS[@]}" \
  --global-property models,modelDocs=false,modelTests=false,apis=false,supportingFiles=false \
  -p packageName=com.maetry.generated,serializationLibrary=moshi,dateLibrary=java8

if [[ -d "$ANDROID_TMP_OUT/src/main/kotlin/com/maetry/generated/models" ]]; then
  cp -R "$ANDROID_TMP_OUT/src/main/kotlin/com/maetry/generated/models/." "$KOTLIN_OUT_DIR/"
fi

TS_TMP_OUT="$TMP_DIR/typescript"
"$OPENAPI_GENERATOR_BIN" generate \
  -i "$SPEC_FOR_GENERATION" \
  -g typescript-fetch \
  -o "$TS_TMP_OUT" \
  "${TS_TEMPLATE_ARGS[@]}" \
  --global-property models,modelDocs=false,modelTests=false,apis=false,supportingFiles=false \
  -p supportsES6=true,withInterfaces=true,enumPropertyNaming=original

if [[ -d "$TS_TMP_OUT/models" ]]; then
  cp -R "$TS_TMP_OUT/models/." "$TS_OUT_DIR/"
fi

printf '%s\n' "Generated DTO models:"
printf '%s\n' "- Source: $SPEC_PATH"
printf '%s\n' "- Swift: $SWIFT_OUT_DIR"
printf '%s\n' "- Kotlin: $KOTLIN_OUT_DIR"
printf '%s\n' "- TypeScript: $TS_OUT_DIR"
printf '%s\n' "- Templates (optional): $TEMPLATES_DIR/{swift6,kotlin,typescript-fetch}"
