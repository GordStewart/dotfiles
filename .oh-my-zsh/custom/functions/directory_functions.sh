# Create a new directory and enter it
function mk() {
    mkdir -p "$@" && cd "$@"
}

# Back in dir history and ls contents
cdUndoKey() {
    popd
    zle     reset-prompt
    echo
    ls
    zle     reset-prompt
}

# Go to Parent directory and ls contents
cdParentKey() {
    pushd ..
    zle     reset-prompt
    echo
    ls
    zle     reset-prompt
}

function tmw {
    tmux split-window -dh "$*"
}

# give the absolute path for a given file .
function fp () {
      echo "${1:A}"
  }

# Copy files to a directory, creating it if necessary
function cp! () {
  if [[ $# -ge 2 ]]; then
    if [[ ! -e ${@: -1} ]]; then
      mkdir -p ${@: -1}
    fi
    command cp -rf $@
  fi
}


# Move files to a directory, creating it if necessary
function mv! () {
  if [[ $# -ge 2 ]]; then
    if [[ ! -e ${@: -1} ]]; then
      mkdir -p ${@: -1}
    fi
    command mv -f $@
  fi
}
