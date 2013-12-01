#! /bin/zsh
#################
# Everything about colors
#################

autoload -U colors
colors

export TERM="xterm-256color"

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'

#################
#colors in man
#################
man() {
    env \
	LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;31m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

#################
#syntax highlight in zsh
#################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue'

#################
# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Copied from http://github.com/sykora/etc/blob/master/zsh/functions/spectrum/
#################

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)


FG=(
    reset          "%{[m%}"
    white          "%{[1m%}"
    black          "%{[30m%}"
    red            "%{[31m%}"
    green          "%{[32m%}"
    yellow         "%{[33m%}"
    blue           "%{[34m%}"
    magenta        "%{[35m%}"
    cyan           "%{[36m%}"
    grey           "%{[37m%}"
    brightblack    "%{[1;30m%}"
    brightred      "%{[1;31m%}"
    brightgreen    "%{[1;32m%}"
    brightyellow   "%{[1;33m%}"
    brightblue     "%{[1;34m%}"
    brightmagenta  "%{[1;35m%}"
    brightcyan     "%{[1;36m%}"
    brightgrey     "%{[1;37m%}"
)

BG=(
    reset    "%{[00m%}"
    white    "%{[00m%}"
    black    "%{[40m%}"
    red      "%{[41m%}"
    green    "%{[42m%}"
    yellow   "%{[43m%}"
    blue     "%{[44m%}"
    magenta  "%{[45m%}"
    cyan     "%{[46m%}"
    grey     "%{[47m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done


# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
      for code in {000..255}; do
	  ((cc = code + 1))
	  print -P -- "$BG[$code]$code$reset_color"
      done
}
