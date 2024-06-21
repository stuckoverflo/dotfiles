local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jj" })
keymap.set("n", "<leader> ", ":update<CR>", { desc = "Save the current buffer" })

keymap.set("n", "j", "gj", { desc = "Treat long lines as break lines" })
keymap.set("n", "k", "gk", { desc = "Treat long lines as break lines" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center the cursor when navigating using C-d" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center the cursor when navigating using C-u" })
keymap.set("n", "n", "nzzzv", { desc = "Center the cursor when navigating search results" })
keymap.set("n", "N", "Nzzzv", { desc = "Center the cursor when navigating search results" })

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

keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace the word under cursor" }
)

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Smartly move highlighted lines of code" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Smartly move highlighted lines of code" })
keymap.set("n", "<space>cht", "<cmd>cht.sh<cr>")
