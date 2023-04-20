#!/bin/bash

PY3='3.10.0'

USE_APT_GET=$(which apt-get >/dev/null 2>&1 && echo "true" || echo "false")

if [ $USE_APT_GET == "true" ]
then
    sudo apt-get update
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev python3-pip
fi

if [ ! -h $HOME/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
fi

if [ ! -h $HOME/.pyenv/plugins/pyenv-virtualenv ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
fi

if [ ! -h $HOME/.pyenv/plugins/pyenv-update ]; then
    git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
fi

if [ ! -h $HOME/.pyenv/plugins/pyenv-default-packages ]; then
    git clone https://github.com/jawshooah/pyenv-default-packages.git $HOME/.pyenv/plugins/pyenv-default-packages
fi

export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VERSION="$PY3"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

cat <<EOF >> $(pyenv root)/default-packages
pdbpp
bpython
wheel
pynvim
pyflakes
flake8
bandit
jedi
poetry
ruff
python-lsp-ruff
python-lsp-server[all]
EOF
cat $(pyenv root)/default-packages | sort -u > $(pyenv root)/default-packages

pyenv install $PY3

pyenv virtualenv-delete neovim3
pyenv virtualenv $PY3 neovim3

pyenv shell neovim3
pip install pip --upgrade
pip install python-language-server[all] neovim pip pyflakes flake8 bandit --upgrade
pyenv which python  # Note the path

pyenv global $PY3
pip install pip --upgrade
