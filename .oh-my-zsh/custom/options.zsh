
setopt nobeep               # No Beeping
setopt correct              # Enable Spellcheck
setopt NO_FLOW_CONTROL      # disable start/stop chars in shell editor (^S, ^Q)
# Directories
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt autocd			    # `dirname` is equivalent to `cd dirname`
setopt cdablevars	        # Follow variables which are dirnames
setopt mark_dirs            # Add "/" if completes directory
setopt auto_param_slash     # if completed parameter is a directory, add a trailing slash
setopt path_dirs            # Can search subdirectory in $PATH

setopt interactivecomments	# allow comments on cmd line.

# Globs
setopt glob_complete
setopt EXTENDED_GLOB        # Enable extended globbing
setopt nocaseglob           # Case insensitive globbing
setopt numericglobsort      # Sort filenames numerically when it makes sense

setopt BANG_HIST		    # Allow ! for accessing history
setopt rm_star_wait         # if `rm *` wait 10 seconds before performing it!

# Completion Menu
setopt auto_menu            # show completion menu on succesive tab press
# use LS_COLORS colors in tab completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


setopt promptsubst
setopt long_list_jobs       # Better jobs
#setopt rcexpandparam       # Array expension with parameters

# List completion
setopt auto_list
setopt auto_param_keys
# setopt list_types # List like "ls -F"
# setopt list_packed # Compact completion

# History
setopt SHARE_HISTORY
setopt extended_history             # save beginning time and elapsed time before commands in history
setopt hist_verify                  # expand history onto the current line instead of executing it
setopt append_history               # append to the end of the history file
setopt hist_ignore_dups             # ignore duplication command history list
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

HISTFILE=$HOME/.cache/zsh/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

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
