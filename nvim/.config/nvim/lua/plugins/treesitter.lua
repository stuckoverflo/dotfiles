local parsers = {
  "bash",
  "css",
  "dockerfile",
  "gitignore",
  "go",
  "html",
  "json",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "proto",
  "python",
  "query",
  "sql",
  "terraform",
  "vim",
  "vimdoc",
  "toml",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      ensure_installed = parsers,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
  },
}
