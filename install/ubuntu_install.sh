#!/bin/bash

export NON_ROOT_USER=$USER
sudo chown $NON_ROOT_USER:$NON_ROOT_USER -R .git

git submodule update --init --recursive
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim xclip aptitude
sudo aptitude install -y python-pip python3-pip

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

sudo update-alternatives --config vi
sudo update-alternatives --config vim
sudo update-alternatives --config editor

mkdir ~/.config
if [ ! -h ~/.config/nvim ]; then
    ln -s ~/.nvim ~/.config/nvim
fi

nvim -c ':PlugInstall'