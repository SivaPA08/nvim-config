-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.relativenumber = false
vim.opt.number = true

-- Enable true color and set dark background
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Set colorscheme and apply background tweaks
vim.cmd.colorscheme("default") -- Replace with your colorscheme
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE
  highlight StatusLine guibg=NONE
  highlight EndOfBuffer guibg=NONE
]])
