vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 --  2 spaces for indent
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

opt.wrap = false

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- assume case-sensitive when mixed case

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus") -- use system clipboard on yank

opt.splitright = true -- vertical split always to the right
opt.splitbelow = true -- horizontal split always to the bottom

opt.scrolloff = 8

opt.guicursor = ""
