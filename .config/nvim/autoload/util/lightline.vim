" =============================================================
" Description: autoload/util/lightline.vim
"
" Taken from GitHub: https://github.com/voldikss/dotfiles

" LightlineAbsolutePath:
function! util#lightline#absPath()
  let path = substitute(expand('%:p'), $HOME, '~', 'g')
  if len(path) > winwidth(0)/2.5
    let path = pathshorten(path)
    if len(path) > winwidth(0)/2.5
      return ''
    endif
  endif
  return path
endfunction

" LightlineMode:
function! util#lightline#mode()
  return &filetype ==# 'coc-explorer' ? 'coc-explorer' :
    \ &filetype ==# 'help' ? 'Help' :
    \ &filetype ==# 'man' ? 'Man' :
    \ &filetype ==# 'qf' && !getwininfo(win_getid(winnr()))[0]['loclist'] ? 'QuickFix' :
    \ &filetype ==# 'qf' && getwininfo(win_getid(winnr()))[0]['loclist'] ? 'Location List' :
    \ &filetype ==# 'startify' ? 'Startify' :
    \ &filetype ==# 'Mundo' ? 'Mundo' :
    \ expand('%:t') =~ '__vista__' ? 'Vista' :
    \ lightline#mode()
endfunction

" LightlineFilename:
function! util#lightline#fileName()
  let filename = &filetype ==# 'denite' ? '' :
    \ &filetype ==# 'help' ? '' :
    \ &filetype ==# 'man' ? '' :
    \ &filetype ==# 'startify' ? '' :
    \ &filetype ==# 'Mundo' ? '' :
    \ expand('%:t') =~ '__Tagbar__\|__vista__' ? '' :
    \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' ' : ''
  return filename . modified
endfunction

" LightlineFileFormat:
function! util#lightline#fileFormat()
  if &fileformat is 'unix'
    return ''
  else
    return &filetype !=# 'denite' &&
      \ &filetype !=# 'gitv' &&
      \ &filetype !=# 'help' &&
      \ &filetype !=# 'man' &&
      \ &filetype !=# 'qf' &&
      \ &filetype !=# 'startify' &&
      \ &filetype != 'Mundo' &&
      \ expand('%:t') !~ '__Tagbar__\|__vista__' &&
      \ winwidth(0) > 70
      \ ? &fileformat : ''
  endif
endfunction

" LightlineFiletype:
function! util#lightline#fileType()
  return &filetype !=# 'denite' &&
    \ &filetype !=# 'gitv' &&
    \ &filetype !=# 'help' &&
    \ &filetype !=# 'man' &&
    \ &filetype !=# 'qf' &&
    \ &filetype !=# 'startify' &&
    \ &filetype !=# 'Mundo' &&
    \ expand('%:t') !~ '__Tagbar__\|__vista__' &&
    \ winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
endfunction

" LightlineFileEncoding:
function! util#lightline#fileEncoding()
  return &filetype !=# 'denite' &&
    \ &filetype !=# 'gitv' &&
    \ &filetype !=# 'help' &&
    \ &filetype !=# 'man' &&
    \ &filetype !=# 'qf' &&
    \ &filetype !=# 'startify' &&
    \ &filetype !=# 'Mundo' &&
    \ expand('%:t') !~ '__Tagbar__\|__vista__' &&
    \ winwidth(0) > 70
    \ ? &fileencoding : ''
endfunction

" LightlineReadonly:
function! util#lightline#readOnly()
  return &readonly && &filetype !~# '\v(denite|help|man|qf|startify)' && expand('%:t') !~ ('__Tagbar__\|__vista__') ? '' : ''
endfunction

" GitBranch:
function! util#lightline#GitBranch()
  " if exists('*fugitive#head') && &filetype !~# '\v(denite|help|man|qf|tagbar|Mundo|vista)'
  if &filetype !~# '\v(denite|help|man|qf|tagbar|Mundo|vista)'
    let branch = FugitiveHead()
    return branch !=# '' ? ''. branch : ''
  endif
  return ''
endfunction

" coc.nvim status & diagnostic
function! util#lightline#cocStatus()
  let info = get(b:, 'coc_diagnostic_info', {})
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, s:error_sign . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, s:warning_sign . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" ALE
function! util#lightline#LinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ', all_non_errors)
endfunction

function! util#lightline#LinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ', all_errors)
endfunction

function! util#lightline#LinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : ''
endfunction
