#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

command -v stow &>/dev/null || { echo "stow not found. Run: brew install stow"; exit 1; }

PACKAGES=(zsh git tmux nvim ghostty starship direnv readline shell)
MACOS_PACKAGES=(aerospace karabiner)

for pkg in "${PACKAGES[@]}"; do
  [ -d "$DOTFILES/$pkg" ] && stow -d "$DOTFILES" -t "$HOME" --restow "$pkg"
done

if [ "$(uname)" = "Darwin" ]; then
  for pkg in "${MACOS_PACKAGES[@]}"; do
    [ -d "$DOTFILES/$pkg" ] && stow -d "$DOTFILES" -t "$HOME" --restow "$pkg"
  done
fi

echo "Config installed."
