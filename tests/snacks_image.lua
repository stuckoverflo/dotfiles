local image = Snacks.config.image or {}

assert(image.enabled == true, "Snacks image rendering is not enabled")
assert(type(image.resolve) == "function", "Snacks image resolver is not configured")

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
