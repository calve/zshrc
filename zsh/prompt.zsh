#! /bin/zsh

#################
#Everything about prompt
#################

#Reloading RPROMPT each time ?
setopt PROMPT_SUBST

function batterystatus () {
    if [ -e /sys/class/power_supply/BAT0/uevent ]; then
	python ~/.zsh/battery/battery.py
    fi
}

GLOBAL_ARROW_COLOR="reset"
function arrow () {
#please call me with two arguments
# first argument is arrow fill color
# second is background color
#an argument must be to the form of
# number with 3 digits to use 256 colors
# litteral to use ANSI 16 colors
#    echo -n %{$reset_color%}
    #echo -n $FX[reverse]

    echo -n $BG[$1];
    if [[ "$GLOBAL_ARROW_COLOR" != "reset" ]]; then
	echo -n $FG[$GLOBAL_ARROW_COLOR]
	
	if [[ -n $DISPLAY ]]; then
    	    echo -n ""
	else
    	    echo -n ">"
	fi
    fi
    if [ -n $2 ]; then
	echo -n $FG[$2]
    fi
    GLOBAL_ARROW_COLOR=$1
}

function p_user() {
    arrow  $ZSH_THEME_USER_BG $ZSH_THEME_USER_FG
    echo -n "%n"
}

function p_host() {
    arrow $ZSH_THEME_HOST_BG $ZSH_THEME_HOST_FG 
    echo -n "%m"
}

function prompt() {
    p_user
    p_host
    p_pwd   #p_pwd is define in ./git.zsh
    arrow "reset" "reset"
    echo
    arrow $ZSH_THEME_WHO_BG $ZSH_THEME_WHO_FG
    echo -n "$P_WHO"
    arrow "reset" "reset"
}


P_WHO="%(!.#.$)"
PROMPT='$(prompt)'

RP_STATUS="$FG[default]%(?..$FG[$ZSH_THEME_STATUS_BG]$FG[$ZSH_THEME_STATUS_FG]$BG[$ZSH_THEME_STATUS_BG]%?)"
RPROMPT='$(rp_proxy)${RP_STATUS}%{$FG[black]%}$(batterystatus)%{$reset_color%}'
