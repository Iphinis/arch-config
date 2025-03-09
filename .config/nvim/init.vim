set nu

set clipboard=unnamedplus

set termguicolors

colorscheme sorbet

let g:Hexokinase_highlighters = ['backgroundfull']

call plug#begin()

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

call plug#end()
