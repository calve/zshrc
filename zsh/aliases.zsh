#################
# Various Aliases
#################
alias ls="ls --color=auto"
alias radiomeuh="mplayer http://pakret.radiomeuh.com:80/big.mp3"
alias meuh="curl -s http://radiomeuh.com/meuh/playlist/index.php | egrep -e \"<B>\" | awk -F\"<[bB][rR](.?)>\" '{ print \$2 \" \\\"\"  \$3 \"\\\"\"}'"
alias hades="java -jar /home/goudale/.hades/hades.jar"
alias hades_retablisseurfichier="sed -i 's/\/home\/ag.de-busschere/\./g' *"
alias wifi="wicd-cli -yc"

alias kproxyswith="/home/goudale/.kproxyswitch.sh"
alias skype="xhost +local: && sudo -u skype /usr/bin/skype"
alias box.net="boxfs -s -v -u calvinh34@gmail.com $HOME/Cloud/box.net"
#alias touchpadOff="xinput set-prop 12 'Device Enabled' 0 "
#alias touchpadOn="xinput set-prop 12 'Device Enabled' 1 "
#alias touchpad="modprobe -r psmouse"
alias minecraft="java -jar $HOME/Vrac/MinecraftSP.jar"
alias vracmount="encfs ~/Image/.vrac ~/Image/vrac"
alias vracumount="fuser -u ~/Image/vrac"

alias sudo="nocorrect sudo "
alias ll="ls -alh"
alias df="df -h"
alias w="wicd-curses"
alias x="xdg-open"
