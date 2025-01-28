--this is to  ensure Packer is installed
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
    use 'wbthomason/packer.nvim'          
    use 'neovim/nvim-lspconfig'          
    use 'hrsh7th/nvim-cmp'               
    use 'hrsh7th/cmp-nvim-lsp'           
    use 'nvim-treesitter/nvim-treesitter' 
    use 'windwp/nvim-autopairs'          
    use 'nvim-lualine/lualine.nvim'      
    use 'EdenEast/nightfox.nvim'         

    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.o.number = true                
vim.o.relativenumber = false        
vim.o.background = "dark"           

require('nightfox').setup({
    options = {
        styles = { 
            comments = "italic",
            keywords = "bold",
        },
        inverse = {
            match_paren = true, 
        },
    }
})
vim.cmd [[colorscheme carbonfox]] 

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
        enable = false,                -- Enable syntax highlighting
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


require('options').setup()
