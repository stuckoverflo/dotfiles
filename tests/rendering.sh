#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

rg -q '^brew "herdr"$' "$repo_root/Brewfile"
rg -q '^PACKAGES=.*herdr' "$repo_root/install.sh"
rg -q '^kitty_graphics = true$' "$repo_root/herdr/.config/herdr/config.toml"

XDG_CONFIG_HOME="$repo_root/nvim/.config" nvim --headless -i NONE \
  "+lua local ok, err = pcall(dofile, [[$repo_root/tests/snacks_image.lua]]); if not ok then vim.api.nvim_err_writeln(err); vim.cmd('cquit') end" \
  +qa
