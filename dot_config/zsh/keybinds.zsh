#!/bin/zsh

# +---------+
# | VI-MODE |
# +---------+
bindkey -v # set this before setting other keys
# edit current command line with vim (vim-mode, then v)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export KEYTIMEOUT=5 # Switch between modes faster

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# Change cursor
# autoload -Uz cursor_mode; cursor_mode

# bind history to up down keys
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
# and also Ctrl j/k and Ctrl n/p
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down

# Replace some default keybindings with better built-in widgets.
bindkey \
    '^[q'   push-line-or-edit \
    '^V'    vi-quoted-insert

# Insert last command
# [Alt + ,] inserts results of last run command
zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey "^[," insert-last-command-output

# Smart Insert last word
# [Alt + .] inserts last word
# like insert-last-word except that non-words are ignored
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
#   include words that is at least two characters long
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
bindkey '^[.' insert-last-word

# Ctrl + Right / Left
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Do history expansion on space
bindkey ' ' magic-space

# Alt-O inserts "sudo " at the start of line
# insert_sudo () { zle beginning-of-line; zle -U "sudo " }
# zle -N insert-sudo insert_sudo
# bindkey "^[o" insert-sudo

# Alt-Q
# - On the main prompt: Push aside your current command line, so you can type a
#   new one. The old command line is re-inserted when you press Alt-G or
#   automatically on the next command line.
# - On the continuation prompt: Move all entered lines to the main prompt, so
#   you can edit the previous lines.
bindkey '^[q' push-line-or-edit

# Alt-H: Get help on your current command.
() {
  unalias $1 2> /dev/null   # Remove the default.

  # Load the more advanced version.
  # -R resolves the function immediately, so we can access the source dir.
  autoload -RUz $1

  # Load $functions_source, an associative array (a.k.a. dictionary, hash table
  # or map) that maps each function to its source file.
  zmodload -F zsh/parameter p:functions_source

  # Lazy-load all the run-help-* helper functions from the same dir.
  autoload -Uz $functions_source[$1]-*~*.zwc  # Exclude .zwc files.
} run-help

# Alt-k: Show the next key combo's terminal code and state what it does.
bindkey '^[k' describe-key-briefly

# Alt-W: Type a widget name and press Enter to see the keys bound to it.
# Type part of a widget name and press Enter for autocompletion.
bindkey '^[w' where-is

# Alt-o: Prefix the current or previous command line with `sudo`.
() {
  bindkey '^[o' $1  # Bind Alt-o to the widget below.
  zle -N $1         # Create a widget that calls the function below.
  $1() {            # Create the function.
    # If the command line is empty or just whitespace, then first load the
    # previous line.
    [[ $BUFFER == [[:space:]]# ]] &&
        zle .up-history

    # $LBUFFER is the part of the command line that's left of the cursor. This
    # way, we preserve the cursor's position.
    LBUFFER="sudo $LBUFFER"
  }
} .sudo
