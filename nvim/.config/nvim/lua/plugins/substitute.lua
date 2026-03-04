return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("substitute").setup()

    local substitute = require("substitute")

    vim.keymap.set("n", "s", substitute.operator, { noremap = true, desc = "substitute with motion" })
    vim.keymap.set("n", "ss", substitute.line, { noremap = true, desc = "substitute line" })
    vim.keymap.set("n", "S", substitute.eol, { noremap = true, desc = "substitute to the end of the line" })
    vim.keymap.set("x", "s", substitute.visual, { noremap = true, desc = "substitute in visual mode" })
  end,
}
