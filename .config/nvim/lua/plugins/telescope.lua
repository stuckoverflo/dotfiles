return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
    local telescope = require("telescope")

    -- Include hidden files in search
    table.insert(vimgrep_arguments, "--hidden")

    -- Exclude `.git` in search
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.obsidian/*")

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/.obsidian/*" },
        },
      },
    })

    telescope.load_extension("fzf")

    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find from existing buffers" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
