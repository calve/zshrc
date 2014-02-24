#! /bin/zsh
#################
#git integration
#################

#Config

#Basedir to generate statistics
GITSTATS_DIR=~/Vrac/gitstats/


#Needed to get git state in prompt
source ~/.zsh/zsh-git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_NOCACHE="1"

#Git aliases
alias g="git"
alias go="git checkout"

#List files tracked by git and show their last commits
function lg() {
    FILES=`git ls-tree --name-only HEAD $1`
    MAXLEN=0
    for f in `git ls-tree --name-only HEAD $1`; do
	if [ ${#f} -gt $MAXLEN ]; then
            MAXLEN=${#f}
	fi
    done
    #Yup, this is redondant, i can't get it to work with $FILES
    for f in `git ls-tree --name-only HEAD $1`; do 
	str=$(git log -1 --decorate --pretty=format:"%C(green)%cr%Creset" $f)
	str2=$(git log -1 --decorate --pretty=format:"%C(cyan)%h%Creset %s %C(yellow)(%cn)%Creset" $f)
	printf "%-${MAXLEN}s \t-- %s \t %s\n" "$f" "$str" "$str2"
    done
}

#gitstats is a software that generate statistics on a git rep
function git_gen_stats() {
    gitstats . $GITSTATS_DIR$(basename $PWD)
}

#Extra info about a git repo states
git_extra_info () {
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
	STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX"
	#STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
	if [ "$GIT_STAGED" -ne "0" ]; then
	    STATUS="$STATUS$(arrow default yellow)$GIT_STAGED"
	fi
	if [ "$GIT_CONFLICTS" -ne "0" ]; then
	    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS"
	fi
	if [ "$GIT_CHANGED" -ne "0" ]; then
	    STATUS="$STATUS$(arrow '' yellow)$GIT_CHANGED"
	fi
	if [ "$GIT_UNTRACKED" -ne "0" ]; then
	    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR$ZSH_THEME_GIT_PROMPT_UNTRACKED$GIT_UNTRACKED"
	fi
	STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
	echo "$STATUS"
    fi  
}

#Give a function to get current git state, or simple directory if not in git

function p_pwd () {
#Need zsh-git-prompt
    
    if [ -n "$__CURRENT_GIT_STATUS" ]; then #Si on est dans un repertoire git
	#This variable will save the "current" background color
	CURRENTCOLOR=""
	#Get repo name
	PARENTDIR="$(basename $(dirname $(git rev-parse --show-toplevel)))"
	
	#Check $PARENTDIR pertinence
	if [ "$PARENTDIR" != "." ]; then
	    PARENTDIR="%{$BG[$ZSH_THEME_PWD_BG1]%}%{$FG[$ZSH_THEME_PWD_FG1]%}$PARENTDIR"
	else
	    PARENTDIR=""
	fi
	THISDIR="%{$BG[$ZSH_THEME_PWD_BG2]%}%{$FG[$ZSH_THEME_PWD_FG2]%}"
	THISDIR+="$(basename $(git rev-parse --show-toplevel))$(arrow $ZSH_THEME_PWD_BG2 black)"
	CURRENTCOLOR="black"

	#Get a (branch) name and a (state) color for HEAD with git_super_status set by zsh-git-prompt
	THISDIR+="%{$bg[black]%}$(git_super_status)"
	
	#Print how much files are untracked
	if [ "$GIT_UNTRACKED" -ne "0" ]; then
	    THISDIR+="$(arrow $CURRENTCOLOR $ZSH_THEME_GIT_UNTRACKED_BG)%{$BG[$ZSH_THEME_GIT_UNTRACKED_BG]%}$FG[$ZSH_THEME_GIT_UNTRACKED_FG]$GIT_UNTRACKED"
	    CURRENTCOLOR="$ZSH_THEME_GIT_UNTRACKED_BG"
	fi
	#Print how much files changed
	if [ "$GIT_CHANGED" -ne "0" ]; then
	    THISDIR+="$(arrow $CURRENTCOLOR $ZSH_THEME_GIT_CHANGED_BG)%{$BG[$ZSH_THEME_GIT_CHANGED_BG]%}$FG[$ZSH_THEME_GIT_CHANGED_FG]$GIT_CHANGED"
	    CURRENTCOLOR="$ZSH_THEME_GIT_CHANGED_BG"
	fi
	#Print how much commit
	if [ "$GIT_STAGED" -ne "0" ]; then
	    THISDIR+="$(arrow $CURRENTCOLOR $ZSH_THEME_GIT_STAGED_BG)%{$BG[$ZSH_THEME_GIT_STAGED_BG]%}$FG[$ZSH_THEME_GIT_STAGED_FG]$GIT_STAGED"
	    CURRENTCOLOR="$ZSH_THEME_GIT_STAGED_BG"
	fi
      
	if [[ -n $(git rev-parse --show-prefix 2>/dev/null) ]]; then #Si on est dans un sous répertoire
	    THISDIR+="$(arrow $CURRENTCOLOR $ZSH_THEME_PWD_BG2)"
	    THISDIR+="%{$BG[$ZSH_THEME_PWD_BG2]%}%{$fg[black]%}$(git rev-parse --show-prefix)"
	    THISDIR+="$(arrow $ZSH_THEME_PWD_BG2 default)"
	else
	    THISDIR+="$(arrow $CURRENTCOLOR default)" 
	fi

    else
	PARENTDIR="$(dirname "$(print -P %3~)")"
	#Check $PARENTDIR pertinence
	if [ "$PARENTDIR" != "." ]; then
	    PARENTDIR="%{$BG[$ZSH_THEME_PWD_BG1]%}%{$FG[$ZSH_THEME_PWD_FG1]%}$PARENTDIR"
	else
	    PARENTDIR=""
	fi
	THISDIR="%{$BG[$ZSH_THEME_PWD_BG2]%}%{$FG[$ZSH_THEME_PWD_FG2]%}$(print -P %1~)$(arrow $ZSH_THEME_PWD_BG2 default)"
    fi

    #Finally, print everything
    echo -n "$PARENTDIR$(arrow $ZSH_THEME_PWD_BG1 $ZSH_THEME_PWD_BG2 )$THISDIR"
}
