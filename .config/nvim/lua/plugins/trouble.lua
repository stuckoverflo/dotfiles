return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>xx", "<cmd>Trouble<CR>", desc = "Open/close trouble list" },
    { "<leader>xw", "<cmd>Trouble diagnostics toggle focus=true<CR>", desc = "Open trouble workspace diagnostics" },
    {
      "<leader>xd",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<CR>",
      desc = "Open trouble document diagnostics",
    },
    { "<leader>xq", "<cmd>Trouble quickfix toggle focus=true<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle focus=true<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle focus=true<CR>", desc = "Open todos in trouble" },
  },
}
