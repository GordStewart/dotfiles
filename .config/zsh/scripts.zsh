
# Grep the history with 'h'
h () {
   if (( $+1 )); then
       history 0 | grep $1
   else
       history
   fi
}

# TODO Find out what this does
# commands () {
#     awk '{a[$2]++}END{for(i in a){print a [i] " " i}}'
# }

# Create a new directory and enter it
function mk() {
    mkdir -p "$@" && cd "$@"
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

# +-----+
# | GIT |
# +-----+

# With command acts like 'git', otherwise 'git status'
g() {
    if [[ $# == 0 ]]; then
        git status
    else
        git "$@"
    fi
}


extract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            ex $file
        else
            echo "'$file' is not a valid file"
        fi
    done
}

mkextract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            local filename=${file%\.*}
            mkdir -p $filename
            cp $file $filename
            cd $filename
            ex $file
            rm -f $file
            cd -
        else
            echo "'$1' is not a valid file"
        fi
    done
}

ex() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}

compress() {
    local DATE="$(date +%Y%m%d-%H%M%S)"
    tar cvzf "$DATE.tar.gz" "$@"
}

imgresize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    if [ ! -z $3 ]; then
        local finalName="$filename.$extension"
    else
        local finalName="$filename$separator$2.$extension"
    fi
    convert $1 -quality 100 -resize $2 $finalName
    echo "$finalName resized to $2"
}

imgresizeall() {
    for f in *.${1}; do
        if [ ! -z $3 ]; then
            imgresize "$f" ${2} t
        else
            imgresize "$f" ${2}
        fi
    done
}

imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local finalName="$filename$separator$suffix.$extension"
    convert $1 -strip -interlace Plane -quality 85% $finalName
    echo "$finalName created"
}

Imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local convert $1 -strip -interlace Plane -quality 85% $1
    echo "$1 created"
}

imgoptimizeall() {
    for f in *.${1}; do
        imgoptimize "$f"
    done
}

Imgoptimizeall() {
    for f in *.${1}; do
        Imgoptimize "$f"
    done
}

imgtojpg() {
    for file in "$@"
    do
        local filename=${file%\.*}
        convert -quality 100 $file "${filename}.jpg"
    done
}

cheat() {
    curl cheat.sh/$1
}

startnvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  
}
