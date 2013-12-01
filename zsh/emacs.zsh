#################
#Everything about emacs
#################

export EDITOR='emacsclient -ta ""'

# This starts a new daemon as the user if it's not running already (-a "") and uses TRAMP so that there doesn't have to be another daemon for "root"
function E() { 
    emacsclient -t -a "" "/sudo::$@" 
} 


alias e='emacsclient -ta ""'

compdef emacs
