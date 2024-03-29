#!/bin/zsh

#######################################################################
# Environment Setup
#######################################################################

# Path Functions {{{

function path_ladd() {
  # Takes 1 argument and adds it to the beginning of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

function path_radd() {
  # Takes 1 argument and adds it to the end of the PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

# }}}
# Exported variable: LS_COLORS --- {{{

# Colors when using the LS command
# NOTE:
# Color codes:
#   0   Default Colour
#   1   Bold
#   4   Underlined
#   5   Flashing Text
#   7   Reverse Field
#   31  Red
#   32  Green
#   33  Orange
#   34  Blue
#   35  Purple
#   36  Cyan
#   37  Grey
#   40  Black Background
#   41  Red Background
#   42  Green Background
#   43  Orange Background
#   44  Blue Background
#   45  Purple Background
#   46  Cyan Background
#   47  Grey Background
#   90  Dark Grey
#   91  Light Red
#   92  Light Green
#   93  Yellow
#   94  Light Blue
#   95  Light Purple
#   96  Turquoise
#   100 Dark Grey Background
#   101 Light Red Background
#   102 Light Green Background
#   103 Yellow Background
#   104 Light Blue Background
#   105 Light Purple Background
#   106 Turquoise Background
# Parameters
#   di 	Directory
LS_COLORS="di=1;34:"
#   fi 	File
LS_COLORS+="fi=0:"
#   ln 	Symbolic Link
LS_COLORS+="ln=1;36:"
#   pi 	Fifo file
LS_COLORS+="pi=5:"
#   so 	Socket file
LS_COLORS+="so=5:"
#   bd 	Block (buffered) special file
LS_COLORS+="bd=5:"
#   cd 	Character (unbuffered) special file
LS_COLORS+="cd=5:"
#   or 	Symbolic Link pointing to a non-existent file (orphan)
LS_COLORS+="or=31:"
#   mi 	Non-existent file pointed to by a symbolic link (visible with ls -l)
LS_COLORS+="mi=0:"
#   ex 	File which is executable (ie. has 'x' set in permissions).
LS_COLORS+="ex=1;92:"
# additional file types as-defined by their extension
LS_COLORS+="*.rpm=90"

# Finally, export LS_COLORS
export LS_COLORS

# }}}
# Exported variables: General --- {{{

# React
export REACT_EDITOR='less'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Configure less (de-initialization clears the screen)
# Gives nicely-colored man pages
export PAGER=less
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --clear-screen'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Configure man pager
export MANPAGER='nvim +Man!'

# tmuxinator
export EDITOR=nvim
export SHELL=zsh

# environment variable controlling difference between HI-DPI / Non HI_DPI
# turn off because it messes up my pdf tooling
export GDK_SCALE=0

# Neovim does not change cursor shape if I set the below
# It seems to rely on underlying terminal being xterm-256
# and tmux being screen-256color.
# Weird bug, I'm making this note so I'm aware of it going forward

# History: How many lines of history to keep in memory
export HISTSIZE=5000

# History: ignore leading space, where to save history to disk
export HISTCONTROL=ignorespace
export HISTFILE=~/.zsh_history

#History: Number of history entries to save to disk
export SAVEHIST=5000

# FZF
# export FZF_COMPLETION_TRIGGER=''
# export FZF_DEFAULT_OPTS="--bind=ctrl-o:accept --ansi"
FZF_DEFAULT_COMMAND='rg --files --no-ignore --no-messages --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND

# pipenv
export PIPENV_VENV_IN_PROJECT='doit'

# Default browser for some programs (eg, urlview)
export BROWSER='/usr/bin/google-chrome'

# Enable editor to scale with monitor's DPI
export WINIT_HIDPI_FACTOR=1.0

# Rust (for racer) (rustup component add rust-src)
export RUST_TOOLCHAIN_PATH="$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu"
export RUST_SRC_PATH="$RUST_TOOLCHAIN_PATH/lib/rustlib/src/rust/src"

# Bat
export BAT_PAGER=''

# browser sync
export LOCAL_IP='ipconfig getifaddr en0'

# }}}
# Misc env setup --- {{{

HOME_BIN="$HOME/bin"
if [ -d "$HOME_BIN" ]; then
  path_ladd "$HOME_BIN"
fi

POETRY_LOC="$HOME/.poetry/bin"
if [ -d "$POETRY_LOC" ]; then
  path_ladd "$POETRY_LOC"
  source $HOME/.poetry/env
fi

# used by pipx
LOCAL_BIN="$HOME/.local/bin"
if [ -d "$LOCAL_BIN" ]; then
  path_ladd "$LOCAL_BIN"
fi

LOCAL_USR_BIN="/usr/local/bin"
if [ -d "$LOCAL_USR_BIN" ]; then
  path_ladd "$LOCAL_USR_BIN"
fi

HOMEBREW_BIN="/opt/homebrew/bin"
if [ -d "$HOMEBREW_BIN" ]; then
  path_ladd "$HOMEBREW_BIN"
fi

FOUNDRY_BIN="$HOME/.foundry/bin"
if [ -d "$FOUNDRY_BIN" ]; then
  path_ladd "$FOUNDRY_BIN"
fi

source "$(brew --prefix asdf)/libexec/asdf.sh"

PNPM_HOME="/Users/kevinhalliday/Library/pnpm"
if [ -d "$PNPM_HOME" ]; then
  path_ladd "$PNPM_HOME"
fi
export PNPM_HOME

# }}}

#######################################################################
# Interactive session setup
#######################################################################

# Import from other Bash Files --- {{{

include () {
  [[ -f "$1" ]] && source "$1"
}

include ~/.bash/sensitive

# }}}
# ZShell prompt (PS1) --- {{{

# this must be done before sourceing the plugin
# check if it exists for avoid error on resource
if [[ ! -v GEOMETRY_PROMPT_PLUGINS ]]; then
  GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git)
fi

GEOMETRY_SYMBOL_PROMPT="▲"
GEOMETRY_SYMBOL_RPROMPT="◇"
GEOMETRY_SYMBOL_EXIT_VALUE="△"
GEOMETRY_SYMBOL_ROOT="▲"

GEOMETRY_COLOR_EXIT_VALUE="magenta"
GEOMETRY_COLOR_PROMPT="white"
GEOMETRY_COLOR_ROOT="red"
GEOMETRY_COLOR_DIR="yellow"
GEOMETRY_STATUS_COLOR="default"
GEOMETRY_PROMPT_SUFFIX=""

PROMPT_GEOMETRY_GIT_TIME=false
PROMPT_GEOMETRY_GIT_SHOW_STASHES=false

GEOMETRY_COLOR_VIRTUALENV="green"

# }}}
 # Plugins --- {{{

ZPLUG_HOME="$(brew --prefix zplug)"
if [ -f ${ZPLUG_HOME}/init.zsh ]; then
  source ${ZPLUG_HOME}/init.zsh

  # BEGIN: List plugins

  # use double quotes: the plugin manager author says we must for some reason
  # use double quotes: the plugin manager author says we must for some reason
  zplug "paulirish/git-open", as:plugin
  zplug "greymd/docker-zsh-completion", as:plugin
  zplug "buonomo/yarn-completion", as:plugin, defer:2 # defer 2 to run after compinit
  zplug "lukechilds/zsh-better-npm-completion", defer:2
  zplug "zsh-users/zsh-completions", as:plugin
  zplug "zsh-users/zsh-syntax-highlighting", as:plugin
  zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf
  zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
  zplug "geometry-zsh/geometry", as:plugin

  #END: List plugins

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi

  # Then, source plugins and add commands to $PATH
  zplug load
else
  echo "zplug not installed, so no plugins available"
fi

# }}}
# ZShell Options --- {{{

#######################################################################
# Set options
#######################################################################

# enable functions to operate in PS1
setopt PROMPT_SUBST

# list available directories automatically
setopt AUTO_LIST
setopt LIST_AMBIGUOUS
setopt LIST_BEEP

# completions
setopt COMPLETE_ALIASES

# automatically CD without typing cd
setopt AUTOCD

# Dealing with history
setopt HIST_IGNORE_SPACE
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt INCAPPENDHISTORY

#######################################################################
# Unset options
#######################################################################

# do not automatically complete
unsetopt MENU_COMPLETE

# do not automatically remove the slash
unsetopt AUTO_REMOVE_SLASH

#######################################################################
# Expected parameters
#######################################################################
export PERIOD=1
export LISTMAX=0

# }}}
# ZShell Hook Functions {{{

# Executed whenever the current working directory is changed
function chpwd() {
  # Magically find Python's virtual environment based on name
  if [[ "$VIRTUAL_ENV" == "$CAIRO_VENV_DIR" ]]; then
    return
  fi
  va
}

# Executed every $PERIOD seconds, just before a prompt.
# NOTE: if multiple functions are defined using the array periodic_functions,
# only  one  period  is applied to the complete set of functions, and the
# scheduled time is not reset if the list of functions is altered.
# Hence the set of functions is always called together.
function periodic() {
}

# Executed before each prompt. Note that precommand functions are not
# re-executed simply because the command line is redrawn, as happens, for
# example, when a notification about an exiting job is displayed.
function precmd() {
}

# Executed just after a command has been read and is about to be executed
#   arg1: the string that the user typed OR an empty string
#   arg2: a single-line, size-limited version of the command
#     (with things like function bodies elided)
#   arg3: full text that is being executed
function preexec() {
  # local user_string="$1"
  # local cmd_single_line="$2"
  # local cmd_full="$3"
}


# Executed when a history line is read interactively, but before it is executed
#   arg1: the complete history line (terminating newlines are present
function zshaddhistory() {
  # local history_complete="$1"
}

# Executed at the point where the main shell is about to exit normally.
function zshexit() {
}

# }}}
# ZShell Auto Completion --- {{{

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath+=~/.zfunc

autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

# CURRENT STATE: does not select any sort of searching
# searching was too annoying and I didn't really use it
# If you want it back, use "search-backward" as an option
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Fuzzy completion
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-A-Z}={A-Z\_a-z}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-A-Z}={A-Z\_a-z}' \
  'r:|?=** m:{a-z\-A-Z}={A-Z\_a-z}'
