#! /bin/zsh
#################
#Powerline support (to get a symbol that looks like a big arrow)
#################
#. /usr/share/zsh/site-contrib/powerline.zsh

#################
#Everything about prompt
#################

#Reloading RPROMPT each time ?
setopt PROMPT_SUBST

#goudale@latitude ~/Cours/S4/TW/TD1 $  


function batterystatus () {
    python2 $HOME/Code/batsysfs.py
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


P_USER="%{$fg[black]%}%{$bg_no_bold[green]%}%n$(arrow green $ZSH_THEME_HOST_BG)"
#P_AT="%{$fg[black]%}@$(arrow white 098)"
P_HOST="$BG[$ZSH_THEME_HOST_BG]%{$fg[black]%}%m$(arrow 098 $ZSH_THEME_PWD_BG1)"
#P_PWD="%{$bg[cyan]%}%{$fg[black]%}%3~%{$fg[cyan]%}%{$bg[yellow]%}"
P_WHO="$BG[209]%{$fg[black]%}%(!.#.$)$(arrow 209 default)"
PROMPT='${P_USER}${P_HOST}$(p_pwd)
${P_WHO}%{$reset_color%}'

RP_STATUS="%{$fg[default]%}%(?..%{$fg[red]%}%{$fg[default]%}%{$bg[red]%}%?)"
RPROMPT='${RP_STATUS}%{$fg[black]%}$(batterystatus)%{$reset_color%}'
