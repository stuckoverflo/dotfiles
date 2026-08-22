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

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = not cwd_in_vault,
  event = vault_events,
  keys = {
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Quick Switch" },
    { "<leader>oz", "<cmd>Obsidian new_from_template<cr>", desc = "Obsidian New from Template" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Obsidian Today" },
  },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-treesitter",
    -- "OXY2DEV/markview.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
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
