local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})


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
vim.opt.guicursor="n:block,i:block"
-- Set colorscheme and apply background tweaks
vim.cmd.colorscheme("default") -- Replace with your colorscheme
vim.cmd([[
  highlight Normal guifg=#ADD8E6
  highlight SignColumn guibg=NONE
  highlight StatusLine guibg=NONE
  highlight EndOfBuffer guibg=NONE
  highlight LineNr guifg=#ADD8E6
  highlight CursorLineNr guifg=orange gui=bold
]])

--suggestino box
vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#FFFFFF", bg = "#1E1E1E" })  -- Text in the box
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#569CD6", bold = true }) -- Matched text
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#C586C0", bold = true })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#4EC9B0", bg = "#1E1E1E" })  -- Icons
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C8C8C8", italic = true }) 


--C++ config:
-- Load LSP config
require'lspconfig'.clangd.setup {}

-- Optional: Show diagnostic messages in a floating window
vim.diagnostic.config({
    virtual_text = true,  -- Inline error messages
    signs = true,         -- Show signs in the gutter
    underline = true,     -- Underline errors in code
    update_in_insert = false,  -- Update diagnostics while in insert mode
})
