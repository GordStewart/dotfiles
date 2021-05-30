# blank aliases
typeset -a baliases
baliases=()

balias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  baliases+=(${args##* })
}

# ignored aliases
typeset -a ialiases
ialiases=()

ialias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  ialiases+=(${args##* })
}

# functionality
expand-alias-space() {
  [[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?
  if [[ ! $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; then
    zle _expand_alias
  fi
  zle self-insert
  if [[ "$insertBlank" = "0" ]]; then
    zle backward-delete-char
  fi
}
zle -N expand-alias-space


# starts one or multiple args as programs in background
background() {
  for ((i=2;i<=$#;i++)); do
    ${@[1]} ${@[$i]} &> /dev/null &
  done
}


## Alias section

alias ..='cd ..'
alias ...='cd ../..'
alias df='df -h'                                                # Human-readable sizes
alias j='z'
alias sudo='sudo '
alias cat="bat"
alias ctags="ctags -R --exclude=@~/.ctagsignore ."

# Command Aliases (expanded at beginning of line"
alias s='sudo '
alias spac='sudo pacman -Syu '
alias sup='sudo apt update && sudo apt upgrade -y'


# "ignored" aliases, not expanded
ialias cl="clear"
ialias n="nvim "

ialias cp="cp -iv"                                                # Confirm before overwriting something
ialias rm='rm -v'
ialias mv='mv -iv'
ialias mkdir='mkdir -p'
# ialias ls='ls --color=auto --group-directories-first'
ialias l='exa --group-directories-first --icons -la --git --git-ignore'
ialias la='exa --group-directories-first --icons -la'
ialias lat='exa -laT'
ialias ll='exa --group-directories-first --icons -la --color-scale --time-style=long-iso --git --git-ignore -T -L2'
ialias ll3='exa --group-directories-first --icons -la --git --git-ignore -T -L3'
ialias ll4='exa --group-directories-first --icons -la --git --git-ignore -T -L4'
ialias tree='exa --group-directories-first -T --icons'
ialias ls='exa --group-directories-first'
ialias exa='exa --group-directories-first'
ialias lt='exa -T'
ialias lt2='exa --tree --level=2'
ialias lt3='exa --tree --level=3'
ialias chmod="chmod -v"

# Pretty print the path
ialias path='echo $PATH | tr -s ":" "\n"'

# Global aliases
# Type letter, then space, ie "ls- al T[space]" will become "ls -al | tail"
alias -g L='| less'
alias -g G='| rg '
# alias -g G='| egrep --color'
alias -g S='| sort'
alias -g R='| sort -rn'
alias -g H='| head'
alias -g T='| tail'

alias free='free -m'   # Show sizes in MB
# alias gitu='git add . && git commit && git push'

# Suffix aliases, open inbackground
alias -s {pdf,PDF}='background zathura'

alias aliases='nvim ~/.oh-my-zsh/custom/aliases.zsh'
alias exports='nvim ~/.oh-my-zsh/custom/exports.zsh'

# Shows top 10 commands used from history using "commands" function
alias topten="history | commands | sort -rn | head"

# Function aliases
alias fkill='fzf_kill'    # fzf kill process fzf_functions.sh
alias gll='fzf_git_log'   # fzf git log fzf_functions.sh

# Git aliases
ialias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias dc='docker-compose '
