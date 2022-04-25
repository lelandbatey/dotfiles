#!/bin/bash
# Install with
#
# curl https://raw.githubusercontent.com/lelandbatey/dotfiles/master/autoinstall.sh | sh

sudo apt-get update
sudo apt-get -y install git make htop python3.8-venv

# Change the default login shell to bash
sudo chsh -s $(which bash) $(echo $USER)


if [ ! -d "$HOME/bin" ]; then
	mkdir "$HOME/bin"
fi

if [ ! -d "$HOME/bin/venv" ]; then
	python3 -m venv "$HOME/bin/venv-3"
fi


# Installs all parts of my dotfiles repository
cd ~
git clone "https://github.com/lelandbatey/dotfiles.git"
cd dotfiles

python3 install.py --act safe
#python3 install.py --act prepvim
#python3 install.py --act bashmarks
