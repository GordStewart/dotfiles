" {{{1 General Options

syntax on                 " Syntax Highlighting
set termguicolors
set hidden                " Allow buffer switching without saving
set mouse=a               " Automatically enable mouse usage
set mousehide             " Hide the mouse cursor while typing
filetype plugin indent on " Automatically detect file types
set encoding=utf-8        " Set default encoding
set nowrap                " Do not wrap long lines
set noshowcmd               " Show partial commands in status line & Selected characters/lines in visual mode
set title                 " show file in titlebar
set noshowmode            " hides --INSERT--, etc
set complete-=i           " Exclude files completion
set complete+=k            " Include the dictionary completion source

set lazyredraw              " Don't redraw screen when playing macros, etc

" Parens Matching
set showmatch               " Bounce to matching parens when inserted
set matchtime=3             " Time for showmatch (tenths of seconds. default=5)

" Line Numbers
set number
set relativenumber

set ruler
set laststatus=2          " Always show status line

" Folding
set foldcolumn=1          " Need to check if works with gitgutter
" What should trigger automatic fold opening?:
set foldopen-=block
set foldopen-=hor
set foldopen+=jump

set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start
set shortmess+=c                      " don't give |ins-completion-menu| messages. [from coc.nvim]

set timeoutlen=500

" Dictionary
set dictionary=/usr/share/dict/words   " Sudo apt install wbritish

" text settings
set textwidth=80   "  Auto wrap comments at 80 characters
set display+=lastline           " Show as much as possible of the last line"

" Show invis chars when :list is used
set listchars+=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
set showbreak=↳                   "Char to show when :wrapping text
set linebreak                     " Don't break mid-word when using :wrap

" navigation
set backspace=indent,eol,start " Backspace for dummies
set cursorline
set scrolloff=5     " minimum number of lines above & below cursor
set sidescroll=3
set sidescrolloff=5

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

" Search
set ignorecase      " Ignore case in search patterns & tags files
set smartcase       "if search has uppercase then use case sensitive search
set incsearch       " Highlight dynamically as pattern is typed"
set hlsearch        "hilight searches by default
set tagcase=followscs   " Follows smartcase & ignorecase when searching tags

" Splits
"More natural split opening
set splitbelow    " Puts new split windows to the bottom of the current
set splitright    " Puts new vsplit windows to the right of the current

" Completion
set wildmenu " Show list instead of just completing
set wildmode=longest:full,list:full,full
set wildignore+=*.pyc,*.png,*.jpg,*.gif,*.zip

" PopUpMenu
set pumblend=10           " PopUpMenu transparency [0-30 works best]
set pumheight=25          " Height of Pop-Up-Menu in lines

" Insert-Completion
set completeopt+=menuone       " Use pum when only one match (for context info)
set completeopt+=noinsert      " Only insert item when picked from menu
set completeopt+=preview      " Show extra information
set infercase                  " Adjust case depending on typed text

set clipboard+=unnamedplus

" backup/swap/undo
" Some language servers have issues with backup files, see #648
set nobackup
set nowritebackup

set undodir=/home/gordon/.config/nvim/tmp/undo/
set undodir+=.
set undofile

set directory=/home/gordon/.config/nvim/tmp/swap//
set directory+=.
set swapfile

set shada=!,'100,<500,:10000,/10000,s10,h
set shadafile=/home/gordon/.config/nvim/tmp/main.shada

" Don't: autowrap comments [c], auto-insert comment leader after <Enter> in insert [r], or <o> in Normal [0]
set formatoptions-=o
set formatoptions-=r
set formatoptions-=c
set formatoptions+=n          " Smart auto-indent on numbered lists
set formatoptions+=1          " Don't break a line after a 1 letter word

set visualbell

" Better display for messages
set cmdheight=2

set colorcolumn=+1 " Make it obvious where 80 characters is"

