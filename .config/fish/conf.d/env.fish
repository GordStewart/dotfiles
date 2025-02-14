# set -q = --query (test if variable is defined)

# Colorize man pages.
set -Ux MANROFFOPT -c # <-- This took about an hour to find!!
set -Ux LESS_TERMCAP_mb (set_color -o blue)
set -Ux LESS_TERMCAP_md (set_color -o cyan)
set -Ux LESS_TERMCAP_me (set_color normal)
set -Ux LESS_TERMCAP_so (set_color -b white black)
set -Ux LESS_TERMCAP_se (set_color normal)
set -Ux LESS_TERMCAP_us (set_color -u magenta)
set -Ux LESS_TERMCAP_ue (set_color normal)


# Set editor variables.
set -q PAGER; or set -Ux PAGER less
set -x MANPAGER "nvim +Man!"
set -q LESS; or set -Ux LESS -FiMR --incsearch
set -q VISUAL; or set -Ux VISUAL nvim
set -q EDITOR; or set -Ux EDITOR nvim
