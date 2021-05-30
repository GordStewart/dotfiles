
setopt nobeep               # No Beeping
setopt nocorrect            # Disable Spellcheck
setopt NO_FLOW_CONTROL      # disable start/stop chars in shell editor (^S, ^Q)
# Directories
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt autocd			    # `dirname` is equivalent to `cd dirname`
setopt cdablevars	        # Follow variables which are dirnames
setopt mark_dirs            # Add "/" if completes directory
setopt auto_param_slash     # if completed parameter is a directory, add a trailing slash
setopt path_dirs            # Can search subdirectory in $PATH

setopt interactivecomments	# allow comments on cmd line.
setopt completealiases

# Globs
setopt glob_complete
setopt EXTENDED_GLOB        # Enable extended globbing
setopt nocaseglob           # Case insensitive globbing
setopt numericglobsort      # Sort filenames numerically when it makes sense

setopt BANG_HIST		    # Allow ! for accessing history
setopt rm_star_wait         # if `rm *` wait 10 seconds before performing it!

# Completion
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
setopt complete_in_word     # Allow completion from within a word/phrase
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt listpacked
# Completion Menu
setopt auto_menu            # show completion menu on succesive tab press
# use LS_COLORS colors in tab completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 0 0
zstyle ":completion:*:git-checkout:*" sort false

setopt promptsubst
setopt long_list_jobs       # Better jobs
#setopt rcexpandparam       # Array expension with parameters

# List completion
setopt auto_list
setopt auto_param_keys
# setopt list_types # List like "ls -F"
# setopt list_packed # Compact completion

# History
setopt share_history                # share command history data
setopt extended_history             # save beginning time and elapsed time before commands in history
setopt hist_verify                  # expand history onto the current line instead of executing it
setopt hist_expire_dups_first       # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt inc_append_history           # append to the end of the history file
setopt hist_ignore_dups             # ignore duplication command history list
setopt hist_ignore_all_dups         # ignore duplicated commands history list
setopt hist_reduce_blanks
setopt hist_ignore_space            # ignore commands that start with space
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

#vi-mode
VI_MODE_SET_CURSOR=true
