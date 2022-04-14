#!/bin/bash

set -e

USE_PAMAC=$(which pamac >/dev/null 2>&1 && echo "true" || echo "false")
USE_APT_GET=$(which apt-get >/dev/null 2>&1 && echo "true" || echo "false")

git submodule update --init --recursive

if [ $USE_PAMAC == "true" ]
then
    pamac install xclip neovim uctags-git npm fzf bat

    mkdir -p ~/.local/bin
    ln -s $(which nvim) ~/.local/bin/vim
    sudo ln -s $(which uctags) /usr/bin/ctags
    npm install -g livedown
fi

if [ $USE_APT_GET == "true" ]
then
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim xclip aptitude
    sudo apt-get install -y python3-pip
    sudo apt-get install -y npm fzf bat

    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev exuberant-ctags bat

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

    sudo update-alternatives --config vi
    sudo update-alternatives --config vim
    sudo update-alternatives --config editor

    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    make install # may require extra privileges depending on where to install

    npm install -g livedown
fi

mkdir ~/.config
if [ ! -h ~/.config/nvim ]; then
    ln -s ~/.nvim ~/.config/nvim
fi

nvim +PlugInstall +qall
