set nu

set clipboard=unnamedplus

set termguicolors

colorscheme sorbet

let g:Hexokinase_highlighters = ['backgroundfull']

call plug#begin()

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
