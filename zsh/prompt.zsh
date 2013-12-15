#! /bin/zsh

#################
#Everything about prompt
#################

#Reloading RPROMPT each time ?
setopt PROMPT_SUBST

function batterystatus () {
    if [ -e /sys/class/power_supply/BAT0/uevent ]; then
	python2 $SOURCES_FILES_DIR/batsysfs/batsysfs.py
    fi
}

function arrow () {
#please call me with two arguments
# first argument is arrow fill color
# second is background color
#an argument must be to the form of
# number with 3 digits to use 256 colors
# litteral to use ANSI 16 colors
#    echo -n %{$reset_color%}
    #echo -n $FX[reverse]
    case $1 in
	('') ;;
	(*) echo -n $FG[$1];;
    esac
    case $2 in
	('default') echo -n "%{\033[49m%}";;
	(*) echo -n $BG[$2];;
    esac
    if [[ -n $DISPLAY ]]; then
	echo -n ""
    else
	echo -n ">"
    fi
    echo -n %{$reset_color%}
}


P_USER="%{$FG[$ZSH_THEME_USER_FG]%}%{$BG[$ZSH_THEME_USER_BG]%}%n$(arrow $ZSH_THEME_USER_BG $ZSH_THEME_HOST_BG)"
P_HOST="$BG[$ZSH_THEME_HOST_BG]$FG[black]%m$(arrow $ZSH_THEME_HOST_BG $ZSH_THEME_PWD_BG1)"
P_WHO="$BG[$ZSH_THEME_WHO_BG]%{$FG[$ZSH_THEME_HOST_FG]%}%(!.#.$)$(arrow $ZSH_THEME_WHO_BG default)"

#p_pwd is define in ./git.zsh
PROMPT='${P_USER}${P_HOST}$(p_pwd)
${P_WHO}%{$reset_color%}'

RP_STATUS="$FG[default]%(?..$FG[$ZSH_THEME_STATUS_BG]$FG[$ZSH_THEME_STATUS_FG]$BG[$ZSH_THEME_STATUS_BG]%?)"
RPROMPT='${RP_STATUS}%{$FG[black]%}$(batterystatus)%{$reset_color%}'
