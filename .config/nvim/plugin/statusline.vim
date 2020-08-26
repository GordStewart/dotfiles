let s:ale_running = 0

hi StatusLine guibg=None
hi User1 guifg=#212121 guibg=#7fa167
hi NormalColour guifg=#212121 guibg=#7fa167
hi InsertColour guifg=#212121 guibg=#4979da
hi VisualColour guifg=#212121 guibg=#c678dd
hi ReplaceColour guifg=#212121 guibg=#e06c75
hi GitBranchColour guifg=#9095a0 guibg=#2c323c
hi FPUnmodifiedColour guifg=#9095a0 guibg=None
hi FPModifiedColour guifg=#e06c75 guibg=None
hi LinterError guifg=#e06c75 guibg=None
hi LinterWarning guifg=#e5c07b guibg=None
hi LinterRunning guifg=#4979da guibg=None
hi LineColumnColour guibg=#3e4452 guifg=#212121
hi StatusFadedColour guifg=#5c6370
hi CommandModeColour guibg=#56b6c2 guifg=#212121

let s:dict_status_colour={
      \ '1': '%#NormalColour#',
      \ '2': '%#InsertColour#',
      \ '3': '%#VisualColour#',
      \ '4': '%#ReplaceColour#',
      \ '5': '%#LinterError#',
      \ '6': '%#LinterWarning#',
      \ '7': '%#GitBranchColour#',
      \ '8': '%#StatusFadedColour#',
      \ '9': '%#LinterRunning#',
      \}

" {{{2 StatusLineRO:
function! StatusLineRO()
  let l:read_only = printf(' %s%s', get(s:dict_status_colour, '5'), functions#GetIcon('read_only'))
  return &readonly && &filetype !~# '\v(help|man|qf|startify)'
        \ && expand('%:t') !~ ('__Tagbar__\|__vista__') ? l:read_only : ''
endfunction

" {{{2 Line / Column / Right hand side
function! StatusLineRHS() abort
  let l:current_line = printf('%02d', line('.'))
  let l:total_line = printf('%s/%02d', get(s:dict_status_colour, '8'), line('$'))
  let l:current_column = printf('%02d', col('.'))
  return winwidth(0) > 80 ? l:current_line . l:total_line . l:current_column : ''
endfunction

" {{{2 Linter status
function! LinterStatus() abort
  if !exists(':ALEInfo')
    return ''
  endif

  let l:error_symbol = functions#GetIcon('linter_error')
  let l:style_symbol = functions#GetIcon('linter_style')
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:status = []

  if l:counts.error
    call add(l:status, printf('%s%s%d %%*', get(s:dict_status_colour, '5'), l:error_symbol, l:counts.error))
  endif
  if l:counts.warning
    call add(l:status, printf('%s%s%d %%*', get(s:dict_status_colour, '6'), l:error_symbol, l:counts.warning))
  endif
  if l:counts.style_error
    call add(l:status, printf('%s%d %s %%*', get(s:dict_status_colour, '5'), l:counts.style_error, l:style_symbol))
  endif
  if l:counts.style_warning
    call add(l:status, printf('%s%d %s %%*', get(s:dict_status_colour, '6'), l:counts.style_warning, l:style_symbol))
  endif

  return join(l:status, ' ')
endfunction

" {{{2 Ale Running Indicator
function! AleRunning() abort
  if (s:ale_running)
    let l:running_text = printf('%s Linting   ', get(s:dict_status_colour, '6'))
  else
   let l:running_text = ''
  endif
  return l:running_text
endfunction

augroup ALEProgress
    autocmd!
    autocmd User ALELintPre  let s:ale_running = 1 | redrawstatus
    autocmd User ALELintPost let s:ale_running = 0 | redrawstatus
augroup END


" {{{2 Get FileName
function! FilePath() abort
	let l:filename = expand('%:t')
  if empty(l:filename)
    return ''
  else
    return filename
  endif
endfunction


" {{{2 Get git branch info from Fugitive
function! GitInfo() abort
  if !exists('*FugitiveHead')
    return ''
  endif
  let l:out = FugitiveHead(10)
  if !empty(l:out)
    let l:out =  ' ' . l:out . ' '
  endif
  return l:out
endfunction


" {{{1 Main statusline function

function! MyStatusLine() abort
  let statusline=''
  let statusline.=(mode()=='n') ? '%#NormalColour# N ':''
  let statusline.=(mode()=='i') ? '%#InsertColour# כֿ ':''
  let statusline.=(mode()=='v') ? '%#VisualColour# V ':''
  let statusline.=(mode()=='V') ? '%#VisualColour#  ':''
  let statusline.=(mode()=='R') ? '%#ReplaceColour# R ':''
  let statusline.=(mode()=='c') ? '%#CommandModeColour#  ':''
  let statusline.='%#GitBranchColour# %{GitInfo()}'
  if &modified
    let statusline.='%#FPModifiedColour# %{FilePath()}'
  else
    let statusline.='%#FPUnmodifedColour# %{FilePath()}'
  endif
  let statusline.=StatusLineRO()
  let statusline.='%#StatusFadedColour#'
  let statusline.='%{coc#status()}'
  let statusline.='%='
  let statusline.=AleRunning()
  let statusline.='%*'
  let statusline.=LinterStatus()
  let statusline.=StatusLineRHS()
  let statusline.='%*'
  return statusline
endfunction

function! Colour(num, content) abort
   return '%' . a:num . '*' . a:content . '%*'
 endfunction

" {{{2
"------------------------------------------------------------------------------
" STATUS LINE CUSTOMIZATION
"------------------------------------------------------------------------------
set statusline=
set statusline=%!MyStatusLine()
