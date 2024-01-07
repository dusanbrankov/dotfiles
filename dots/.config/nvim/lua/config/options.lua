if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.clipboard = "unnamedplus"

-- Appearance
-- vim.opt.guicursor = ""
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.breakindent = true
vim.opt.scrolloff = 999
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.opt.showtabline = 2

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

vim.opt.colorcolumn = "80"

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.autoindent = true

vim.opt.virtualedit = "block"
vim.opt.cursorline = true

vim.opt.autochdir = true
