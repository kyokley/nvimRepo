#!/bin/bash

set -e

USE_PAMAC=$(which pamac >/dev/null 2>&1 && echo "true" || echo "false")
USE_APT_GET=$(which apt-get >/dev/null 2>&1 && echo "true" || echo "false")

git submodule update --init --recursive

if [ $USE_PAMAC == "true" ]
then
    pamac install xclip neovim uctags-git npm fzf bat lua-language-server

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
    sudo apt-get install -y npm fzf

    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev exuberant-ctags automake

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

    sudo update-alternatives --config vi
    sudo update-alternatives --config vim
    sudo update-alternatives --config editor

    rm -rf /tmp/ctags || true
    cd /tmp
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    sudo make install # may require extra privileges depending on where to install

    sudo npm install -g livedown

    sudo apt-get install -y ninja-build
    rm -rf /tmp/lua-language-server || true
    cd /tmp
    git clone https://github.com/LuaLS/lua-language-server
    cd lua-language-server
    ./make.sh

    sudo rm /usr/local/lib/lua-language-server || true
    sudo mv build/bin /usr/local/lib/lua-language-server

cat <<EOF | sudo tee /usr/local/bin/lua-language-server
#!/bin/bash
exec "/usr/local/lib/lua-language-server/lua-language-server" "\$@"
EOF
    sudo chmod a+x /usr/local/bin/lua-language-server

fi

mkdir -p ~/.config
if [ ! -h ~/.config/nvim ]; then
    ln -s ~/.nvim ~/.config/nvim
fi

nvim +PlugInstall +qall
