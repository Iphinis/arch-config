set nu

set termguicolors

set clipboard=unnamedplus

call plug#begin()

Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

lua require'colorizer'.setup()
