# Fuzzy Git Add - Stage *Modified* Files
# Selectively stage fuzzily found files for committing.
# Note, only modified files will be listed for staging.
fga() {
    local files=$(git ls-files --modified | fzf --ansi)
    if [[ -n $files ]]; then
        git add --verbose $files
    fi
}
# Fuzzy Grep Edit
# Fuzzy find a  file, with colorful preview, that contains the supplied term, then
# once selected edit it in your preferred editor. If your EDITOR is Vim or Neovim
# then you will be automatically scrolled to the selected line.
fge(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR $file +$(echo "$match" | cut -d':' -f2)
    fi
}
# Fuzzy File Edit
# Find a file, with colorful preview, then once selected edit it
# in your preferred editor.

# fo() {
#     local file=$(
#       fzf --no-multi --preview 'bat --color=always --line-range :500 {}'
#       )
#     if [[ -n $file ]]; then
#         $EDITOR $file
#     fi
# }


# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Find and kill process
# Multi-selection is enabled to allow multiple processes to be selected via the TAB key.
fzf_kill() {
    local pids=$(
      ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f3
      )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}

alias fkill='fzf_kill'


# Git log browser
# (This needs the following command before it can be used)
fzf_git_log() {
    local commits=$(
      git ll --color=always "$@" |
        fzf --ansi --no-sort --height 100% \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
        git show $hashes
    fi
}

alias gll='fzf_git_log'
