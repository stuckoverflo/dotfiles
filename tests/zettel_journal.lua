local repo = vim.fn.getcwd()
vim.opt.rtp:prepend(repo .. "/nvim/.config/nvim")
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/obsidian.nvim")

local root = vim.fn.tempname()
local work = root .. "/work"
local knowledge = root .. "/portable notes/cacheflo"
for _, vault in ipairs({ work, knowledge }) do
  vim.fn.mkdir(vault .. "/templates", "p")
  vim.fn.writefile({ "---", "title: {{title}}", "date: {{now}}", "---" }, vault .. "/templates/a_nvim_zettel.md")
end
vim.fn.writefile({ "---", "tags: journal", "date: {{now}}", "---" }, work .. "/templates/nvim-daily.md")
vim.env.OBSIDIAN_WORK = work
vim.env.OBSIDIAN_KNOWLEDGE = knowledge

local opts = dofile(repo .. "/nvim/.config/nvim/lua/plugins/obsidian.lua").opts
opts.workspaces = { opts.workspaces[1], opts.workspaces[2] }
opts.picker = { name = "mini.pick" }
opts.ui = { enable = false }
local obsidian = require("obsidian")
obsidian.setup(opts)
local journal = work .. "/01-journal/" .. os.date("%Y%m%d") .. ".md"

local function create(title, template)
  local note = obsidian.Note.create({ id = title, template = template or "a_nvim_zettel.md" })
  note:write()
  note:open({ sync = true })
  local current = vim.api.nvim_get_current_buf()
  vim.wait(30, function()
    return false
  end)
  assert(vim.api.nvim_get_current_buf() == current, "linking changed the current buffer")
  return note
end

local first = create("first zettel")
local disk = vim.fn.readfile(journal)
assert(disk[2] == "tags: journal", "journal template not used")
assert(not table.concat(disk, "\n"):find("{{", 1, true), "unrendered journal template")
assert(disk[#disk] == "- [[00-inbox/" .. first.id .. "|first zettel]]", "work wikilink missing: " .. vim.inspect(disk))
opts.callbacks.create_note(first)
vim.wait(30, function()
  return false
end)
assert(vim.deep_equal(disk, vim.fn.readfile(journal)), "duplicate link")

local journal_buf = vim.fn.bufnr(journal)
vim.api.nvim_buf_set_lines(journal_buf, -1, -1, false, { "unsaved journal text" })
local second = create("second zettel")
assert(vim.deep_equal(disk, vim.fn.readfile(journal)), "unsaved journal was written")
local buffered = vim.api.nvim_buf_get_lines(journal_buf, 0, -1, false)
assert(vim.tbl_contains(buffered, "unsaved journal text"), "unsaved text lost")
assert(buffered[#buffered]:find(second.id, 1, true), "link missing from dirty journal buffer")
vim.api.nvim_buf_call(journal_buf, function()
  vim.cmd("silent write")
end)

obsidian.Workspace.set("cacheflo")
local portable = create("portable [note]")
assert(Obsidian.workspace.name == "cacheflo", "workspace changed")
disk = vim.fn.readfile(journal)
assert(
  disk[#disk] == "- [portable \\[note\\]](../../portable%20notes/cacheflo/zettel/" .. portable.id .. ".md)",
  "cross-vault link incorrect: " .. disk[#disk]
)

local before = table.concat(disk, "\n")
vim.fn.writefile({ "other template" }, knowledge .. "/templates/other.md")
create("other", "other.md")
assert(table.concat(vim.fn.readfile(journal), "\n") == before, "non-zettel was linked")

local failed = obsidian.Note.create({ id = "never written", template = "a_nvim_zettel.md" })
vim.wait(30, function()
  return false
end)
assert(not failed:exists(), "failed creation fixture exists")
assert(table.concat(vim.fn.readfile(journal), "\n") == before, "unwritten note was linked")

local notify = vim.notify
local warnings = {}
vim.notify = function(message)
  table.insert(warnings, message)
end
vim.env.OBSIDIAN_WORK = nil
local unlinked = create("work vault unavailable")
vim.notify = notify
assert(unlinked:exists(), "journal failure lost the zettel")
assert(
  vim.iter(warnings):any(function(message)
    return message:find("journal linking failed", 1, true) ~= nil
  end),
  "missing work vault not reported"
)
assert(table.concat(vim.fn.readfile(journal), "\n") == before, "missing work vault changed journal")
vim.env.OBSIDIAN_WORK = work

local excluded = root .. "/excluded"
vim.fn.mkdir(excluded .. "/templates", "p")
vim.fn.writefile({ "excluded note" }, excluded .. "/templates/a_nvim_zettel.md")
local workspace = obsidian.Workspace.new({ name = "personal", path = excluded, strict = true })
table.insert(Obsidian.workspaces, workspace)
obsidian.Workspace.set(workspace)
create("excluded zettel")
assert(table.concat(vim.fn.readfile(journal), "\n") == before, "excluded workspace was linked")

vim.fn.delete(root, "rf")
print(
  "PASS: journal links, template rendering, dirty buffers, duplicates, failure handling, and workspace/template scope"
)