zmodload -i zsh/complist

# }}}
# # ZShell Key-Bindings --- {{{

# emacs
bindkey -e

# NOTE: about menu-complete
# '^d' - list options without selecting any of them
# '^i' - synonym to TAB; tap twice to get into menu complete
# '^o' - choose selection and execute
# '^m' - choose selection but do NOT execute AND leave all modes in menu-select
#         useful to get out of both select and search-backward
# '^q' - stop interactive tab-complete mode and go back to regular selection

# make vi keys do menu-expansion (eg, ^j does expansion, navigate with hjkl)
bindkey '^j' menu-expand-or-complete
bindkey -M menuselect '^j' menu-complete
bindkey -M menuselect '^k' reverse-menu-complete
bindkey -M menuselect '^h' backward-char
bindkey -M menuselect '^l' forward-char


# Alt-W
bindkey  '∑' forward-word
# Alt-B
bindkey  '∫' backward-word

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

# delete function characters to include
# Omitted: /=
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# # }}}
# ASDF: needs to run after ZSH setup {{{

source $(brew --prefix asdf)/libexec/asdf.sh

# }}}
# Aliases --- {{{

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

alias vi='nvim'
alias vim='nvim'

# Tree that ignores annoying directories
alias itree="tree -I '__pycache__|venv|node_modules'"

