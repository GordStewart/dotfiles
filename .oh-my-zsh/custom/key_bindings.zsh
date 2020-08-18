## Keys section

zle -N fzf-history-widget
bindkey "${key[Up]}" fzf-history-widget
# bindkey '^[[B' history-substring-search-down
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

bindkey " " expand-alias-space
bindkey -M isearch " " magic-space

bindkey "^Os" sudo-command-line  # Also Esc-Esc

bindkey "^h" run-help


autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
# alt and .
bindkey "\e." insert-last-word
#alt and =
bindkey "\e=" copy-prev-shell-word

# alt and left = back in history and ls contents
# alt and up = Up to parent directory and ls contents
# zle -N              cdParentKey
# zle -N              cdUndoKey
# bindkey '^[[1;3A'   cdParentKey
# bindkey '^[[1;3D'   cdUndoKey

function _parent-list-contents {
	zle kill-whole-line
	pushd ..
	zle reset-prompt
	zle -U "exa"
	zle reset-prompt
}

# zle -N _parent-list-contents
# bindkey '^[[1;3A' _parent-list-contents
