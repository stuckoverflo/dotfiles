return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
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
        path = os.getenv("OBSIDIAN_WORK"),
      },
      {
        name = "personal",
        path = os.getenv("OBSIDIAN_PERSONAL"),
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
      template = "nvim_daily.md",
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
    new_notes_location = "00-inbox",
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
    callbacks = {
      enter_note = function(note)
        vim.keymap.set("n", "<leader>nq", "<cmd>Obsidian quick_switch<cr>")
        vim.keymap.set("n", "<leader>nz", "<cmd>Obsidian new_from_template<cr>")
        vim.keymap.set("n", "<leader>nd", "<cmd>Obsidian today<cr>")
      end,
    },
  },
}
