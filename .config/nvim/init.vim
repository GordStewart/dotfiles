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
" hi Error NONE

" let g:one_allow_italics=1
" colorscheme one
" let g:afterglow_italic_comments=1
" colorscheme afterglow
" colorscheme OceanicNext
set background=dark

"let g:material_terminal_italics = 1
"let g:material_theme_style = 'darker'
"colorscheme material
"Best so far:
colorscheme cosmic_latte
