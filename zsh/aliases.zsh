#################
# Various Aliases
#################
alias ls="ls --color=auto"
alias radiomeuh="mplayer http://pakret.radiomeuh.com:80/big.mp3"
alias coldbusted="mplayer http://195.154.217.103:8391/coldbustedradio"
alias meuh="curl -s http://radiomeuh.com/meuh/playlist/index.php | egrep -ae \"<B>\" | awk -F\"<[bB][rR](.?)>\" '{ print \$2 \" \\\"\"  \$3 \"\\\"\"}' >> ~/meuh && tail -n 1 ~/meuh"
alias hades="java -jar /home/goudale/.hades/hades.jar"
alias hades_retablisseurfichier="sed -i 's/\/home\/ag.de-busschere/\./g' *"
alias wifi="wicd-cli -yc"

alias kproxyswith="/home/goudale/.kproxyswitch.sh"
alias skype="PULSE_LATENCY_MSEC=60 /bin/skype"
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

function record_screen () {
    ffmpeg -f x11grab -s 1280x800 -r 25 -i :0.0  $1
}


function record_webcam () {
    ffmpeg -f v4l2 -framerate 25  -i /dev/video0 $1
}

function record_audio () {
    arecord -v -V stereo -f dat $1
}
