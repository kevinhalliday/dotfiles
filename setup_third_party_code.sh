#!/bin/bash

# installs useful programs on system
# assumes you are using Linux Mint
# RECOMMENDATION:
#   read document and type these commands yourself
#   especially if you are using one of the latest Linux distributions.
#   Things may have changed on the internet between now and your runtime.

set -e

#######################################################################
# Alternative package managers
#######################################################################
sudo apt install snapd

#######################################################################
# Man pages for Linux Systems Programming
#######################################################################
sudo apt install manpages-dev manpages-posix-dev

#######################################################################
# Install packages
#######################################################################
sudo apt install stow
sudo apt install shellcheck
sudo apt install urlview # for tmux url view plugin

#######################################################################
# Typing
#######################################################################
sudo apt install typespeed

#######################################################################
# Offline dictionary
#######################################################################
sudo apt install dict
sudo apt install dict-gcide dict-moby-thesaurus

#######################################################################
# Build, version control, and getting code for elsewhere
#######################################################################
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
sudo apt install build-essential
sudo apt install curl

#######################################################################
# Copy functionality
#######################################################################
sudo apt install xsel xclip

#######################################################################
# Fun stuff
#######################################################################
sudo apt install fortune fortunes cowsay bsdgames bsdgames-nonfree

#######################################################################
# Install more C Stuff
#######################################################################
sudo apt install cmake llvm-6.0 llvm-6.0-dev libclang-6.0-dev

#######################################################################
# NeoVim
#######################################################################
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
sudo apt install python-dev python-pip python3-dev python3-pip

#######################################################################
# Tmux
#######################################################################
sudo apt install tmux

#######################################################################
# System monitoring
#######################################################################
sudo apt install htop tree

#######################################################################
# Python 3
#######################################################################
sudo apt install python3-dev
sudo apt install python3-virtualenv

#######################################################################
# MySQL
#######################################################################
sudo apt install libmysqlclient-dev

#######################################################################
# Latex
#######################################################################
sudo apt install texlive-full

# getting tlmgr (the texlive package manager) to work
sudo apt install xzdec

# font used for "metropolis" theme
sudo apt install fonts-firacode

#######################################################################
# Diagramming
#######################################################################
sudo apt install graphviz
sudo apt install gthumb

# plantuml
if [ ! -d ~/java ]; then
  mkdir ~/java
fi
wget -O ~/java/plantuml.jar \
  http://sourceforge.net/projects/plantuml/files/plantuml.jar/download

#######################################################################
# PDF Viewer with vi bindings
#######################################################################
sudo apt install zathura

#######################################################################
# Colorize cats output
#######################################################################
sudo apt install python-pygments

#######################################################################
# PyEnv
#######################################################################

# dependencies for curses
sudo apt install libncurses5 libncurses5-dev libncursesw5

#######################################################################
# Hovercraft! (an impress generator)
# both steps are included to have the latest version AND the man page
#######################################################################
sudo apt install hovercraft
pip install hovercraft

#######################################################################
# Rust packages
#######################################################################
cargo install ripgrep
cargo install fd-find
rustup component add rustfmt-preview
rustup component add rust-src
rustup toolchain add nightly
cargo +nightly install racer

#######################################################################
# zplug
#######################################################################
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

#######################################################################
# tpm: Tmux Plugin Manager
#######################################################################
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#######################################################################
# Vim tagbar
#######################################################################
cd ~/src/lib && \
git clone https://github.com/jszakmeister/rst2ctags && \
cd ~

#######################################################################
# previewing RST files
# don't recommend using sudo with this one
#######################################################################
pip install restview

#######################################################################
# Inkscape (a great svg drawing program)
#######################################################################
sudo snap install inkscape

#######################################################################
# zshell
#######################################################################
sudo apt install zsh
# without sudo (makes zsh default shell):
chsh -s "$(which zsh)"

#######################################################################
# Jenkins
#######################################################################
wget -O ~/java/jenkins.war \
  http://mirrors.jenkins.io/war-stable/latest/jenkins.war
cd ~/bin

#######################################################################
# Install language binary managers
#######################################################################

 Java: SKD-Manager
######################################################################
 curl -s "https://get.sdkman.io" | bash

# Go: GoEnv
#######################################################################
git clone https://github.com/syndbg/goenv.git ~/.goenv

# Javascript (Node): NodeEnv
#######################################################################
git clone https://github.com/nodenv/nodenv.git ~/.nodenv

# optionally compile source
cd ~/.nodenv && src/configure && make -C src

# install node-build as nodenv plugin
git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build

# install nodeenv-package-rehash (so I don't need to run rehash manually)
# git clone https://github.com/nodenv/nodenv-package-rehash.git "$(nodenv root)"/plugins/nodenv-package-rehash
# nodenv package-hooks install --all

# Javascript: Yarn
#######################################################################
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get install yarn

# Ruby: RbEnv
#######################################################################
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Python: PyEnv
#######################################################################
# install dependencies
sudo apt install \
  git python-pip make build-essential libssl-dev \
  zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev

# move pyenv into repository
git clone https://github.com/yyuu/pyenv.git ~/.pyenv

# example command to list all available python versions for pyenv
# pyenv global system 3.6.1

# Terraform: TfEnv
#######################################################################
git clone https://github.com/kamatama41/tfenv.git ~/.tfenv
