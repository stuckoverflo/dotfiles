return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "graphql",
        "helm",
        "html",
        "json",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "sql",
        "terraform",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
        "yaml",
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
    })
    require('nvim-ts-autotag').setup({
      opts = {},
    })
  end,
}

