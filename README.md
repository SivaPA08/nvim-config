# Neovim Configuration

Clone my **nvim-config** repository and set up Neovim with my custom configuration.

## Installation

### Step 1: Install Neovim
Ensure you have Neovim installed on your system. You can install it using:

#### Linux (Debian/Ubuntu)
```sh
sudo apt update && sudo apt install neovim
```

#### macOS (Homebrew)
```sh
brew install neovim
```

#### Windows (Scoop)
```powershell
scoop install neovim
```

### Step 2: Clone and Copy Configuration
Clone the repository and move the `nvim` folder to your Neovim configuration directory:
```sh
cp -r nvim-config/nvim ~/.config/nvim
```

### Step 3: Install Packer
Packer is used for plugin management. Install it using:
```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Step 4: Ensure Packer is Installed
Packer is automatically installed via the following Lua function in the config:
```lua
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
```

### Step 5: Install Plugins
Launch Neovim and run:
```vim
:PackerSync
```
This will install all required plugins defined in the configuration.

## Plugins Used
- **Packer** - Plugin manager
- **nvim-lspconfig** - LSP support for better autocompletion
- **nvim-cmp** - Autocompletion framework
- **cmp-nvim-lsp** - LSP completion source
- **nvim-treesitter** - Enhanced syntax highlighting
- **nvim-autopairs** - Automatically closes brackets and quotes
- **lualine.nvim** - Customizable status line
- **nightfox.nvim** - Color theme

## Configuration Details
### UI Enhancements
- Line numbers enabled: `vim.o.number = true`
- Relative line numbers disabled: `vim.o.relativenumber = false`
- Dark theme enabled: `vim.o.background = "dark"`
- Colorscheme set to `carbonfox`:
```lua
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
```

### LSP Configuration
- Configured for **C++** using `clangd`:
```lua
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}
```

### Autocompletion Setup
```lua
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
```

### Treesitter Configuration
```lua
require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c" },
    highlight = {
        enable = false,
    },
}
```

### Auto-Pairing Setup
```lua
require('nvim-autopairs').setup{}
```

### Status Line Configuration
```lua
require('lualine').setup {
    options = {
        theme = 'nightfox',
        section_separators = '',
        component_separators = '',
    },
}
```

## Troubleshooting
- Run `:checkhealth` inside Neovim to diagnose issues.
- Ensure your system has required dependencies like `ripgrep`, `node.js`, and `python`.
- Restart Neovim after installing plugins.

## Contributing
Feel free to fork the repository, submit pull requests, or suggest improvements.

## License
This configuration is available under the Apache-2.0 License.

---
Your Neovim setup is now complete! 🎉

