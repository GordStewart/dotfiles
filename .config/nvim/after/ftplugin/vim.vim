setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=\"\ %s
setlocal nospell

" Folding
setlocal foldmethod=expr
setlocal foldexpr=VimFolds(v:lnum)
setlocal foldtext=MyFoldText()


" coc-pairs
let b:coc_pairs_disabled = ['"']

" vim-argwrap
let b:argwrap_line_prefix = '\'

let b:argwrap_tail_indent_braces = '('

let b:ale_linters = ['vint']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
