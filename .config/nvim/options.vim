"{ General Options

syntax on           " Syntax Highlighting
set termguicolors
set hidden " Allow buffer switching without saving"
set mouse=a
filetype plugin indent on  " Automatically detect file types
set encoding=UTF-8
set nowrap
set showcmd         " Show partial commands in status line and Selected characters/lines in visual mode
set title           " show file in titlebar
set noshowmode      " hides --INSERT--, etc
set number
set relativenumber
set laststatus=2    " Always show status line

"disable intro message
set shortmess=I
set shortmess=a

"Dictionary
set dictionary=/usr/share/dict/words

" text settings
set textwidth=80   "  Auto wrap comments at 80 characters
set display=lastline           " Show as much as possible of the last line"

" navigation
set backspace=indent,eol,start " Backspace for dummies"
set cursorline
set scrolloff=4
set sidescroll=5

" Tabs
set smarttab        " Smart Tab
set tabstop=4       " An indentation every four columns"
set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc."
set softtabstop=4   " Automatically inserts indentation in some cases
set expandtab       " Expands tabs to spaces
set smartindent     " Automatically inserts indentation in some cases
set autoindent      " Indent at the same level of the previous line
set breakindent
set breakindentopt=shift:2
set showbreak=↳

" Search
set infercase
set smartcase       "if search has uppercase then use case sensitive search
set incsearch       " Highlight dynamically as pattern is typed"
set hlsearch        "hilight searches by default

" Splits
"More natural split opening
set splitbelow
set splitright

" Completion
:set wildmenu
set wildmenu
set wildmode=longest,list,full

set clipboard+=unnamedplus

" backup/swap/undo
" Some language servers have issues with backup files, see #649
set nobackup
set nowritebackup
set undofile
set swapfile

" Don't create comment when pressing enter after commented line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Better display for messages
set cmdheight=2

set colorcolumn=+1 " Make it obvious where 80 characters is"
set background=dark
set termguicolors

" You will have bad experience for coc.diagnostic info when it's default 4000.
set updatetime=100
set autoread      " Automatically re-read a file changed outside of vim
set history=10000   "increase history from default (20) to 10000
set path+=**       " provides tab-completion for all file-related tasks (Search down into subfolders)
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" live preview the :substitute command
if has("nvim")
    set inccommand=nosplit
endif

" python-syntax
let g:python_highlight_all=1

let g:markdown_fenced_languages = ['html', 'python']
let g:only_one_win = 1
let g:windows_toggle = {
  \ 'coc-explorer': {
    \ 'open': 'CocCommand explorer',
    \ 'close': 'CocCommand explorer'
  \ },
  \ 'vista': {
    \ 'open':'Vista',
    \ 'close': 'Vista!'
  \ },
  \ 'qf': {
    \ 'open': 'OpenQf',
    \ 'close': 'cclose'
  \ },
  \ 'Mundo': {
    \ 'open': 'MundoToggle',
    \ 'close': 'MundoToggle'
  \ },
  \ 'terminal': {
    \ 'open': 'FloatermToggle',
    \ 'close': 'FloatermToggle'
  \ }
\ }
"}

" Status line
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

"{ Autocommands

augroup AutocmdGroup
  autocmd BufNewFile *.gitignore 0r ~/.config/nvim/templates/=template=.gitignore
  autocmd BufNewFile *.py 0r ~/.config/nvim/templates/=template=.py

" SaveBuffer
  autocmd BufWrite *.py call CocAction('format')
  autocmd BufWrite * call util#autoSave()

" AutoChdir
" autocmd BufEnter * silent! lcd %:p:h

" EqualWindowsSize
autocmd VimResized * exec "normal \<C-w>="

" LastPosition
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \ exe "normal! g'\"" |
    \ endif

  " KeywordHighlight
  autocmd Syntax *
    \ call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)') |
    \ call matchadd('Todo',  '\W\zs\(NOTE\|Note\|INFO\|IDEA\|NOTICE\)') |
    \ call matchadd('Debug', '\W\zs\(Debug\|DEBUG\)') |


" Make system clipboard accessible usin wsl
if system('uname -r') =~ "Microsoft"
" if has('wsl') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ',@")
  augroup END
endif


"{{ ParenthesisColor:
  autocmd VimEnter,BufWinEnter *
    \ if index(['html', 'htmldjango', 'tex', 'mma'], &filetype) < 0 |
      \ syntax match paren1 /[{}]/   | hi paren1 guifg=#FF00FF |
      \ syntax match paren2 /[()]/   | hi paren2 guifg=#DF8700 |
      \ syntax match paren3 /[<>]/   | hi paren3 guifg=#0087FF |
      \ syntax match paren4 /[\[\]]/ | hi paren4 guifg=#00FF5F |
    \ endif
"}}

augroup END
"}

"{ Plugin Options

"{{ Lightline
let g:lightline = { 'colorscheme': 'edge', }
let g:lightline.separator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }
" let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
" let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

" function! Devicons_Filetype()"{{{
"     return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
"     " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
" endfunction"}}}

" function! Devicons_Fileformat()"{{{
"     return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
" endfunction"}}}

" function! coc#status()
"   let info = get(b:, 'coc_diagnostic_info', {})
"   let msgs = []
"   if get(info, 'error', 0)
"     call add(msgs, s:error_sign . info['error'])
"   endif
"   if get(info, 'warning', 0)
"     call add(msgs, s:warning_sign . info['warning'])
"   endif
"   return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
" endfunction

