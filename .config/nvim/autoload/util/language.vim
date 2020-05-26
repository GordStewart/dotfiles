" Infer executable from the first line
function! util#language#inferExecutable() abort
  " #!/usr/bin/env python
  let l:exe = split(getline(1), ' ')[-1]
  if executable(l:exe)
    return l:exe
  endif
  " #!/bin/sh
  let l:exe = split(getline(1), '/')[-1]
  return executable(l:exe) ? l:exe : ''
endfunction

function! util#language#pythonRun()
  let l:cmd = has_key(g:plugs, 'asyncrun.vim') ? 'AsyncRun!' : '!'
  let l:exe = util#language#inferExecutable()
  let l:py = l:exe != '' ? l:exe : get(g:, 'spacevim_python_run', 'python')
  let l:fname = shellescape(@%, 1)
  execute join([l:cmd, l:py, l:fname], ' ')
endfunction
