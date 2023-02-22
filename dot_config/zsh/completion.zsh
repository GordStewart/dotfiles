  # ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _ 
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

# +---------+
# | General |
# +---------+

# Load more completions
fpath=($HOME/.config/zsh/plugins/completions $fpath)

# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# Only work with the Zsh function vman
# See $DOTFILES/zsh/scripts.zsh
compdef vman="man"

# +---------+
# | Options |
# +---------+

# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _complete _match _approximate
# zstyle ':completion:*' completer _complete _match _approximate _extensions 

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^A' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
 # All parameters in green
zstyle ':completion:*:parameters' list-colors '=*=32'
# All commands in bolded red
zstyle ':completion:*:commands' list-colors '=*=1;31'

zstyle ':completion:*:options' list-colors '=^(-- *)=34'
zstyle ':completion:*:builtins' list-colors '=*=1;38;5;142'
zstyle ':completion:*:aliases' list-colors '=*=2;38;5;128'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- Sorry, no matches! --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Speed up file completion.
## https://coderwall.com/p/9fksra/speed-up-your-zsh-completions
zstyle ':completion:*' accept-exact-dirs true

# Tell ZSH to take the first part of the path to be exact, and to avoid
# partial globs.  Now path completions became nearly immediate.
zstyle ':completion:*' accept-exact '*(N)'

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# The number of errors allowed by _approximate increases
# with the length of what you've typed so far:
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# +---------+
# | Nvim    |
# +---------+
# No binary / build files for neovim
zstyle ':completion:*:nvim:*' ignored-patterns '*.(aux|fdb_latexmk|fls|gz|log|out|pdf)'
