return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    -- add any options here
    messages = {
      enabled = true,
    },
    popupmenu = {
      enabled = true,
    },
    notify = {
      enabled = true,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = true,
      lsp_doc_border = false,
    },
    routes = {
      {
        filter = { event = "msg_show", kind = { "shell_out", "shell_err" } },
        view = "popup",
        opts = {
          level = "info",
          skip = false,
          replace = false,
        },
      },
    },
  },
  config = true,
}
