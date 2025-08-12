return {
  "folke/snacks.nvim",
  priority = 1000,
  
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
          ███████╗██╗      ██████╗  
       ██╗██╔════╝██║     ██╔═══██╗ 
       ╚═╝█████╗  ██║     ██║   ██║ 
       ██╗██╔══╝  ██║     ██║   ██║ 
       ╚═╝██║     ███████╗╚██████╔╝ 
          ╚═╝     ╚══════╝ ╚═════╝  
        ]] .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
        keys = {},
      },
    },
    explorer = {},
    gitbrowse = {},
    input = {
      enabled = false,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      cwd_bonus = true,
    },
    scratch = { enabled = true },
    scroll = { enabled = true },
  },
  keys = {
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { '<leader>e', function() Snacks.picker.explorer() end, desc = 'Explorer' },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find in Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
  },
}
