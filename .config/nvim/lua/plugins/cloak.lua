return {
  "laytan/cloak.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_on_leave = true,
      patterns = {
        {
          file_pattern = ".env",
          cloak_pattern = "=.+",
        },
      },
    })
  end,
}
