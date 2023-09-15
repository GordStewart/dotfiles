# #!/bin/bash

# +--------+
# | System |
# +--------+

alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias path='echo $PATH | tr -s ":" "\n"' # Pretty print the path
alias distro='bat /etc/*-release'

# +------+
# | Core |
# +------+
alias cp='cp -iv'         # Confirm before overwriting something
alias rm='rm -I'          # prompt only when deleting more than 3 files at once
alias mv='mv -iv'
alias df='df -h'          # Human-readable sizes
alias free='free -m'   # Show sizes in MB
alias chmod="chmod -v"
alias ffs='sudo !!'

# +-----+
# | Zsh |
# +-----+

# Every directory visited will populate the stack
# The alias d will display directories prefixed with a number
# Just type this number to go straight to that directory
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index # directory stack

# +--------+
# | Zoxide |
# +--------+
alias j='z'

# +-----------+
# | ls / exa  |
# +-----------+
alias lD='eza -lD --icons ' # only directories
alias lf='eza -lF --icons --color=always | grep -v /' # only files
alias lh='eza -dl --icons .* --group-directories-first' # only hidden
alias ls='eza --icons --group-directories-first'
alias la='eza --all --icons --group-directories-first'
alias ll='eza --all --long --icons --group-directories-first'
alias lt='eza --all --tree --icons --group-directories-first'
alias lm='eza -al --sort=modified --icons' # sort by time modified
alias lz='eza -alF --icons --color=always --sort=size | grep -v /'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# +--------+
# | Global |
# +--------+
# Type letter, then space, ie "ls- al T[space]" will become "ls -al | tail"
alias -g L='| less'
alias -g G='| rg '
# alias -g G='| egrep --color'
alias -g S='| sort'
alias -g R='| sort -rn'
alias -g H='| head'
alias -g T='| tail'

# +--------------+
# | Windows Apps |
# +--------------+
alias explorer='/mnt/c/Windows/explorer.exe'

# +-----------+
# | fzf & apt |
# +-----------+
alias fapt="sudo true && apt list | sed 1d | cut -d/ -f1 | fzf -m --preview 'apt-cache show {1}' | xargs -ro sudo apt install"
alias rmfapt="sudo true && apt list --installed | sed 1d | cut -d/ -f1 | fzf -m --preview 'apt-cache show {1}' | xargs -ro sudo apt remove"
#
#
alias py="python"
# +-------+
# | Typos |
# +-------+
alias whcih='which'
