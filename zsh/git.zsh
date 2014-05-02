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

#Give a function to get current git state, or simple directory if not in git
function p_pwd () {
#Need zsh-git-prompt

    arrow $ZSH_THEME_PWD_BG1 $ZSH_THEME_PWD_FG1
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
	#Get repo name
	echo -n "$(basename $(dirname $(git rev-parse --show-toplevel)))"
	
	#Check $PARENTDIR pertinence
	if [ "$PARENTDIR" != "." ]; then
	    echo -n $PARENTDIR
	fi
	arrow $ZSH_THEME_PWD_BG2 $ZSH_THEME_PWD_FG2
	echo -n "$(basename $(git rev-parse --show-toplevel))"
	arrow black  

	#Get a (branch) name and a (state) color for HEAD with git_super_status set by zsh-git-prompt
	echo -n "$(git_super_status)"
	
	#Print how much files are untracked
	if [ "$GIT_UNTRACKED" -ne "0" ]; then
	    arrow $ZSH_THEME_GIT_UNTRACKED_BG
	    echo -n "$FG[$ZSH_THEME_GIT_UNTRACKED_FG]$GIT_UNTRACKED"
	fi
	#Print how much files changed
	if [ "$GIT_CHANGED" -ne "0" ]; then
	    arrow $ZSH_THEME_GIT_CHANGED_BG $ZSH_THEME_GIT_CHANGED_FG
	    echo -n "$GIT_CHANGED"
	fi
	#Print how much commit
	if [ "$GIT_STAGED" -ne "0" ]; then
	    arrow $ZSH_THEME_GIT_STAGED_BG $ZSH_THEME_GIT_STAGED_FG
	    echo -n "$GIT_STAGED"
	fi
      
	if [[ -n $(git rev-parse --show-prefix 2>/dev/null) ]]; then #Si on est dans un sous répertoire
	    arrow $ZSH_THEME_PWD_BG2
	    echo -n "$FG[black]$(git rev-parse --show-prefix)"
	fi

    else
	PARENTDIR="$(dirname "$(print -P %3~)")"
	#Check $PARENTDIR pertinence
	if [ "$PARENTDIR" != "." ]; then
	    echo -n "$PARENTDIR"
	fi
        print -Pn %1~
	arrow $ZSH_THEME_PWD_BG2
    fi
}
