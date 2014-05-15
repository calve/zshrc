#! /bin/zsh

#################
#Theme colors
#################

# Variables used in various modules to get a color

# You can use named colors or number
# Use spectrum_bls to list all 256 colors and their numbers

# Color are name after lscolor, and may not refleat what the terminal actual show
#available named colors : white black red green yellow blue magenta cyan grey
#
# Those bright color are not available as background color :
# brightblack brightred brightgreen brightyellow brightblue
# brightmagenta brightcyan brightgrey
ZSH_THEME_USER_BG=$[$RANDOM % 256]
ZSH_THEME_USER_FG="black"
#ZSH_THEME_HOST_BG=$[$RANDOM % 256] #Uncomment for a different color for the hostname prompt
ZSH_THEME_HOST_BG=$ZSH_THEME_USER_BG
ZSH_THEME_HOST_FG="black"
ZSH_THEME_PWD_BG1="179"
ZSH_THEME_PWD_FG1="black"
ZSH_THEME_PWD_BG2="25"
ZSH_THEME_PWD_FG2="white"
ZSH_THEME_WHO_BG="209"
ZSH_THEME_WHO_FG="black"
ZSH_THEME_STATUS_BG="red"
ZSH_THEME_STATUS_FG="black"
ZSH_THEME_PROXY_BG="029"
ZSH_THEME_PROXY_FG="235"



ZSH_THEME_GIT_UNTRACKED_BG="red"
ZSH_THEME_GIT_UNTRACKED_FG="black"
ZSH_THEME_GIT_CHANGED_BG="yellow"
ZSH_THEME_GIT_CHANGED_FG="black"
ZSH_THEME_GIT_STAGED_BG="green"
ZSH_THEME_GIT_STAGED_FG="black"