# Grep, but ignore annoying directories
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias igrep="grep --perl-regexp -Ir \
--exclude='*~' \
--exclude='*.pyc' \
--exclude='*.csv' \
--exclude='*.tsv' \
--exclude='*.md' \
--exclude-dir='.bzr' \
--exclude-dir='.git' \
--exclude-dir='.svn' \
--exclude-dir='node_modules' \
--exclude-dir='venv'"

# enable color support of ls and also add handy aliases
# alias ls='ls --color=auto'
alias ls='ls -G'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# diff
# r: recursively; u: shows line number; p: shows difference in C function
# P: if multiple files then showing complete path
alias diff='diff -rupP'

# Set copy/paste helper functions
# the perl step removes the final newline from the output
# alias pbcopy="perl -pe 'chomp if eof' | xclip -selection clipboard"
# alias pbpaste='xclip -selection clipboard -o'

# Public IP
alias publicip='curl -s checkip.amazonaws.com'

# Git
alias g='git status'
alias gl='git --no-pager branch --verbose --all'
alias gm='git commit --verbose'
alias gma='git add --all && git commit --verbose'
alias gp='git remote prune origin'
alias gd='git diff'
# show a tree of all commits, including dangling unnamed branches
alias githist='git log --graph --decorate --oneline $(git rev-list -g --all)'

