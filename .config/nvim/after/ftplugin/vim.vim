setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=\"\ %s
setlocal nospell

setlocal formatoptions-=cro
" Folding
setlocal foldmethod=marker


" coc-pairs
let b:coc_pairs_disabled = ['"']

" vim-argwrap
let b:argwrap_line_prefix = '\'

let b:argwrap_tail_indent_braces = '('

let b:ale_linters = ['vint']
