
# Grep the history with 'h'
h () { 
   if (( $+1 )); then
       history 0 | grep $1 
   else
       history
   fi
}