" You will have bad experience for coc.diagnostic info when it's default 4000.
set updatetime=100
set autoread      " Automatically re-read a file changed outside of vim
set history=10000   "increase history from default (20) to 10000
set path+=**       " provides tab-completion for all file-related tasks (Search down into subfolders)

" always show signcolumns
set signcolumn=yes

" live preview the :substitute command
if has("nvim")
    set inccommand=nosplit
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

set fillchars=stl:\ ,stlnc:\ ,vert:│,fold:\ ,diff:-

" python-syntax
let g:python_highlight_all=1

let g:markdown_fenced_languages = ['html', 'python', 'vim', 'help']

" Status line
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" {{{1 Autocommands

augroup AutocmdGroup
  autocmd BufNewFile *.gitignore 0r ~/.config/nvim/templates/=template=.gitignore
  autocmd BufNewFile *.py 0r ~/.config/nvim/templates/=template=.py

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Relative numbers off in Insert mode
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber

  " AutoChdir
  " autocmd BufEnter * silent! lcd %:p:h

  " EqualWindowsSize
  autocmd VimResized * exec "normal \<C-w>="

  " LastPosition
  autocmd BufReadPost,BufWinEnter *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" | execute 'silent! ' . line("'\"") . 'foldopen!' | endif

  " KeywordHighlight
  autocmd Syntax *
    \ call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)') |
    \ call matchadd('Todo',  '\W\zs\(NOTE\|Note\|INFO\|IDEA\|NOTICE\)') |
    \ call matchadd('Debug', '\W\zs\(Debug\|DEBUG\)') |

  " ParenthesisColor:
  "autocmd VimEnter,BufWinEnter *
    "\ if index(['html', 'htmldjango', 'tex', 'mma'], &filetype) < 0 |
      "\ syntax match paren1 /[{}]/   | hi paren1 guifg=#FF00FF |
      "\ syntax match paren2 /[()]/   | hi paren2 guifg=#DF8700 |
      "\ syntax match paren3 /[<>]/   | hi paren3 guifg=#0087FF |
      "\ syntax match paren4 /[\[\]]/ | hi paren4 guifg=#00FF5F |
    "\ endif

  "Vista fzf search with /
  autocmd FileType vista,vista_kind
    \ nnoremap <buffer> <silent> / :<c-u>call vista#finder#fzf#Run()<CR>

augroup END

augroup MyColors
  " Clears / changes certain syntax highlights any time a colorscheme is sourced
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" coc.nvim
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,html,htmldjango setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" WSL yank support v2
if system('uname -r') =~ "Microsoft"
  let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
  if executable(s:clip)
      augroup WSLYank
          autocmd!
          autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
  endif
endif
"augroup TooLong
"    autocmd!
"    autocmd winEnter,BufEnter * call clearmatches() | call matchadd('ColorColumn', '\%>80v', 100)
"augroup END

" {{{1 Plugin Options

" {{{2 FZF

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

" {{{2 Vista

let g:airline_powerline_fonts = 1
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
  	\ 'vim': 'coc',
  	\ 'python': 'coc',
  	\ }
let g:vista_sidebar_width=35
let g:vista_echo_cursor_strategy = 'echo'
let g:vista_fzf_preview = ['right:50%']
let g:vista_icon_indent = ['╰─▸ ', '├─▸ ']
let g:vista_close_on_jump = 1
let g:vista#renderer#enable_icon = 1
" {{{2 coc + extensions


command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" {{{3 coc-explorer
let g:coc_explorer_global_presets = {
    \   '.vim': {
    \      'root-uri': '~/.config/nvim',
    \   },
    \   'floating': {
    \      'position': 'floating',
    \   },
    \   'floatingLeftside': {
    \      'position': 'floating',
    \      'floating-position': 'left-center',
    \      'floating-width': 50,
    \   },
    \   'floatingRightside': {
    \      'position': 'floating',
    \      'floating-position': 'left-center',
    \      'floating-width': 50,
    \   },
    \   'simplify': {
    \     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
    \   }
    \ }

