"{ Key Mappings

"{{ Main
map , <leader>
inoremap jk <esc>
nnoremap ; :
"}}


"{{ Function Keys

set pastetoggle=<F3>

nnoremap <F5> :MundoToggle<CR>

map <F6> :CocCommand explorer<CR>

" toggle Fold open/close
nnoremap <Space><Space> za

" toggle Vista
noremap  <silent> <F10>           <Esc>:call util#toggleWindows('vista')<CR>
noremap! <silent> <F10>           <Esc>:call util#toggleWindows('vista')<CR>

"}}

"{{ Movement / Scrolling

" Wrapped lines go up/down to next row, rather than next line
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk

" Scrolling
" increase scroll amounts
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Search
"Make searches appear in centre of page
nnoremap n nzz
nnoremap N Nzz
" Clears last Search highlight
nnoremap <CR> :noh<CR>

" Moving between Splits / Windows
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
inoremap <M-h> <Esc><C-w>h
inoremap <M-j> <Esc><C-w>j
inoremap <M-k> <Esc><C-w>k
inoremap <M-l> <Esc><C-w>

" Swap buffers
"nnoremap <silent> <c-p> :call Switch_Buffer('bprevious')<cr>
"nnoremap <silent> <c-n> :call Switch_Buffer('bnext')<cr>
" Use Tab to switch buffer
nnoremap <silent> <c-n> :bn<CR>
nnoremap <silent> <c-p> :bp<CR>



" Make Shift and Insert work in insert mode:
inoremap <silent> <S-Insert> <C-R>+

"Find and Replace in the current File
nnoremap <Leader>r :let @s='\<'.expand('<cword>').'\>'<CR>:%s/<C-r>s//<Left>
xnoremap <Leader>r "sy:%s/<C-r>s//<Left>

" Text Copy
" Y copies from cursor to end of line
nnoremap Y y$

" Saving and Quitting
nnoremap <silent> <Leader>w :w<CR>

" FZF Keys
nnoremap <silent> <space>b :Buffers<CR>
nnoremap <silent> <space>f :Files<CR>
nnoremap <silent> <space>F :Files ~/<CR>


"{{ coc.nvim

"""
" Map <tab> for trigger + completion confirm, snippet expand + jump like VSCode
"inoremap <silent><expr> <TAB>
"	  \ pumvisible() ? coc#_select_confirm() :
"	  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"	  \ <SID>check_back_space() ? "\<TAB>" :
"	  \ coc#refresh()

"""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Cursors
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)

let g:coc_snippet_next = '<tab>'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Using CocList

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>

" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}

"{{ ArgWrap
nnoremap <silent> <leader>a :ArgWrap<CR>
"}}

"} End of Key Mappings
