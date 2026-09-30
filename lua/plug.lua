local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

return require('packer').startup(function()
    -- other plugins...
    
    use 'williamboman/mason.nvim'    
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig' 
    use 'simrat39/rust-tools.nvim'
    use 'hrsh7th/nvim-cmp' 

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'                            
    use 'hrsh7th/vim-vsnip'    
    use {'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
    }
    use 'puremourning/vimspector'
    use 'voldikss/vim-floaterm'

    use{'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
	    'nvim-lua/plenary.nvim',
	    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }}
    use 'nvim-tree/nvim-web-devicons'
    use {
	    'nvim-tree/nvim-tree.lua',
	    requires = { 'nvim-tree/nvim-web-devicons' },
    }
   -- Panel de símbolos del código
   use 'preservim/tagbar'
   use {"folke/todo-comments.nvim",
   requires = { "nvim-lua/plenary.nvim" },
   }
-- Panel de diagnósticos y errores
   use {"folke/trouble.nvim",
   requires = { "nvim-tree/nvim-web-devicons" },
   }
   use { "catppuccin/nvim", as = "catppuccin" }
end)
