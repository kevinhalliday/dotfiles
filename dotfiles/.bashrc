#!/bin/bash
#
# Author: Kevin Halliday
#
# Notes --- {{{

# Searching for a specific man page
#   1. apropros
#   2. man -k

# }}}
# Import from other Bash Files --- {{{

include () {
  [[ -f "$1" ]] && source "$1"
}

# these lines are included in case I add local or sensitive dotfiles
include ~/.bashrc_local
include ~/.bash/sensitive

# }}}
# Executed Commands --- {{{

# turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
stty -ixon

# make ctrl-w delete words as-defined by Vim
stty werase undef
bind '"\C-w": backward-kill-word'

# }}}
# Aliases --- {{{

# navigation
alias 'kepler'='cd ~/src/KeplerGroup/'
alias 'playground'='cd ~/src/playground/'
alias 'khalliday'='cd ~/src/khalliday/'
alias 'rocket'='cd ~/src/KeplerGroup/KIP-Rocket/'

# Easier directory navigation for going up a directory tree
alias 'a'='cd - &> /dev/null'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'
alias ......='cd ../../../../../..'
alias .......='cd ../../../../../../..'
alias ........='cd ../../../../../../../..'
alias .........='cd ../../../../../../../../..'
alias ..........='cd ../../../../../../../../../..'

# Tree that ignores annoying directories
alias itree="tree -I '__pycache__|venv'"

# Tmux launch script
alias t='~/tmuxlaunch.sh'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Regex ignore annoying directories
alias regrep="grep --perl-regexp -Ir \
--exclude=*~ \
--exclude=*.pyc \
--exclude=*.csv \
--exclude=*.tsv \
--exclude=*.md \
--exclude-dir=.bzr \
--exclude-dir=.git \
--exclude-dir=.svn \
--exclude-dir=node_modules \
--exclude-dir=venv"

# upgrade
alias upgrade="sudo apt-get update && sudo apt-get upgrade"

# reload this file
alias so='source ~/.bashrc'

# }}}
# Functions --- {{{

# plantuml
plantuml() {
  java -jar ~/java/plantuml.jar ${@}
}

# [optionally] create and activate Python virtual environment
# activate virtual environment from any directory from current and up
DEFAULT_VENV_NAME=.venv
DEFAULT_PYTHON_VERSION="3"

pydev() {
  pip install -U pip wheel
  pip install -U neovim bpython autopep8 jedi restview
}

va() {
  if [ $# -eq 0 ]; then
    local VENV_NAME=$DEFAULT_VENV_NAME
  else
    local VENV_NAME="$1"
  fi
  local slashes=${PWD//[^\/]/}
  local DIR="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    if [ -d "$DIR/$VENV_NAME" ]; then
      source "$DIR/$VENV_NAME/bin/activate"
      local DIR_REL=$(realpath --relative-to='.' "$DIR/$VENV_NAME")
      echo "Activated $(python --version) virtualenv in $DIR_REL/"
      return
    fi
    local DIR="$DIR/.."
  done
  echo "no $VENV_NAME/ found from here to OS root"
}

# [optionally] create and activate Python virtual environment
ve() {
  if [ $# -eq 0 ]; then
    local VENV_NAME="$DEFAULT_VENV_NAME"
  else
    local VENV_NAME="$1"
  fi
  if [ ! -d "$VENV_NAME" ]; then
    echo "Creating new Python virtualenv in $VENV_NAME/"
    python$DEFAULT_PYTHON_VERSION -m venv "$VENV_NAME"
    source "$VENV_NAME/bin/activate"
    pydev
    deactivate
    va
  else
    va
  fi
}

# deactivate virtual environment
vd() {
  deactivate
}

# Print out the Github-recommended gitignore
export GITIGNORE_DIR=$HOME/src/lib/gitignore
gitignore() {
  if [ ! -d "$GITIGNORE_DIR" ]; then
    mkdir -p $HOME/src/lib
    git clone https://github.com/github/gitignore $GITIGNORE_DIR
    return 1
  elif [ $# -eq 0 ]; then
    echo "Usage: gitignore <file1> <file2> <file3> <file...n>"
    return 1
  else
    # print all the files
    local count=0
    for filevalue in $@; do
      echo "#################################################################"
      echo "# $filevalue"
      echo "#################################################################"
      cat $GITIGNORE_DIR/$filevalue
      if [ $count -ne $# ]; then
        echo
      fi
      (( count++ ))
    done
  fi
}

# Create instance folder with only .gitignore ignored
mkinstance() {
  mkdir instance
  cat > instance/.gitignore <<EOL
*
!.gitignore
EOL
}


# Initialize Python Repo
pyinit() {
  if [ $# -ne 0 ]; then
    echo "pyinit takes no arguments"
    return 1
  fi
  gitignore Python.gitignore > .gitignore
  mkinstance
  ve
  cat > main.py <<EOL
#!/usr/bin/env python
"""The main module"""
EOL
  chmod +x main.py
  poetry init --no-interaction
}

# Create New Python Repo
pynew() {
  if [ $# -ne 1 ]; then
    echo "pynew <directory>"
    return 1
  fi
  local dir_name="$1"
  if [ -d "$dir_name" ]; then
    echo "$dir_name already exists"
    return 1
  fi
  git init "$dir_name" && cd "$dir_name"
  pyinit
}

# Vim, but activate python virtual environment first
vim() {
  va > /dev/null
  nvim "$@"
}


# Timer
countdown-seconds(){
  date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    ## Is this more than 24h away?
    days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
  echo ""
  spd-say "Beep, beep, beeeeeeeep. Countdown is finished"
}

countdown-minutes() {
  countdown-seconds $(($1 * 60))
}

stopwatch(){
  date1=`date +%s`;
  while true; do
    days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

# }}}
# Command line prompt (PS1) --- {{{

COLOR_BRIGHT_GREEN="\033[38;5;10m"
COLOR_BRIGHT_BLUE="\033[38;5;115m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_PURPLE="\033[1;35m"
COLOR_ORANGE="\033[38;5;202m"
COLOR_BLUE="\033[34;5;115m"
COLOR_WHITE="\033[0;37m"
COLOR_GOLD="\033[38;5;142m"
COLOR_SILVER="\033[38;5;248m"
COLOR_RESET="\033[0m"
BOLD="$(tput bold)"

function git_color {
  local git_status="$(git status 2> /dev/null)"
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  local git_commit="$(git --no-pager diff --stat origin/${branch} 2>/dev/null)"
  if [[ $git_status == "" ]]; then
    echo -e $COLOR_SILVER
  elif [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]] && \
      [[ ! -n $git_commit ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_ORANGE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  else
    echo "(no git)"
  fi
}

# Set Bash PS1
PS1_DIR="\[$BOLD\]\[$COLOR_BRIGHT_BLUE\]\w"
PS1_GIT="\[\$(git_color)\]\[$BOLD\]\$(git_branch)\[$BOLD\]\[$COLOR_RESET\]"
PS1_USR="\[$BOLD\]\[$COLOR_GOLD\]\u@\h"
PS1_END="\[$BOLD\]\[$COLOR_WHITE\]$ \[$COLOR_RESET\]"
PS1_PMT="\[$BOLD\]\[$COLOR_WHITE\] > \[$COLOR_RESET\]"

PS1="${PS1_DIR} ${PS1_GIT} ${PS1_USR} ${PS1_END} \n ${PS1_PMT}"

# }}}
