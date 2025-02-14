#!usr/bin/env fish
# 'g' by itself will perform 'git status'
# Otherwise, acts as 'git' i.e. "g pull"

function g
    # If no arguments
    if [ -z "$argv" ]
        git status
    else if [ "$argv[1]" = --help ]
        echo "by itself, g = git status."
        echo "with a command, is aliased to git: i.e. g pull"
    else
        git $argv
    end
end
