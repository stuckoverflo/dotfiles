return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("snacks").setup({
      input = {
        enabled = true,
        icon = " ",
        icon_hl = "SnacksInputIcon",
        icon_pos = "left",
        prompt_pos = "title",
        win = { style = "input" },
        expand = true,
      },
      notifier = { enabled = true, timeout = 3000 },
      scroll = { enabled = true },
      -- Add your configuration here
      -- For example:
      -- default_keymaps = true,
      -- highlight = "Visual",
      -- border = "rounded",
    })
  end,
}
