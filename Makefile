.DEFAULT_GOAL := .func/help/default
SHELL := /bin/bash
MAKEFILE_SELF := $(lastword $(MAKEFILE_LIST))


.PHONY: .func/help/default
.func/help/default: ## func | help | Show description for all targets
	@cat $(MAKEFILE_LIST) | \
	grep -e "^[a-zA-Z0-9_\/\-]*: ## *" | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: .func/help/target
.func/help/target: ## func | help | Show description for specific target
	@cat $(MAKEFILE_SELF) | \
	grep -e "^${TARGET}: ## *" | \
	awk 'BEGIN {FS = ":.*?## "}; {\
		printf "\033[36mTarget:\033[0m \033[33m%s\033[0m\n\033[36mDescription:\033[0m %s\n", $$1, $$2\
	}'


.PHONY: lint
lint: ## Run linters
	@$(MAKE) -f $(MAKEFILE_SELF) .func/help/target TARGET="$@"
	@docker pull ghcr.io/github/super-linter:slim-v4
	@docker run \
		-it \
		--rm \
		-e LOG_LEVEL="NOTICE" \
		-e RUN_LOCAL="true" \
		-e IGNORE_GITIGNORED_FILES="true" \
		-v "${PWD}":"/tmp/lint" \
		ghcr.io/github/super-linter:slim-v4