# battery
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|time\ to\ full|percentage"'

# alias for say
alias say='spd-say'
compdef _dict_words say

# reload zshrc
alias so='source ~/.zshrc'

# File navigation
alias khalliday='cd ~/src/kevinhalliday/'
alias kh='cd ~/src/kevinhalliday/'
alias playground='cd ~/src/playground/'
alias play='cd ~/src/playground/'
alias rift='cd ~/src/rift/'
alias rfron='cd ~/src/rift/frontend/'
alias rprot='cd ~/src/rift/protocol/'
alias rland='cd ~/src/rift/landing/'
alias rdash='cd ~/src/rift/dashboard/'
alias rdepl='cd ~/src/rift/deploy/'

alias xdg-open='open'

# }}}
# Functions --- {{{

# Tmux Launch
# NOTE: I use the option "-2" to force Tmux to accept 256 colors. This is
# necessary for proper Vim support in the Linux Console. My Vim colorscheme,
# PaperColor, does a lot of smart translation for Color values between 256 and
# terminal 16 color support, and this translation is lost otherwise.
# Steps (assuming index of 1, which requires tmux config):
# 1. Create session in detached mode
# 2. Select first window
# 3. Rename first window to 'edit'
# 4. Attach to session newly-created session
function t() {
  if [ -n "$TMUX" ]; then
    echo 'Cannot run t() in tmux session'
    return 1
  elif [[ $# > 0 ]]; then
    SESSION=$1
  else
    SESSION=Main
  fi
  HAS_SESSION=$(tmux has-session -t $SESSION 2>/dev/null)
  if [ $HAS_SESSION ]; then
    if [[ "$(alacritty-which-colorscheme)" = 'light' ]]; then
      tmux -2 select-window -t $SESSION:1
      tmux source-file ~/.tmux-light
    fi
    tmux -2 attach -t $SESSION
  else
    tmux -2 new-session -d -s $SESSION
    if [[ "$(alacritty-which-colorscheme)" = 'light' ]]; then
      tmux -2 select-window -t $SESSION:1
      tmux source-file ~/.tmux-light
    fi
    tmux -2 attach -t $SESSION
  fi
}

function alacritty-install() {
  cargo build --release

  # Install
  sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database

  # terminfo
  sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

  # man page
  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | \ll
    sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
}


# upgrade relevant local systems
function upgrade() {
  brew update
  brew upgrade
  brew autoremove
  asdf uninstall neovim nightly
  asdf install neovim nightly
  nvim -c 'PU'
}

function dark-prompt {
  GEOMETRY_COLOR_DIR='136'
}

function light-prompt {
  GEOMETRY_COLOR_DIR='220'
}

function update-prompt-colors() {
  local colorscheme="$(alacritty-which-colorscheme)"
  if [[ $colorscheme = 'light' ]]; then
    dark-prompt
  elif [[ $colorscheme = 'dark' ]]; then
    light-prompt
  fi
}

# we will get to  this when we are ready
# update-prompt-colors
# if [ -n "$TMUX" ]; then
#   tmux set-hook after-select-pane 'run "update-prompt-colors > /dev/null"'
#   tmux set-hook after-select-window 'run "update-prompt-colors > /dev/null"'
# fi

# Alacritty Helpers
function dark() {
  alacritty-dark
  if [ ! -z "$TMUX" ]; then
    tmux source-file ~/.tmux.conf
  fi
  light-prompt
}

function light() {
  alacritty-light
  if [ ! -z "$TMUX" ]; then
    tmux source-file ~/.tmux-light
  fi
  dark-prompt
}

function update_zoom() {
  curl -Lsf https://zoom.us/client/latest/zoom_amd64.deb -o /tmp/zoom_amd64.deb
  sudo dpkg -i /tmp/zoom_amd64.deb
}

# Pipe man stuff to neovim
function m() {
  man --location $@ &> /dev/null
  if [ $? -eq 0 ]; then
    man --pager=cat $@ | nvim -c 'set ft=man' -
  else
    man $@
  fi
}
compdef _man m

# dictionary lookups
function def() {  # arg1: word
  dict -d gcide $1
}
compdef _dict_words def

function syn() {  # arg1: word
  dict -d moby-thesaurus $1
}
compdef _dict_words syn

# I type cd so much, I'll just type d instead
function d() { #arg1: directory
  cd $1
}
compdef _dirs d

# Open files with gnome-open
function gn() {  # arg1: filename
  gio open $1
}

function jenkins() {
  java -jar ~/java/jenkins.war ${@}
}

function rustdev-install() {
  cargo install bat
  cargo install fd-find
  cargo install ripgrep
  cargo install cargo-deb
  cargo install cargo-edit
  asdf reshim rust
}

function nodedev-install() {
  local env=(
    dockerfile-language-server-nodejs
    git+https://github.com/Perlence/tstags.git
    jsctags
    neovim
    npm
    prettier
    write-good
  )
  npm install --no-save -g $env
  asdf reshim nodejs
}

# pydev-install: install only env dependencies
# pydev-install dev: install only dev dependencies
# pydev-install all: install all deps
function pydev-install() {  ## Install default python dependencies
  local for_pip=(
    bpython
    mypy
    neovim-remote
    pip
    pylint
    pynvim
    wheel
  )
  pip install -U $for_pip
  asdf reshim python
}

function pyglobal-install() {  ## Install global Python applications
  local for_pipx=(
    awscli
    black
    bpython
    cookiecutter
    docformatter
    docker-compose
    isort
    jedi-language-server
    jupyterlab
    jupytext
    pre-commit
    restview
    toml-sort
  )
  if command -v pipx > /dev/null; then
    for arg in $for_pipx; do
      pipx install "$arg"
      pipx upgrade "$arg"
    done
  else
    echo 'pipx not installed. Install with "pip install pipx"'
  fi
}

function godev-install() {  ## Install default golang dependencies
  go get github.com/mattn/efm-langserver
  asdf reshim golang
}

function contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}


CAIRO_VENV_NAME="cairo_venv"
CAIRO_VENV_DIR="$HOME/$CAIRO_VENV_NAME"
function cairo-install() {
  pyversion=$(python --version)

  if contains "$pyversion" "3.7" || contains "$pyversion" "3.8"; then
    if [ -d "$CAIRO_VENV_DIR" ]; then
      rm -r $CAIRO_VENV_DIR
    fi

    brew install gmp

    python -m venv "$CAIRO_VENV_DIR"
    source "$CAIRO_VENV_DIR/bin/activate"
    cairo-activate

    # special install to handle m1 macs brew isntall gmp placement
    CFLAGS=-I`brew --prefix gmp`/include \
      LDFLAGS=-L`brew --prefix gmp`/lib \
      pip install ecdsa fastecdsa sympy

    pip install cairo-lang
    pydev-install

    return 0
  fi

  echo "Python 3.7 or 3.8 is required to install Cairo"
  return 1
}

function cairo-activate() {
  source "$CAIRO_VENV_DIR/bin/activate"
}


# activate virtual environment from any directory from current and up
# Name of virtualenv
VIRTUAL_ENV_DEFAULT=.venv
function va() {  # No arguments
  local venv_name="$VIRTUAL_ENV_DEFAULT"
  local old_venv=$VIRTUAL_ENV
  local slashes=${PWD//[^\/]/}
  local current_directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    if [ -d "$current_directory/$venv_name" ]; then
      source "$current_directory/$venv_name/bin/activate"
      if [[ "$old_venv" != "$VIRTUAL_ENV" ]]; then
        echo "Activated $(python --version) virtualenv in $VIRTUAL_ENV"
      fi
      return
    fi
    local current_directory="$current_directory/.."
  done
  # If reached this step, no virtual environment found from here to root
  if [[ -z $VIRTUAL_ENV ]]; then
  else
    deactivate
    echo "Disabled existing virtualenv $old_venv"
  fi
}

# Create and activate a virtual environment with all Python dependencies
# installed. Optionally change Python interpreter.
function ve() {  # Optional arg: python interpreter name
  local venv_name="$VIRTUAL_ENV_DEFAULT"
  if [ -z "$1" ]; then
    local python_name='python'
  else
    local python_name="$1"
  fi
  if [ ! -d "$venv_name" ]; then
    $python_name -m venv "$venv_name"
    if [ $? -ne 0 ]; then
      local error_code=$?
      echo "Virtualenv creation failed, aborting"
      return error_code
    fi
    source "$venv_name/bin/activate"
    pip install -U pip
    pydev-install  # install dependencies for editing
    deactivate
  else
    echo "$venv_name already exists, activating"
  fi
  source $venv_name/bin/activate
}
compdef _command ve

# Choose a virtualenv from backed up virtualenvs
# Assumes in current directory, set up with zsh auto completion based on
# current directory.
function vc() {  # Optional arg: python venv version
  if [ -z "$VIRTUAL_ENV" ]; then
    echo "No virtualenv active, skipping backup"
  else
    mkdir -p venv.bak
    local python_version=$(python --version | cut -d ' ' -f 2)
    local bak_dir="venv.bak/$python_version"
    if [ ! -d "$bak_dir" ]; then
      mv "$VIRTUAL_ENV" "$bak_dir"
    else
      echo "ERROR: $bak_dir already exists"
      return 1
    fi
  fi
  if [ -z "$1" ]; then
    return 0
  fi
  local choose_dir="venv.bak/$1"
  if [ ! -d "$choose_dir" ]; then
    echo "ERROR: no such virtualenv $1 backed up"
    return 1
  fi
  mv "$choose_dir" .venv
}
_vc_completion() {
  _directories -W $PWD/venv.bak
}
compdef _vc_completion vc


# Print out the Github-recommended gitignore
export GITIGNORE_DIR=$HOME/lib/gitignore
function gitignore() {
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
compdef "_files -W $GITIGNORE_DIR/" gitignore

# GIT: prune/cleanup the local references to remote branch
# and delete merged local branches
function gc() {
  local refs="$(git remote prune origin --dry-run)"
  if [ -z "$refs" ]
  then
    echo "No prunable references found"
  else
    echo $refs
    while true; do
     read yn\?"Do you wish to prune these local references to remote branches?"
     case $yn in
       [Yy]* ) break;;
       [Nn]* ) return;;
       * ) echo "Please answer yes or no.";;
     esac
    done
    git remote prune origin
    echo "Pruned!"
  fi
​
  local branches="$(git branch --merged master | grep -v '^[ *]*master$')"
  if [ -z "$branches" ]
  then
    echo "No merged branches found"
  else
    echo $branches
    while true; do
     read yn\?"Do you wish to delete these merged local branches?"
     case $yn in
       [Yy]* ) break;;
       [Nn]* ) return;;
       * ) echo "Please answer yes or no.";;
     esac
    done
    echo $branches | xargs git branch -d
    echo "Deleted!"
  fi
}

