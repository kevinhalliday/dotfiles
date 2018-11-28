CONFIG_DIRS_DOTFILES := $(wildcard dotfiles/.config/*)
CONFIG_DIRS_HOME := $(subst dotfiles, ~, $(CONFIG_DIRS_DOTFILES))

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: dotfiles
dotfiles: config_directories ## Place dotfiles in home folder, replacing all owned by stow
	stow -t ~ -R dotfiles/

.PHONY: config_directories
config_directories: $(CONFIG_DIRS_HOME)  ## Create directories in ~/.config. Useful because these directories might not exist yet

~/.config/%: dotfiles/.config/%
	-mkdir -p $@
