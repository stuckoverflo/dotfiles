vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("n", "<leader> ", ":update<CR>", { desc = "Save the current buffer" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "sx", ":close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set("v", ">", ">gv", { desc = "Reselect visual block after indent" })
keymap.set("v", "<", "<gv", { desc = "Reselect visual block after outdent" })

keymap.set("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle line wrap" })
