DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin config
EXCLUSIONS := .DS_Store .git .github .gitignore .vscode
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
SHELLCHECK          := shellcheck
SHELLCHECK_FORMAT   := gcc
SHELLCHECK_EXCLUDE  := SC1090

.DEFAULT_GOAL := help

all:

update: ## Fetch changes for this repo
	git pull origin master

deploy: ## Deploy dotfile symlinks to $HOME
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/deploy

init: ## Install development packages & setup settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/init

install: deploy init ## Run make deploy, init
	@exec $$SHELL

lint: ## Run shellcheck against bash scripts
	@echo '==> Running shellcheck'
	@find . \
		-type d -name .git -prune -o \
		-type f -print0 \
	| xargs -0 awk 'FNR==1 && $$0=="#!/usr/bin/env bash"{print FILENAME}' \
	| xargs $(SHELLCHECK) -f $(SHELLCHECK_FORMAT) --exclude=$(SHELLCHECK_EXCLUDE)

clean: ## Unlink deployed dotfile symlinks from $HOME
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/scripts/clean

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'