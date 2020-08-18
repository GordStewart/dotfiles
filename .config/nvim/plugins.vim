call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

Plug 'preservim/nerdcommenter'

Plug 'FooSoft/vim-argwrap'
Plug 'alvan/vim-closetag'
Plug 'skywind3000/asyncrun.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/echodoc.vim'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

Plug 'honza/vim-snippets'

Plug 'voldikss/vim-floaterm'
Plug 'romainl/vim-cool'

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
Plug 'danilo-augusto/vim-afterglow'
Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
Plug 'nightsense/cosmic_latte'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ryanoasis/vim-devicons'

Plug 'itchyny/lightline.vim'

call plug#end()
