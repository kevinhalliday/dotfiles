#!/bin/bash
#
# Set up soft links for config files

set -e

HOME=$(echo ~)
THIS=$(pwd)
TEMP=$HOME/temp

if [ ! -e $TEMP ]; then
  mkdir $TEMP
fi

softlink () {
  TARGET=$THIS/$1
  LINK_NAME=$HOME/$2
  if [ -e $LINK_NAME ]; then
    NEW_LOCATION=$TEMP/$2
    echo "$LINK_NAME exists, moving existing file to $NEW_LOCATION folder"
    mv $LINK_NAME $NEW_LOCATION
  fi
  echo "Linking $TARGET $LINK_NAME"
  ln -s $TARGET $LINK_NAME
}

dotfiles=( .vimrc .bashrc .bash_profile .gitconfig .tmux.conf .inputrc )

for dotfile in "${dotfiles[@]}"; do
  softlink $dotfile $dotfile
done
