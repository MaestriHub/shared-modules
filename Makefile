SHELL := /bin/bash
NPM ?= npm
OPENAPI_DOCS_PORT ?= 18080
NO_CHANGE ?= none

.DEFAULT_GOAL := help

.PHONY: help install \
	openapi-lint openapi-bundle-docs openapi-rebuild \
	openapi-redocly-lint openapi-docs-preview openapi-docs-build \
	openapi-diff openapi-diff-summary openapi-semver-plan openapi-semver-bump \
	openapi-dto-generate openapi-check openapi-release-prepare

help:
	@echo "Available targets:"
	@echo "  make install                    - Install tooling dependencies"
	@echo "  make openapi-lint               - Lint split OpenAPI specs"
	@echo "  make openapi-bundle-docs        - Build docs bundle from split specs"
	@echo "  make openapi-redocly-lint       - Lint bundled spec with Redocly"
	@echo "  make openapi-docs-preview       - Start local Redocly docs viewer"
	@echo "  make openapi-docs-build         - Build static HTML docs with Redocly"
	@echo "  make openapi-diff OLD=... NEW=...         - Diff two OpenAPI specs"
	@echo "  make openapi-diff-summary OLD=... NEW=... - Summary diff (compact)"
	@echo "  make openapi-semver-plan OLD=... NEW=...  - Compute recommended semver bump"
	@echo "  make openapi-semver-bump OLD=... NEW=...  - Apply semver bump to modules/sdk-versions.json"
	@echo "  make openapi-rebuild            - Alias for openapi-bundle-docs"
	@echo "  make openapi-dto-generate       - Generate DTOs for Swift/Kotlin/TypeScript"
	@echo "  make openapi-check              - Lint + bundle"
	@echo "  make openapi-release-prepare    - Lint + bundle + DTO generation"

install:
	$(NPM) install

openapi-lint:
	$(NPM) run openapi:lint

openapi-bundle-docs:
	$(NPM) run openapi:bundle:docs

openapi-redocly-lint:
	$(NPM) run openapi:redocly:lint

openapi-docs-preview:
	OPENAPI_DOCS_PORT=$(OPENAPI_DOCS_PORT) $(NPM) run openapi:docs:preview

openapi-docs-build:
	$(NPM) run openapi:docs:build

openapi-diff:
	@test -n "$(OLD)" && test -n "$(NEW)" || (echo "Usage: make openapi-diff OLD=path/to/old.yaml NEW=path/to/new.yaml"; exit 1)
	$(NPM) run openapi:diff -- "$(OLD)" "$(NEW)"

openapi-diff-summary:
	@test -n "$(OLD)" && test -n "$(NEW)" || (echo "Usage: make openapi-diff-summary OLD=path/to/old.yaml NEW=path/to/new.yaml"; exit 1)
	$(NPM) run openapi:diff:summary -- "$(OLD)" "$(NEW)"

openapi-semver-plan:
	@test -n "$(OLD)" && test -n "$(NEW)" || (echo "Usage: make openapi-semver-plan OLD=path/to/old.yaml NEW=path/to/new.yaml"; exit 1)
	$(NPM) run openapi:semver:plan -- --old "$(OLD)" --new "$(NEW)" --no-change "$(NO_CHANGE)"

openapi-semver-bump:
	@test -n "$(OLD)" && test -n "$(NEW)" || (echo "Usage: make openapi-semver-bump OLD=path/to/old.yaml NEW=path/to/new.yaml"; exit 1)
	$(NPM) run openapi:semver:bump -- --old "$(OLD)" --new "$(NEW)" --no-change "$(NO_CHANGE)"

openapi-rebuild: openapi-bundle-docs

openapi-dto-generate:
	$(NPM) run openapi:dto:generate

openapi-check:
	$(NPM) run openapi:check

openapi-release-prepare:
	$(NPM) run openapi:release:prepare
