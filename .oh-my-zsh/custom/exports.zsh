PATH=${PATH}:/usr/local/bin
PATH=${PATH}:/usr/bin
PATH=${PATH}:/bin
PATH=${PATH}:/usr/sbin
PATH=${PATH}:/sbin
PATH=${PATH}:"/usr/local/sbin"
PATH=${PATH}:"/home/gordon/.dotfiles/bin"
PATH=${PATH}:"/home/gordon/.local/bin"
PATH=${PATH}:"/home/gordon/neovim/bin"
PATH=${PATH}:"/mnt/c/Windows/System32"

export -U PATH=${PATH}

export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER="vim -c MANPAGER -"
export EDITOR="nvim"

# Show time a command took if over 4 sec
# export REPORTTIME=4
# export TIMEFMT="%*Es total, %U user, %S system, %P cpu"

# colour for less
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# This affects every invocation of `less`.
#
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS=-iRFXMx4

# X Display server for WSL
# export DISPLAY=192.168.1.179:0.0

if [[ "$(</proc/version)" == *icrosoft* ]] 2>/dev/null; then
  export WSL=1
  export DISPLAY=192.168.1.179:0.0
  export NO_AT_BRIDGE=1
  export LIBGL_ALWAYS_INDIRECT=1
fi

# Cheat
export CHEAT_COLORS=true
export CHEAT_COLORSCHEME=dark # light or dark

FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules --color=always"
# fzf , use fd as default find
export FZF_DEFAULT_COMMAND='git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS'
export FZF_DEFAULT_OPTS="--height 50% -1 --multi --reverse --info=inline --ansi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | xclip -selection clipboard)'"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
#export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

# Adding Folders to python path
export PYTHONPATH="/mnt/c/Users/Gordon/Documents/Code/Python/scripts/"

# python venv + virtualenvwrapper
export WORKON_HOME=$HOME/.venvs
export PROJECT_HOME=/mnt/c/Users/Gordon/Documents/Code/Python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
