require("lazy").load({ plugins = { "conform.nvim" } })

local conform = require("conform")
local format_calls = 0
conform.format = function()
  format_calls = format_calls + 1
end

local function trigger_format_on_save(name)
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, vim.fs.joinpath(vim.fn.tempname(), name))
  vim.api.nvim_exec_autocmds("BufWritePre", { buffer = buf })
  vim.api.nvim_buf_delete(buf, { force = true })
end

trigger_format_on_save("drawing.excalidraw.md")
assert(format_calls == 0, "Excalidraw Markdown files must not be formatted")

trigger_format_on_save("note.md")
assert(format_calls == 1, "ordinary Markdown files must remain formatted")
