local M = {}

local function append(note, source, work)
  if vim.fn.isdirectory(work) ~= 1 then
    error("Work vault is unavailable; check OBSIDIAN_WORK")
  end
  local journal_dir = vim.fs.joinpath(work, "01-journal")
  local journal = vim.fs.joinpath(journal_dir, os.date("%Y%m%d") .. ".md")
  local bufnr = vim.fn.bufnr(journal)
  if vim.fn.filereadable(journal) == 0 and not (bufnr >= 0 and vim.api.nvim_buf_is_loaded(bufnr)) then
    require("obsidian.templates").clone_template({
      template_name = vim.fs.joinpath(work, "templates", "nvim-daily.md"),
      destination_path = journal,
      type = "clone_template",
    })
  end

  local title = (note.title or note.id):gsub("[\r\n]", " ")
  local link
  if source.name == "work" then
    local path = tostring(note.path):sub(#work + 2):gsub("%.md$", "")
    link = "[[" .. path .. "|" .. title:gsub("[|%[%]]", "") .. "]]"
  else
    local ancestor, prefix = journal_dir, ""
    while not vim.fs.relpath(ancestor, tostring(note.path)) do
      ancestor = vim.fs.dirname(ancestor)
      prefix = prefix .. "../"
    end
    local path = prefix .. vim.fs.relpath(ancestor, tostring(note.path))
    path = path:gsub("[^%w%-%._~/]", function(char)
      return string.format("%%%02X", char:byte())
    end)
    link = "[" .. title:gsub("([\\%[%]])", "\\%1") .. "](" .. path .. ")"
  end

  bufnr = vim.fn.bufadd(journal)
  vim.fn.bufload(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local entry = "- " .. link
  if vim.tbl_contains(lines, entry) then
    return
  end
  local modified = vim.bo[bufnr].modified
  local addition = lines[#lines] == "" and { entry } or { "", entry }
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, addition)
  if modified then
    vim.notify("Zettel linked in journal buffer; save the journal to keep the link")
  else
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd("silent update")
    end)
  end
end

function M.on_create(note)
  if not note.template or vim.fn.fnamemodify(tostring(note.template), ":t:r") ~= "a_nvim_zettel" then
    return
  end
  local source = require("obsidian.api").find_workspace(note.path)
  if not source or (source.name ~= "work" and source.name ~= "cacheflo") or note:exists() then
    return
  end
  local work = vim.env.OBSIDIAN_WORK
  work = work and work ~= "" and vim.fs.normalize(vim.fn.resolve(vim.fn.expand(work))) or nil

  -- Creation callbacks run before the template is written to disk.
  vim.schedule(function()
    if not note:exists() then
      return
    end
    local ok, err = pcall(function()
      assert(work, "Work vault is unavailable; check OBSIDIAN_WORK")
      append(note, source, work)
    end)
    if not ok then
      vim.notify("Zettel saved, but journal linking failed: " .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end

return M
