# These are Defaults, but just setting them anyways
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="nvim"
export VISUAL="nvim"

#zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=100000                   # Maximum events for internal history
export SAVEHIST=100000                   # Maximum events in history file

# +------+
# | PATH |
# +------+

export PATH="$HOME/neovim/bin:$PATH" # nvim

export PATH="$HOME/.cargo/bin:$PATH" # cargo
export PATH="$HOME/go/bin:$PATH" # golang
export PATH="/usr/local/go/bin:$PATH" # golang

# export MANPATH="/usr/local/man:$MANPATH" # local path for man pages


# +-------+
# |  WSL  |
# +-------+

if [[ "$(</proc/version)" == *icrosoft* ]] 2>/dev/null; then
  export WSL=1
  export DISPLAY=192.168.1.179:0.0
  export NO_AT_BRIDGE=1
  export LIBGL_ALWAYS_INDIRECT=1
fi

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview='tree -C {} | head -100' --preview-window=right:60%:wrap"
