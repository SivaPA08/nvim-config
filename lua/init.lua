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
vim.o.relativenumber = false        -- Disable relative line numbers
vim.o.background = "dark"           -- Use dark background for themes

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

-- Auto-pairing setup
require('nvim-autopairs').setup{}

-- Treesitter setup
require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c" }, -- Install C++ parsers
    highlight = {
        enable = true,                -- Enable syntax highlighting
    },
}

-- Statusline configuration
require('lualine').setup {
    options = {
        theme = 'nightfox',
        section_separators = '',
        component_separators = '',
    },
}

