# Defined in /Users/folke/.config/fish/config.fish @ line 71
function update --description 'Update homebrew, fish, etc'
    ~
    and echo "[updating] Homebrew..."
    and brew update
    and brew upgrade

    and echo "[cleaning] brew cache..."
    # #and rm -rfv (brew --cache) # brew cleanup -s doesn't remove everythin
    and brew cleanup -s
    # and brew bundle dump --describe --force

    # and echo "[update] python"
    # and pip3 list -o --user --format=freeze | sed "s/==.*//" | xargs pip3 install -U --user

    and echo "[updating] tldr cache..."
    and command tldr -u

    and echo "[updating] tmux plugins..."
    and tmux_update

    and echo "[updating] fish stuff..."
    and fisher update
    and fish_update_completions
end
