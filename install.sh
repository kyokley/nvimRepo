#!/bin/bash

export NON_ROOT_USER=yokley
sudo chown $NON_ROOT_USER:$NON_ROOT_USER -R .git

git submodule update --init --recursive
#sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y libtool libtool-bin

#sudo apt-get install -y neovim
current_dir=$(pwd)
wget https://github.com/neovim/neovim/archive/v0.2.0.tar.gz -O /tmp/neovim.tar.gz
cd /tmp
tar -xvzf /tmp/neovim.tar.gz
cd neovim-0.2.0
make
sudo make install
cd $current_dir

sudo apt-get install -y xclip aptitude
sudo aptitude install -y python-pip python3-pip

sudo update-alternatives --install /usr/bin/vi vi $(which nvim) 60
sudo update-alternatives --install /usr/bin/vim vim $(which nvim) 60
sudo update-alternatives --install /usr/bin/editor editor $(which nvim) 60

sudo update-alternatives --config vi
sudo update-alternatives --config vim
sudo update-alternatives --config editor

mkdir ~/.config
if [ ! -h ~/.config/nvim ]; then
    ln -s ~/.nvim ~/.config/nvim
fi

sudo pip install neovim
sudo pip3 install neovim
sudo pip install bandit
nvim -c ':PlugInstall'

cd color_blame
sudo pip install -r requirements.txt --force --upgrade
sudo python setup.py install --force
cd ..
sudo chown $NON_ROOT_USER:$NON_ROOT_USER -R .git
