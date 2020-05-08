MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := run

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

HOST=http://localhost
PORT=1313

# .env
ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

run: ## Run server
	@hugo server  --bind="0.0.0.0" --baseUrl="${HOST}" --port=${PORT} --buildDrafts --watch

run-without-draft: ## Run server without draft posts
	@hugo server --theme=beautifulehugo --watch

build: ## Build static html
	@hugo

deploy: ## Deploy on Github Pages
	@sh deploy.sh

clean: ## Clean old files
	@hugo --cleanDestinationDir
	rm -fr docs/*

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
