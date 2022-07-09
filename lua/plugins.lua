return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- git plugin
  use 'tpope/vim-fugitive'

  -- vim statusbar
  use 'itchyny/lightline.vim'

  -- neovim LSP
  use 'neovim/nvim-lspconfig' 
end)
