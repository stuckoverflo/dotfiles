-- Vault roots, resolved from the same env vars the workspaces use so the two
-- can't drift. Anything unset is dropped instead of falling back to a pattern
-- that would match every markdown file.
local vaults = vim.tbl_filter(function(dir)
  return dir ~= nil and dir ~= "" and vim.fn.isdirectory(dir) == 1
end, {
  vim.fn.expand(vim.env.OBSIDIAN_WORK or ""),
  vim.fn.expand(vim.env.OBSIDIAN_PEOPLE or ""),
  vim.fn.expand(vim.env.OBSIDIAN_PERSONAL or ""),
})

local vault_events = {}
for _, dir in ipairs(vaults) do
  table.insert(vault_events, "BufReadPre " .. dir .. "/**.md")
  table.insert(vault_events, "BufNewFile " .. dir .. "/**.md")
end

-- Also load eagerly when nvim starts with its cwd inside a vault, so the
-- Obsidian commands are there without opening a note first.
local cwd = vim.fs.normalize(vim.uv.cwd() or "")
local cwd_in_vault = false
for _, dir in ipairs(vaults) do
  if cwd == dir or vim.startswith(cwd, dir .. "/") then
    cwd_in_vault = true
    break
  end
end

local PROJECTS_DIR = "02-projects"
local PROJECT_PARTS = {
  { suffix = "project", template = "project-hub.md" },
  { suffix = "proposal", template = "project-output.md" },
}

-- Each note names its sibling from the folder they share, so neither template
-- has to be rewritten after it is cloned.
local function sibling(suffix)
  return function(ctx)
    local note = ctx.partial_note
    local parent = note and note.path and note.path:parent()
    return parent and (parent.name .. "-" .. suffix) or nil
  end
end

local function slugify(title)
  local slug = title:lower():gsub(" ", "-"):gsub("[^a-z0-9-]", "")
  return (slug:gsub("-+", "-"):gsub("^-", ""):gsub("-$", ""))
end

---@param data obsidian.CommandArgs
local function new_project(data)
  local obsidian = require("obsidian")
  local Note, api, log = obsidian.Note, obsidian.api, obsidian.log

  local projects = Obsidian.dir / PROJECTS_DIR
  if not projects:is_dir() then
    return log.err("'%s' has no %s/ directory", Obsidian.workspace.name, PROJECTS_DIR)
  end

  local title = vim.trim(table.concat(data.fargs or {}, " "))
  if title == "" then
    local ok, answer = pcall(api.input, "Project title: ")
    title = (ok and answer) and vim.trim(answer) or ""
  end
  if title == "" then
    return log.warn("Aborted")
  end

  local slug = slugify(title)
  if slug == "" then
    return log.err("'%s' has no characters usable in a file name", title)
  end

  -- lstat rather than exists(), so a dangling symlink still counts as occupied
  -- and never gets removed by the rollback below.
  local dir = projects / slug
  if vim.uv.fs_lstat(tostring(dir)) then
    return log.err("'%s' already exists", dir:vault_relative_path() or tostring(dir))
  end

  -- Resolve the templates to absolute paths before anything touches the disk.
  -- obsidian.nvim checks the cwd before the templates folder, so a bare name
  -- would pick up a same-named file in whatever directory nvim started in.
  local templates_dir = api.templates_dir()
  if not templates_dir then
    return log.err("Templates folder is not defined or does not exist")
  end
  local templates = {}
  for i, part in ipairs(PROJECT_PARTS) do
    local ok, resolved = pcall(obsidian.templates.resolve_template, templates_dir / part.template)
    if not ok then
      return log.err(tostring(resolved))
    end
    templates[i] = tostring(resolved)
  end

  local name = slug:gsub("-", " ")
  local created = {}

  local ok, err = pcall(function()
    for i, part in ipairs(PROJECT_PARTS) do
      -- `should_write = false` because Note.create derives the title itself and
      -- the templates read it back through `{{title}}`.
      local note = Note.create({
        id = slug .. "-" .. part.suffix,
        dir = PROJECTS_DIR .. "/" .. slug,
        verbatim = true,
        should_write = false,
      })
      note.title = name .. " " .. part.suffix
      created[i] = note
      note:write({ template = templates[i] })
    end
  end)

  if ok then
    return created[1]:open({ sync = true })
  end

  -- Roll back only what this call made: the notes, then the folder itself. `d`
  -- refuses to remove a folder that still holds anything else.
  local function remove(path, flags)
    return not vim.uv.fs_lstat(path) or vim.fn.delete(path, flags) == 0
  end
  local clean = true
  for _, note in ipairs(created) do
    clean = remove(tostring(note.path)) and clean
  end
  clean = remove(tostring(dir), "d") and clean

  return log.err(
    "Could not create project '%s': %s%s",
    slug,
    tostring(err),
    clean and "" or ("\nRemove '" .. tostring(dir) .. "' by hand.")
  )
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = not cwd_in_vault,
  event = vault_events,
  keys = {
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
    { "<leader>oz", "<cmd>Obsidian new_from_template<cr>", desc = "Obsidian New from Template" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Obsidian Today" },
    { "<leader>op", "<cmd>Obsidian new_project<cr>", desc = "Obsidian New Project" },
  },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-treesitter",
    -- "OXY2DEV/markview.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function(_, opts)
    local obsidian = require("obsidian")
    obsidian.setup(opts)
    obsidian.register_command("new_project", { nargs = "*", func = new_project })
  end,
  opts = {
    frontmatter = {
      enabled = false,
    },
    legacy_commands = false,
    workspaces = {
      {
        name = "work",
        -- pin root to path; otherwise obsidian.nvim walks up looking for a
        -- '.obsidian/' dir and can resolve the root to $HOME
        strict = true,
        path = function()
          return vim.env.OBSIDIAN_WORK
        end,
      },
      {
        name = "people",
        strict = true,
        path = function()
          return vim.env.OBSIDIAN_PEOPLE
        end,
        overrides = {
          new_notes_location = "notes_subdir",
          notes_subdir = vim.NIL,
          templates = {
            folder = "templates",
          },
          daily_notes = {
            enabled = false,
            folder = vim.NIL,
            template = vim.NIL,
          },
        },
      },
      {
        name = "personal",
        path = function()
          return vim.env.OBSIDIAN_PERSONAL
        end,
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "01-journal",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y%m%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "nvim-daily.md",
    },
    templates = {
      folder = "templates",
      date_format = "%Y%m%d",
      time_format = "%H:%M",

      -- https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
      substitutions = {
        today = function()
          return os.date("%Y-%m-%d")
        end,
        now = function()
          return os.date("%Y-%m-%d %H:%M:%S")
        end,
        hub = sibling("project"),
        output = sibling("proposal"),
      },
      customizations = {
        a_nvim_zettel = {
          notes_subdir = "00-inbox",
          note_id_func = function(title)
            local suffix = ""
            if title ~= nil then
              -- If title is given, transform it into valid file name.
              suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
              -- If title is nil, just add 4 random uppercase letters to the suffix.
              for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
              end
            end
            -- return os.date() .. "-" .. suffix but in YYYYMMDDHHmm format
            return os.date("%Y%m%d%H%M") .. "-" .. suffix
          end,
        },
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "notes_subdir",
    notes_subdir = "00-inbox",
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- return os.date() .. "-" .. suffix but in YYYYMMDDHHmm format
      return os.date("%Y%m%d%H%M") .. "-" .. suffix
    end,

    checkbox = {
      order = { " ", "x", "!", "?", "-" },
    },
  },
}
