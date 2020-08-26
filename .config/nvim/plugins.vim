call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

Plug 'andymass/vim-matchup'

Plug 'scr1pt0r/crease.vim'

Plug 'preservim/nerdcommenter'

"Plug 'FooSoft/vim-argwrap'
Plug 'alvan/vim-closetag'
Plug 'skywind3000/asyncrun.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-vimlsp',
  \ 'coc-pairs',
  \ 'coc-yank',
  \ 'coc-highlight',
  \ ]

Plug 'Shougo/echodoc.vim'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

Plug '907th/vim-auto-save'
Plug 'honza/vim-snippets'

Plug 'voldikss/vim-floaterm'
Plug 'romainl/vim-cool'


Plug 'sheerun/vim-polyglot'
" Python
Plug 'tmhedberg/SimpylFold'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'mhinz/vim-startify'
Plug 'simnalamburt/vim-mundo'
Plug 'dense-analysis/ale'

Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'

Plug 'airblade/vim-gitgutter'

Plug 'Yggdroot/indentLine'

" Colour Schemes
Plug 'rakr/vim-one'
" Plug 'nightsense/cosmic_latte'
Plug 'ryanoasis/vim-devicons'

call plug#end()
