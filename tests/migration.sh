#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

XDG_CONFIG_HOME="$repo_root/nvim/.config" nvim --headless -i NONE \
  "+lua local ok, err = pcall(dofile, [[$repo_root/tests/excalidraw_formatting.lua]]); if not ok then vim.api.nvim_err_writeln(err); vim.cmd('cquit') end" \
  +qa
