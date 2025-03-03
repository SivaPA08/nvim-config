-- Ensure Packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Plugin installation
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'          -- Plugin manager
    use 'neovim/nvim-lspconfig'          -- LSP configuration
    use 'hrsh7th/nvim-cmp'               -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'           -- LSP completion source for nvim-cmp
    use 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
    use 'windwp/nvim-autopairs'          -- Auto-pairing
    use 'nvim-lualine/lualine.nvim'      -- Statusline
    use 'EdenEast/nightfox.nvim'         -- Nightfox theme

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- General Settings
vim.o.number = true                 -- Enable line numbers
vim.o.relativenumber = true         -- Disable relative line numbers
vim.o.background = "dark"           -- Use dark background for themes
vim.o.swapfile=false                --Disables swap files and prevent swap-related messages 

-- Set the Nightfox theme to Carbonfox
require('nightfox').setup({
    options = {
        styles = { -- Customize code styles
            comments = "italic",
            keywords = "bold",
        },
        inverse = {
            match_paren = true, -- Invert match parens
        },
    }
})
vim.cmd [[colorscheme carbonfox]] -- Apply the "Carbonfox" theme for super-black background

-- LSP Configuration for C++
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}
lspconfig.ts_ls.setup{} --for js
lspconfig.html.setup{}
lspconfig.cssls.setup{} --for css

-- Autocompletion setup
local cmp = require('cmp')
cmp.setup({
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
    },
})



require('lspconfig').pyright.setup {}
local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
})


-- Treesitter setup
require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c" ,"python","javascript"  }, -- Install C++ parsers
    highlight = {
        enable = false,                -- Enable syntax highlighting
    },
    debug=true,
}

-- Statusline configuration
require('lualine').setup {
    options = {
        theme = 'nightfox',
        section_separators = '',
        component_separators = '',
	icons_enabled=false,
    },


}

vim.cmd [[
  highlight MsgArea guifg=#ffcc00 guibg=#1e1e2e
  highlight WildMenu guifg=#1e1e2e guibg=#ffcc00
]]

--This is for changing curor color 
vim.o.guicursor = "n:block-Cursor"
vim.api.nvim_set_hl(0, 'Cursor', { fg = 'yellow', bg = 'yellow' })


vim.g.netrw_bufsettings = "noma nomod nu rnu"

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "netrw" then
      vim.wo.number = true
      vim.wo.relativenumber = true
    end
  end,
})

