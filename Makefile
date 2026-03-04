.PHONY: bootstrap install apps config update clean dump

# Bootstrap from scratch (installs Homebrew if missing)
bootstrap:
	@command -v brew >/dev/null || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	$(MAKE) install

# Full setup (new machine)
install: apps config

# Install apps via Brewfile
apps:
	brew bundle --file=Brewfile --no-lock

# Symlink configs only (safe to re-run)
config:
	./install.sh

# Update installed packages
update:
	brew bundle --file=Brewfile --no-lock && brew upgrade

# Unstow everything
clean:
	@for dir in */; do stow -t ~ -D "$${dir%/}" 2>/dev/null || true; done

# Dump current brew state
dump:
	brew bundle dump --file=Brewfile --force --describe
