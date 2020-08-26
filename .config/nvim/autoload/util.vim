"{ Window Utilities
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

"{{ CreateCenteredFloatingWindow
function! util#createCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
"}}

"} End Window Utilities

"{ Command Utilities

"{{ Make various list like utilities more intuitive
" Background here: https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86

function! util#CCR()
    let cmdline = getcmdline()
    command! -bar Z silent set more|delcommand Z
    if getcmdtype() != ':'
        return "\<CR>"
    endif
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:Z|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:Z|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:Z|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction

"}}


"{{ Redir commands to buffer
function! util#Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call util#Redir(<q-args>, <range>, <line1>, <line2>)

"}}
"}

"{ Text Utilities
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

"{{ Tidy Contents (ISFDB.com):
function! util#TidyContents()
"   silent! execute '%s/ by / • '
    silent! execute 'g/^$/d'
    silent! execute '%s/^    /'
    silent! execute '%s/^\d* • /'
    silent! execute '%s/novella by /na • '
    silent! execute '%s/novelette by /nv • '
    silent! execute '%s/short story by /ss • '
    silent! execute '%s/(\d\{4}) • /'
    silent! execute 'g/• poem \|• essay /d'
endfunction
"}}
"} End Text Utilities

"{ Misc Utilities
"{{ AutoSaveBuffer:
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

"{{ Enhanced <C-A>, <C-X> (increase/decrease number)
function! util#addSubtract(char, back)
  let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw' . a:back)
  execute 'normal! ' . v:count1 . a:char
  silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
endfunction
"}}

"{{ Paste clipboard into whole buffer
function! util#pasteWholeBuffer() abort
  execute 'normal! ggdG'
  execute 'normal! <leader>tpiP'
endfunction
"}}
"} End Misc Utilities
