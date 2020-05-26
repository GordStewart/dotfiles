# Grep the history with 'h'
h () {
   if (( $+1 )); then
       history 0 | grep $1
   else
       history
   fi
}


commands () {
    awk '{a[$2]++}END{for(i in a){print a [i] " " i}}'
}
