PATH=${PATH}:/usr/local/bin
PATH=${PATH}:/usr/bin
PATH=${PATH}:/bin
PATH=${PATH}:/usr/sbin
PATH=${PATH}:/sbin
PATH=${PATH}:"/usr/local/sbin"
PATH=${PATH}:"/home/gordon/.dotfiles/bin"
PATH=${PATH}:"/home/gordon/.local/bin"

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

# X Display server for WSL
export DISPLAY=localhost:0.0

# Cheat
export CHEAT_COLORS=true
export CHEAT_COLORSCHEME=dark # light or dark

# fzf , use fd as default find
export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --color=always --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type d . "
export FZF_DEFAULT_OPTS="--multi --reverse --ansi"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

# Adding Folders to python path
export PYTHONPATH="/mnt/c/Users/Gordon/Documents/Code/Python/scripts/"

# python virtualenv + virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=/mnt/c/Users/Gordon/Documents/Code/Python
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6
