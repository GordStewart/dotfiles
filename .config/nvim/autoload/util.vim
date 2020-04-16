"{{ toggleWindows
function! util#toggleWindows(winname) abort
  let found_winnr = 0

  for winnr in range(1, winnr('$'))
    let buftype = getbufvar(winbufnr(winnr), '&buftype')
    let filetype = getbufvar(winbufnr(winnr), '&filetype')
    " terminal window: &buftype is 'terminal' but &filetype is ''
    let window = filetype != "" ? filetype : buftype
    if window == a:winname
      let found_winnr = winnr
    " close other windows
    elseif g:only_one_win
      if index(keys(g:windows_toggle), window) >= 0
        execute g:windows_toggle[window]['close']
      elseif index(['leaderf'], window) >=0
        execute winnr . 'wincmd q'
      endif
    endif
  endfor

  if found_winnr > 0
    " close or go to that window(for example, terminal...)
    execute g:windows_toggle[a:winname]['close']
  else
    " open a new window or open that background buffer
    execute g:windows_toggle[a:winname]['open']
  endif
endfunction
"}}


"{{ Remove White Spaces
function! util#removeWhiteSpaces()
  silent! execute '%s/\s\+$//g'
endfunction
"}}


"{{ RemoveBlankLines:
function! util#removeBlankLines() abort
  if !&modifiable
    return
  endif
  let reg_tmp = @"
  while 1
    let endlnum = line('$')
    let endline = getline(endlnum)
    if trim(endline) == '' && endlnum != 1
      execute endlnum . 'd'
    else
      break
    endif
  endwhile
  let @" = reg_tmp
endfunction
"}}

"}} AutoSaveBuffer:
function! util#autoSave() abort
  let curr_pos = getpos('.')
  if getpos('.')[1] != line('$')
    call util#removeBlankLines()
  endif
  if trim(getline('.')) != ''
    call util#removeWhiteSpaces()
  endif
endfunction
  "}}

function! util#TidyContents()
"   silent! execute '%s/ by / • '
    silent! execute '%s/^\d* • /'
    silent! execute '%s/novella by /na • '
    silent! execute '%s/novelette by /nv • '
    silent! execute '%s/short story by /ss • '
    silent! execute '%s/(\d\{4}) • /'
endfunction
