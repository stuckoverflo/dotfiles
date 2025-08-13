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
        ]] .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
        keys = {},
      },
    },
    explorer = { enabled = true },
    gitbrowse = { enabled = true },
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
    quickfile = {},
    scratch = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "gd",          function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD",          function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr",          function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI",          function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gt",          function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>.",   function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { '<leader>e',   function() Snacks.picker.explorer() end, desc = 'Explorer' },
    { "<leader>fb",  function() Snacks.picker.buffers() end, desc = "Find in Buffers" },
    { "<leader>fc",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff",  function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>fr",  function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fw",  function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>gB",  function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>gbl", function() Snacks.git.blame_line() end, desc = "Git Blame Line", mode = { "n", "v" } },
    { "<leader>gbb", function() Snacks.picker.git_branches() end, desc = "Git Branches", mode = { "n", "v" } },
    { "<leader>lg",  function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { '<leader>sd',  function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { "<leader>sk",  function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>ss",  function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>S",   function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>sw",  function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>z",   function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "sm",          function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "]]",          function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",          function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>w")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
