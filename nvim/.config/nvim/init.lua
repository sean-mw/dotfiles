vim.g.mapleader = " "

-- Yank/paste via the system clipboard
vim.opt.clipboard = "unnamedplus"

-- File explorer (nvim-tree replaces netrw)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
})

require("nvim-tree").setup({
  view = { width = 50, relativenumber = true },
  renderer = { indent_markers = { enable = true } },
  actions = { open_file = { window_picker = { enable = false } } },
  filters = { custom = { ".DS_Store" } },
  git = { ignore = false },
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
