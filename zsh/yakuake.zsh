#################
#Yakuake blur
#################
if [[ -n $DISPLAY && -n `qdbus | grep yakuake` ]]; then
    xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -name Yakuake;
fi