function! LightLineCoc()
  if empty(get(g:, 'coc_status', '')) && empty(get(b:, 'coc_diagnostic_info', {}))
    return ''
  endif
  return trim(coc#status())
endfunction

let g:lightline.inactive = {
            \ 'left': [ [ 'filename' ]],
            \ 'right': [ [ 'lineinfo' ],
            \ ['filetype', 'fileformat' ] ]
            \ }

let g:lightline.component = {
            \ 'percent': '%2p%%',
            \ 'lineinfo': '%2p%% %3l:%-2v ',
            \ 'vim_logo': "\ue7c5",
            \ }

let g:lightline.component_function = {
      \   'cocstatus': 'LightLineCoc',
      \   'mode': 'util#lightline#mode',
      \   'readonly': 'util#lightline#readOnly',
      \   'filename': 'util#lightline#fileName',
      \   'fileformat': 'util#lightline#fileFormat',
      \   'fileencoding': 'util#lightline#fileEncoding',
      \   'filetype': 'util#lightline#fileType',
      \   'absolutepath': 'util#lightline#absPath',
      \   'gitbranch': 'util#lightline#GitBranch',
      \ }

let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'gitbranch', 'readonly', 'filename', 'cocstatus'] ],
            \ 'right': [ [ 'lineinfo' ],
            \            ['filetype', 'fileformat' ] ]
            \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"}}

"{{ FZF

let g:fzf_files_options = '--reverse --preview "bat --color always --style numbers {}"'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Using floating windows of Neovim to start fzf

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

"}}

"{{ Vista

let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
"}}

"{{ Asyncrun
let g:asyncrun_open = 8
"}}

"{{ coc + extensions
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"}}

"{{ Semshi
let g:semshi#error_sign = 0
"}}

"{{ Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'
"}}

"{{ Startify
let g:startify_custom_header = []
let g:startify_lists = [
        \ { 'type': 'sessions',  'header': [" \ue62e Sessions"]       },
        \ { 'type': 'bookmarks', 'header': [" \uf5c2 Bookmarks"]      },
        \ { 'type': 'files',     'header': [" \ufa1eMRU Files"]            },
        \ { 'type': 'dir',       'header': [" \ufa1eMRU Files in ". getcwd()] },
        \ { 'type': 'commands',  'header': [" \ufb32 Commands"]       },
        \ ]

let g:startify_bookmarks = [
  \  {'c': '~/.config/nvim/init.vim'}]

let g:startify_commands = [
  \  ':FZF ~/dotfiles/zsh',
  \  ':FZF ~/dotfiles/zsh',
  \  ':FZF ~/.config/nvim/',
  \  ':FZF ~/dotfiles/scripts']
"}}

" End Plugin Options
"}



"{ Functions

"{{ Folding

" For vim files only
function! VimFolds(lnum)
    " get content of current line and the line below
    let l:cur_line = getline(a:lnum)
    let l:next_line = getline(a:lnum+1)

    if l:cur_line =~# '^"{'
        return '>' . (matchend(l:cur_line, '"{*') - 1)
    else
        if l:cur_line ==# '' && (matchend(l:next_line, '"{*') - 1) == 1
            return 0
        else
            return '='
        endif
    endif
endfunction

function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction

"set foldmethod=expr
"set foldexpr=VimFolds(v:lnum)
"set foldtext=MyFoldText()
""Note that there is a <space> character after the slash
"set fillchars=fold:
"}}


" Customized version of folded text, idea by
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText(string) "{{{1
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif
    let pat  = matchstr(&l:cms, '^\V\.\{-}\ze%s\m')
    " remove leading comments from line
    let line = substitute(line, '^\s*'.pat.'\s*', '', '')
    " remove foldmarker from line
    let pat  = '\%('. pat. '\)\?\s*'. split(&l:fmr, ',')[0]. '\s*\d\+'
    let line = substitute(line, pat, '', '')

"   let line = substitute(line, matchstr(&l:cms,
"	    \ '^.\{-}\ze%s').'\?\s*'. split(&l:fmr,',')[0].'\s*\d\+', '', '')

    if get(g:, 'custom_foldtext_max_width', 0)
	let w = g:custom_foldtext_max_width - &foldcolumn - (&number ? 8 : 0)
    else
	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    endif
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = '+'. v:folddashes
    let lineCount = line("$")
    if has("float")
	try
	    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
	catch /^Vim\%((\a\+)\)\=:E806/	" E806: Using Float as String
	    let foldPercentage = printf("[of %d lines] ", lineCount)
	endtry
    endif
    if exists("*strwdith")
	let expansionString = repeat(a:string, w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    else
	let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, '.', 'x', 'g')))
    endif
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

let g:custom_foldtext_max_width=89
set foldtext=CustomFoldText('.')
set fillchars=stl:\ ,stlnc:\ ,vert:│,fold:\ ,diff:-




function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv


"
" Switch buffer. Skip buffers already shown in another window.
"
function! Switch_Buffer(cmd) abort
  try
    execute a:cmd
  catch /E85/  " There is no listed buffer
    return
  endtry
  let bufs = tabpagebuflist()
  while !empty(bufs)
    let buf = bufnr('')
    if count(bufs, buf) == 1 | break | endif
    execute a:cmd
    call filter(bufs, 'v:val != '.buf)
  endwhile
  stopinsert
endfunction

"}
