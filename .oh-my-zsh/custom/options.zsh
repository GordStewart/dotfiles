# Completion
zstyle ':completion:*' group-name ''
# format all messages not formatted in bold prefixed with ----
zstyle ':completion:*' format '%B---- %d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':completion:*:options' prefix-needed yes

zstyle ':completion:*' use-cache true
# Enable menu completion
zstyle ':completion*:default' menu select=1
zstyle ':completion:*' matcher-list \
    '' \
    'm:{a-z}={A-Z}' \
'l:|=* r:|[.,_-]=* r:|=* m:{a-z}={A-Z}'
# allow approximate matching
zstyle ':completion:*:approximate:*'  max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# sudo completions
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*' menu select
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
_approximate _list _history
# use dircolours in completion listings
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}




# no binary files for vi(m)
zstyle ':completion:*:vi:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:vim:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:nvim:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'

# no binary files for less
zstyle ':completion:*:less:*' ignored-patterns '*.(o|a|so|dvi|fig|out|class|pdf|ps|pyc)'

# tar files
zstyle ':completion:*:tar:*' files '*.tar|*.tgz|*.tz|*.tar.Z|*.tar.bz2|*.tZ|*.tar.gz'

# Separate man page sections
zstyle ':completion:*:manuals' seperate-sections true
# Separate comand line options and descriptions with #
zstyle ':completion:*' list-separator '#'
# Generate descriptions for arguments
zstyle ':completion:*' auto-description 'specify: %d'

setopt nobeep           # No Beeping
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt autocd			    # cd by typing dirname
setopt cdablevars	        # Follow variables which are dirnames
setopt interactivecomments	# allow comments on cmd line.
setopt glob_complete
setopt path_dirs            # Can search subdirectory in $PATH
setopt EXTENDED_GLOB        # Enable extended globbing
setopt correct              # Enable Spellcheck
setopt BANG_HIST		    # Allow ! for accessing history
setopt rm_star_wait         # if `rm *` wait 10 seconds before performing it!
setopt auto_menu            # show completion menu on succesive tab press
setopt promptsubst
setopt long_list_jobs       # Better jobs
setopt mark_dirs            # Add "/" if completes directory
setopt nocaseglob           # Case insensitive globbing
#setopt rcexpandparam       # Array expension with parameters
setopt numericglobsort      # Sort filenames numerically when it makes sense
# List completion
setopt auto_list
setopt auto_param_slash
setopt auto_param_keys
# List like "ls -F"
setopt list_types
# Compact completion
setopt list_packed
# History
setopt SHARE_HISTORY
setopt extended_history             # save beginning time and elapsed time before commands in history
setopt hist_verify                  # expand history onto the current line instead of executing it
setopt append_history               # append to the end of the history file
setopt hist_ignore_dups             # ignore duplication command history list
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
HISTFILE=$HOME/.cache/zsh/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
setopt no_flowcontrol


# From .zshrc
# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugin options

#ZSh_AUTOSUGGESTIONS
ZSH_AUTOSUGGEST_USE_ASYNC=1

#ZSH_SYNTAX_HIGHLIGHTING
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Declare the variable
typeset -A ZSH_HIGHLIGHT_PATTERNS
# To have commands starting with 'rm -rf' in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