" {{{2 Semshi
let g:semshi#error_sign = 0
let g:semshi#always_update_all_highlights = v:true

" {{{2 Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" {{{2 Startify
let g:startify_custom_header = []
let g:startify_lists = [
        \ { 'type': 'sessions',  'header': [" \ue62e Sessions"]       },
        \ { 'type': 'bookmarks', 'header': [" \uf5c2 Bookmarks"]      },
        \ { 'type': 'files',     'header': [" \ufa1eMRU Files"]            },
        \ { 'type': 'dir',       'header': [" \ufa1eMRU Files in ". getcwd()] },
        \ { 'type': 'commands',  'header': [" \ufb32 Commands"]       },
        \ ]

let g:startify_bookmarks = [
  \  {'c': '~/.config/nvim/init.vim'}, '~/.zshrc', '~/.tmux.conf']

let g:startify_commands = [
  \  ':FZF ~/.oh-my-zsh/custom/',
  \  ':FZF ~/.config/nvim/',
  \ ]

let g:startify_use_env = 0          " Show environment variable if shorter
let g:startify_update_oldfiles = 1  " Update v:oldfiles on the fly
let g:startify_skiplist = [
            \ '^/tmp',
            \ ]
highlight StartifySlash guifg=#56b6c2


" {{{2 WhichKey
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
let g:which_key_use_floating_win = 1
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}
let g:which_key_floating_relative_win = 1
call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
"nnoremap <silent> [             :<c-u>WhichKey '['<CR>

" Define prefix dictionary
let g:which_key_map =  {}

" Second level dictionaries:
" 'name' is a special field. It will define the name of the group, e.g., leader-f is the "+file" group.
" Unnamed groups will show a default empty string.

" =======================================================
" Create menus based on existing mappings
" =======================================================
" You can pass a descriptive text to an existing mapping.
let g:which_key_map.b = {
    \ 'name' : 'buffers',
    \ 'b' : 'Fuzzy buffers',
    \ 'd' : 'delete current buffer',
    \ 'n' : 'next buffer',
    \ 'p' : 'previous buffer',
    \ 'h' : 'home (Startify)',
    \ 'Y' : 'Copy whole buffer to clipboard',
    \ }

let g:which_key_map.c = {
    \ 'name' : 'Comment',
    \ 'Space' : 'Toggle comment (via topmost line)',
    \ 'c' : 'Comment out',
    \ 'i' : 'Invert Comment',
    \ 'u' : 'Uncomment',
    \ 'y' : 'Yank, then Comment',
    \ 'A' : 'Comment, then insert at end of line',
    \ }

let g:which_key_map.f = {
    \ 'name' : 'File',
    \ 's' : 'Save current file',
    \ 'S' : 'Save all files',
    \ '?' : 'Files in current directory',
    \ 'f' : 'Files in home directory',
    \ 'R' : 'Reloads nvim config',
    \ }

let g:which_key_map.g = {
    \ 'p' : 'select last paste',
    \ }

let g:which_key_map.j = {
    \ 'name': 'Jumping & Joining',
    \ '0': 'Jump to beginning of line + set mark at previous location',
    \ '$': 'Jump to end of line + set mark at previous location',
    \ 'b': 'Jump backwards <-',
    \ 'f': 'Jump forwards ->',
    \ }

let g:which_key_map.l = {
    \ 'name' : 'LSP functions',
    \ 'f': 'format',
    \ 'h': 'hover',
    \ 'd': 'Go to definition',
    \ 'r': 'Go to references',
    \ 'i': 'Go to implementation',
    \ 's': 'symbols in document',
    \ 'S': 'symbols in workspace',
    \ }

let g:which_key_map.q = {
    \ 'name': 'quit',
    \ }


let g:which_key_map.Q = {
    \ 'name': 'Quit, without saving',
    \ }


let g:which_key_map.t = {
    \ 'name': 'Toggle',
    \ 'i': 'indentation lines',
    \ 'l': ':list mode [show tabs, trailing spaces, etc]',
    \ 'n': 'line numbers',
    \ 'r': 'relative line numbers',
    \ 'c': 'conceal level',
    \ }

let g:which_key_map.x = {
   \ 'name': 'Text Manipulation',
   \ 'a': 'EasyAlign',
   \ 'i': {
      \ 'name': 'Case',
      \ 'c': 'change symbol to camelCase',
      \ }
   \ }

let g:which_key_map.w = {
    \ 'name': 'Windows',
    \ '=': 'Balance Split Windows',
    \ 'm': 'Maximize Window',
    \ 'v': 'Vertical Split',
    \ 'c': 'Close Window',
    \ 'h': 'Move to Window on left',
    \ 'l': 'Move to Window on right',
    \ 'k': 'Move to Window on top',
    \ 'j': 'Move to Window on bottom',
    \ 'H': 'Move Window to left',
    \ 'L': 'Move Window to right',
    \ 'K': 'Move Window to top',
    \ 'J': 'Move Window to bottom',
    \ }

" {{{2 vim-clap
let g:clap_layout = { 'relative': 'editor' }
let g:clap_theme = 'material_design_dark'

" {{{2 Asyncrun
let g:asyncrun_open = 8
" Opens window automatically when text adds to it
augroup vimrc
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
augroup END

" {{{2 GitGutter
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▌'
let g:gitgutter_sign_modified_removed = '∙'
let g:gitgutter_grep_command = executable('rg') ? 'rg' : 'grep'

" {{{2 ALE
let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lsp_show_message_severity = 'information'
"let g:ale_virtualtext_cursor = 1
let g:ale_set_highlights = 1
let g:ale_sign_warning = ""
let g:ale_sign_error = ''
let g:ale_sign_info = ''
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str='Error'
let g:ale_echo_msg_info_str='Info'
let g:ale_echo_msg_warning_str='Warning'
let g:ale_echo_msg_format = '¦%severity%¦ %linter% % [code] % %s'
let g:ale_fixers = {
      \   '*'         : ['remove_trailing_lines', 'trim_whitespace'],
      \}

" {{{2 Peekaboo
let g:peekaboo_window="call util#createCenteredFloatingWindow()"

" {{{2 indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['markdown','text','help']
" {{{2 nerdcommenter
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_htmldjango = 1
"let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" {{{2 Crease
set fillchars=fold:\ " space
let g:crease_foldtext = { 'default': '+-%{repeat("-", v:foldlevel)} %l lines: %t ' }

" {{{2 vim-auto-save
let g:auto_save=1                     " enable Autosave on Nvim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

" {{{2 Goyo
function! s:goyo_enter() abort
  "Limelight
  if exists('$TMUX')
    silent !tmux set -g status off
    "silent !tmux set -g pane-border-status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set scrolloff=999
endfunction

function! s:goyo_leave() abort
  "Limelight!
  if exists('$TMUX')
    silent !tmux set -g status on
    "silent !tmux set -g pane-border-status top
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set scrolloff=5
endfunction

augroup MyGoyo
  autocmd!
  autocmd User GoyoEnter call <SID>goyo_enter()
  autocmd User GoyoLeave call <SID>goyo_leave()
augroup END


" {{{1 Functions

" {{{2 Text Manipulation
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

" {{{2 Toggles

function! ToggleConceal()
  " 0=falsy, any other number = truthy
  if &conceallevel<3
    let &conceallevel = &conceallevel + 1
    set conceallevel?
    echo &conceallevel
  elseif &conceallevel==3
    set conceallevel=0
    echo "Conceal=" . &conceallevel . " Text shown normally"
  endif
endfunction

" {{{2 ColorScheme Highlight Overrides

function! MyHighlights() abort
  " Called by an autocmd whenever a colorscheme is sourced; Fixes weird colours
  highlight Normal guibg=None
  highlight SignColumn guibg=None
  highlight Folded guibg=None guifg=#5C6370
endfunction
