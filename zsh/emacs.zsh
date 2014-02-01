#################
#Everything about emacs
#################

export EDITOR='emacsclient -ta ""'

alias e='emacsclient -ta ""'

# This starts a new daemon as the user if it's not running already (-a "") and uses TRAMP so that there doesn't have to be another daemon for "root"
# It is like 'sudo e'
function E() { 
    emacsclient -t -a "" "/sudo::$@" 
} 


compdef emacs
