return {
  "zeybek/camouflage.nvim",
  config = function()
    local camouflage = require("camouflage")
    camouflage.setup({
      auto_enable = true,
      enabled = true,
      patterns = {
        { file_pattern = { ".secrets" }, parser = "env" },
      },
    })
  end,
}