# Create instance folder with only .gitignore ignored
function mkinstance() {
  mkdir instance
  cat > instance/.gitignore <<EOL
*
!.gitignore
EOL
}

# Initialize Python Repo
function poetry-init() {
  if [ -f pyproject.toml ]; then
    echo "pyproject.toml exists, aborting"
    return 1
  fi
  poetry init --no-interaction &> /dev/null
  # cat-pyproject >> pyproject.toml
  # toml-sort --in-place pyproject.toml
  touch README.md
}

# Create New Python Repo
function pynew() {
  if [ $# -ne 1 ]; then
    echo "pynew <directory>"
    return 1
  fi
  local dir_name="$1"
  if [ -d "$dir_name" ]; then
    echo "$dir_name already exists"
    return 1
  fi
  mkdir "$dir_name"
  cd "$dir_name"
  poetry-init
  gitignore Python.gitignore | grep -v instance/ > .gitignore
  mkinstance
  ve
  cat > main.py <<EOL
"""The main module"""
EOL
}


# GIT: push current branch from origin to current branch
function push() {
  local current_branch="$(git rev-parse --abbrev-ref HEAD)"
  git push -u origin "$current_branch"
}

# GIT: pull current branch from origin to current branch
function pull() {
  local current_branch="$(git rev-parse --abbrev-ref HEAD)"
  git pull origin "$current_branch"
}

# Timer
function countdown-seconds(){
  local date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    ## Is this more than 24h away?
    local days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
  echo ""
  spd-say "Beep, beep, beeeeeeeep. Countdown is finished"
}

function countdown-minutes() {
  countdown-seconds $(($1 * 60))
}

function stopwatch(){
  local date1=`date +%s`;
  while true; do
    local days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

function quote() {
  local cowsay_word_message="$(shuf -n 1 ~/.gre_words.txt)"
  local cowsay_quote="$(fortune -s | grep -v '\-\-' | grep .)"
  echo -e "$cowsay_word_message\n\n$cowsay_quote" | cowsay
}

function dat(){
  if [ $# -ne 1 ]; then
    echo "dat <file_name>"
    return 1
  fi
  local file_name="$1"
  strfile -c % "$file_name" "$file_name.dat"
}

##########################
# Fzf extensions
##########################

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
function fo() {
  local out file key
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# cd into the selected directory
function cdf() {
  local dir
  dir=`find * -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$dir"
}

# fh - repeat history
function fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g' | fzf-tmux +s --tac)
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
function fkill() {
  local pid
  if [ "$UID" != "0" ]; then
      pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
      echo $pid | xargs kill -${1:-9}
  fi
}

# cd to the current git root
function gr() {
  local dir
  dir=`git rev-parse --show-toplevel`

  if [ $? -eq 0 ]; then
    cd "$dir"
    return 0
  else
    return 1
  fi
}


# }}}
# Executed Commands --- {{{

if [[ -o interactive ]]; then
  if [[ "$TMUX_PANE" == "%0" ]]; then
    # if you're in the first tmux pane within all of tmux
    quote
  fi

  # turn off ctrl-s and ctrl-q from freezing / unfreezing terminal
  stty -ixon

  if [[ "$TERM" == "linux" ]]; then
    if [ ! -n "$TMUX" ]; then
      # suppress all messages from the kernel (and its drivers) except panic
      # messages from appearing on the console.
      echo "Enter sudo password to disable kernel from sending console messages..."
      sudo dmesg -n 1
    fi
  fi

  # activate python env, if it exists
  va
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.bash/sensitive ] && source ~/.bash/sensitive

# }}}
