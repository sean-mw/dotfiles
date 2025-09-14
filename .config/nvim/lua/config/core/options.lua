vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- show absolute line number for current line

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- use case-sensitive search for mixed case queries

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- colors
opt.termguicolors = true
opt.background = "dark" -- default to dark colorscheme variants
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or instert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical windows to the right
opt.splitbelow = true -- split horizontal windows to the bottom

-- turn off swapfile
opt.swapfile = false
