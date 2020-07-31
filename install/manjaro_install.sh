#!/bin/bash

git submodule update --init --recursive
pamac install xclip neovim ctags

mkdir ~/.config
if [ ! -h ~/.config/nvim ]; then
    ln -s ~/.nvim ~/.config/nvim
fi

nvim +PlugInstall +qall

mkdir -p ~/.local/bin
ln -s $(which nvim) ~/.local/bin/vim
