#! /bin/zsh

#################
#Everything about prompt
#################

#Reloading RPROMPT each time ?
setopt PROMPT_SUBST

function batterystatus () {
    python2 $SOURCES_FILES_DIR/batsysfs/batsysfs.py
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
	(*[^0-9]*|'') echo -n "%{$fg_no_bold[$1]%}";;
	(*) echo -n $FG[$1];;
    esac
    case $2 in
	('default') echo -n "%{\033[49m%}";;
	(*[^0-9]*|'') echo -n "%{$bg[$2]%}";;
	(*) echo -n $BG[$2];;
    esac
    if [[ -n $DISPLAY ]]; then
	echo -n ""
    else
	echo -n ">"
    fi
    echo -n %{$reset_color%}
}


P_USER="%{$FG[$ZSH_THEME_USER_FG]%}%{$bg_no_bold[$ZSH_THEME_USER_BG]%}%n$(arrow $ZSH_THEME_USER_BG $ZSH_THEME_HOST_BG)"
P_HOST="$BG[$ZSH_THEME_HOST_BG]%{$fg[black]%}%m$(arrow $ZSH_THEME_HOST_BG $ZSH_THEME_PWD_BG1)"
P_WHO="$BG[$ZSH_THEME_WHO_BG]%{$FB[$ZSH_THEME_HOST_FG]%}%(!.#.$)$(arrow $ZSH_THEME_WHO_BG default)"

#p_pwd is define in ./git.zsh
PROMPT='${P_USER}${P_HOST}$(p_pwd)
${P_WHO}%{$reset_color%}'

RP_STATUS="%{$fg[default]%}%(?..%{$fg[red]%}%{$fg[default]%}%{$bg[red]%}%?)"
RPROMPT='${RP_STATUS}%{$fg[black]%}$(batterystatus)%{$reset_color%}'
