# Nothing to do if not inside an interactive shell.
if not status is-interactive
    return 0
end

# Disable the new user greeting
set fish_greeting

zoxide init fish | source
fzf --fish | source

abbr -a cp cp -riv
abbr -a mv mv -iv
abbr -a mkdir mkdir -vp

abbr -a zz exit
abbr -a c clear
abbr -a l ll

abbr -a nv nvim
abbr -a vi nvim

# theme
fish_config theme choose tokyonight_moon

#Vim keys
set -g fish_key_bindings fish_vi_key_bindings
set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

# dotfiles 
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
