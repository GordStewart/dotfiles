"{ Key Mappings

"{{ Main
map <space> <leader>

inoremap jj <esc>
inoremap jk <esc>
nnoremap ; :

" redo
nnoremap U <C-r>

nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
"}}


"{{ Files [f]
nnoremap <silent> <leader>fs :update<CR>
nnoremap <leader>f? :Files<CR>
nnoremap <leader>ff :Files ~/<CR>
nnoremap <Leader>fR :source ~/.config/nvim/init.vim<CR>
"}}


"{{ Buffers [b]
nnoremap <leader>bb :Clap buffers<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bh :Startify<CR>
"}}

"{{ LSP Functions [l]
nnoremap <leader>lf :call CocAction('format')<CR>
nnoremap <leader>lh :call CocAction('doHover')<CR>
nmap <silent> <Leader>ld <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>li <Plug>(coc-implementation)
nmap <silent> <Leader>lr <Plug>(coc-references)
" Find symbol of current document
nnoremap <silent> <Leader>ls  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <Leader>lS  :<C-u>CocList -I symbols<cr>
"}}

"{{ Toggle [t]
nnoremap <leader>ti :IndentLinesToggle<CR>
nnoremap <Leader>tn :set number!<CR>
nnoremap <Leader>tr :set relativenumber!<CR>
nnoremap <Leader>tgl :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>tgn :GitGutterLineNrHighlightsToggle<CR>
nnoremap <Leader>tgs :GitGutterSignsToggle<CR>
nnoremap <Leader>tc :call ToggleConceal()<CR>
nnoremap <silent> <Leader>tp :setlocal paste!<CR>
"}]}

"{{ Windows [w]
nnoremap <leader>wm <C-w><bar>
nnoremap <leader>w= <C-w>=
nnoremap <leader>wv :vsp<CR>
nnoremap <leader>wc <C-w>c
nnoremap <leader>wh <C-w>h
nnoremap <leader>wH <C-w>H
nnoremap <leader>wl <C-w>l
nnoremap <leader>wL <C-w>L
nnoremap <leader>wk <C-w>k
nnoremap <leader>wK <C-w>K
nnoremap <leader>wj <C-w>j
nnoremap <leader>wJ <C-w>J

for s:i in range(1, 9)
  " <Leader>[1-9] move to window [1-9]
  execute 'nnoremap <Leader>'.s:i ' :'.s:i.'wincmd w<CR>'

  " <Leader><leader>[1-9] move to tab [1-9]
  execute 'nnoremap <Leader><Leader>'.s:i s:i.'gt'

  " <Leader>b[1-9] move to buffer [1-9]
  execute 'nnoremap <Leader>b'.s:i ':b'.s:i.'<CR>'
endfor
unlet s:i

"}}

"{{ QuickFix Window
noremap <leader>ql :call asyncrun#quickfix_toggle(8)<cr>
"}}
"
"{{ Text manipulation [x]
xmap <Leader>xa <Plug>(EasyAlign)
nmap <Leader>xa <Plug>(EasyAlign)

nmap <Leader>xic crc
nmap <Leader>xim crm
"}}

"{{ Function Keys

set pastetoggle=<F3>

nnoremap <F5> :MundoToggle<CR>

map <silent> <F6> :CocCommand explorer --preset floating<CR>

" toggle Fold open/close
nnoremap <Space><Space> za

" toggle Vista
" noremap  <silent> <F10>           <Esc>:call util#toggleWindows('vista')<CR>
" noremap! <silent> <F10>           <Esc>:call util#toggleWindows('vista')<CR>
nnoremap <silent> <F10> :Vista!!<CR>

" <F12> is assigned to FloatermToggle [Floaterm section]
"}}

"{{ Movement / Scrolling

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Wrapped lines go up/down to next row, rather than next line
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk

" Scrolling
" increase scroll amounts
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" move to the start of line
nnoremap H ^
" move to the end of line
nnoremap L $

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

" FZF Keys
" nnoremap <silent> <space>b :Buffers<CR>
" nnoremap <silent> <space>f :Files<CR>
" nnoremap <silent> <space>F :Files ~/<CR>
nmap <Leader>? <plug>(fzf-maps-n)

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
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)


" Using CocList

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>


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


"{{ WhichKey
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"}}

"{{ Floaterm
nnoremap <silent> <F12>     :FloatermToggle<CR>
tnoremap <silent> <F12>     <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <leader>' :FloatermNew<CR>
"}}

"} End of Key Mappings
