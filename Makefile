DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitignore .vscode
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), ls -dl $(val);)

update: ## Fetch changes for this repo
	git pull origin master

deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	bash $(DOTPATH)/etc/scripts/deploy

init: ## Setup environment settings
	@echo '==> Start to install app using pkg manager.'
	@echo ''
	bash $(DOTPATH)/etc/scripts/init

deep: ## Setup more finicky settings
	@echo '==> Start to install a variety of tools.'
	@echo ''
	@find $(DOTPATH)/etc/scripts/deep.d -name "[0-9][0-9]*.sh"

install: deploy init ## Run make deploy, init
	@exec $$SHELL

clean: ## Remove dotfiles and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'