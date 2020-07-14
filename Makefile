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

ifndef SLUG
  SLUG=""
endif

ifndef DATE
  DATE=""
endif

run: ## Run server
	@hugo server --bind="0.0.0.0" --baseUrl="${HOST}" --port=${PORT} --buildDrafts --watch

run-without-draft: ## Run server without draft posts
	@hugo server --watch

build: clean ## Build static html
	@hugo

deploy: build ## Deploy on Github Pages
	@git add .
	@git commit -m 'modified'
	@git push origin master

clean: ## Clean old files
	@hugo --cleanDestinationDir
	rm -fr public/*

post: ## Post blog
	python scripts/genpost.py -s ${SLUG} -d ${DATE}
	@#echo "hugo new posts/<yyyy>/<mm>/<slug>.md"

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
