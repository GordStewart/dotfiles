" Auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" speeds up startup time if set
let g:python3_host_prog = '/usr/bin/python3'

" must be set to `1` before ALE is loaded.
let g:ale_sign_highlight_linenrs = 1

" source other config files
let g:nvim_config_root = stdpath('config')
let g:config_file_list = ['plugins.vim',
            \ 'options.vim',
            \ 'mappings.vim'
            \ ]

for f in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . f
endfor

let g:one_allow_italics=1
colorscheme one
set background=dark

"colorscheme cosmic_latte
