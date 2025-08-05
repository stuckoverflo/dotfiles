return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter",
    -- "OXY2DEV/markview.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "main",
        path = os.getenv("NOTES_DIR"),
      },
    },
    templates = {
      folder = "templates",
      date_format = "%Y%m%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "01-journal",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y%m%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "daily.md",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "99-work",
    callbacks = {
      enter_note = function(_, note)
        vim.keymap.set("n", "<leader>gf", function()
          return require("obsidian").util.gf_passthrough(note)
        end, { noremap = false, expr = true, buffer = note.bufnr })
        vim.keymap.set("n", "<leader>ch", function()
          return require("obsidian").util.toggle_checkbox(note)
        end, { buffer = note.bufnr })
        vim.keymap.set("n", "<cr>", function()
          return require("obsidian").util.smart_action(note)
        end, { buffer = note.bufnr, expr = true })
      end,
    },
    -- mappings = {
    --   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    --   ["<leader>gf"] = {
    --     action = function()
    --       return require("obsidian").util.gf_passthrough()
    --     end,
    --     opts = { noremap = false, expr = true, buffer = true },
    --   },
    --   -- Toggle check-boxes.
    --   ["<leader>ch"] = {
    --     action = function()
    --       return require("obsidian").util.toggle_checkbox()
    --     end,
    --     opts = { buffer = true },
    --   },
    --   -- Smart action depending on context, either follow link or toggle checkbox.
    --   ["<cr>"] = {
    --     action = function()
    --       return require("obsidian").util.smart_action()
    --     end,
    --     opts = { buffer = true, expr = true },
    --   },
    -- },
    disable_frontmatter = true,
  },
}
