#################
# Zshrc
#################

# Source every .zsh in SOURCES_FILES_DIR
SOURCES_FILES_DIR=$HOME/.zsh
ZSH_THEME=$SOURCES_FILES_DIR/theme.zsh

#Load theme first
source $ZSH_THEME

for i in `ls ${SOURCES_FILES_DIR}/*.zsh` ; do 
    source $i ; 
done ;
