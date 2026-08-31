local image = Snacks.config.image or {}

assert(image.enabled == true, "Snacks image rendering is not enabled")
assert(type(image.resolve) == "function", "Snacks image resolver is not configured")
assert(type(image.config) == "function", "Snacks image terminal sizing guard is not configured")

local terminal = Snacks.image.terminal
local configured_size = terminal.size
terminal.size = function()
  return {
    width = 0,
    height = 0,
    columns = vim.o.columns,
    rows = vim.o.lines,
    cell_width = 0,
    cell_height = 0,
    scale = 1,
  }
end

image.config()

local fallback_size = terminal.size()
assert(fallback_size.width == vim.o.columns * 9, "zero-width PTYs should use the fallback terminal width")
assert(fallback_size.height == vim.o.lines * 18, "zero-height PTYs should use the fallback terminal height")
assert(fallback_size.cell_width == 9, "zero-width cells should use the fallback cell width")
assert(fallback_size.cell_height == 18, "zero-height cells should use the fallback cell height")

terminal.size = configured_size

local root = vim.fn.tempname()
local attachment = vim.fs.joinpath(root, "attachments", "diagram.png")

vim.fn.mkdir(vim.fs.dirname(attachment), "p")
vim.fn.writefile({ "fixture" }, attachment)
vim.env.OBSIDIAN_WORK = root

local note = vim.fs.joinpath(root, "01-journal", "20260829.md")

assert(image.resolve(note, "attachments/diagram.png") == attachment, "vault-relative image was not resolved")
assert(image.resolve(note, "diagram.png") == attachment, "attachment basename was not resolved")
assert(image.resolve(note, "missing.png") == nil, "missing image should use Snacks' fallback resolver")
assert(
  image.resolve(note, "https://example.com/diagram.png") == nil,
  "remote image should use Snacks' fallback resolver"
)

vim.fn.delete(root, "rf")
