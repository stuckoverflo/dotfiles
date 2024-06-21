return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set("n", "<M-j>", function()
      harpoon:list():prev()
    end, { noremap = true, desc = "harpoon: prev buffer" })
    vim.keymap.set("n", "<M-k>", function()
      harpoon:list():next()
    end, { noremap = true, desc = "harpoon: next buffer" })
    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
      vim.keymap.set("n", string.format("<space>%d", idx), function()
        harpoon:list():select(idx)
      end, { desc = string.format("Harpoon: File %d", idx) })
    end
  end,
}
