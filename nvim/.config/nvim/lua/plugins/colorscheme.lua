return {
  "webhooked/kanso.nvim",
  priority = 1000,
  config = function()
    require("kanso").setup({
      background = {
        light = "pearl",
        dark = "ink",
      },
    })

    vim.cmd("colorscheme kanso")
  end,
}
-- return {
--   "folke/tokyonight.nvim",
--   priority = 1000,
--   config = function()
--     require("tokyonight").setup({
--       style = "moon",
--     })
--
--     vim.cmd("colorscheme tokyonight")
--   end,
-- }
