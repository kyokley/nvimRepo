#!/bin/bash

PY3='3.9.7'

if [ ! -h $HOME/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
fi

if [ ! -h $HOME/.pyenv/plugins/pyenv-virtualenv ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
fi

if [ ! -h $HOME/.pyenv/plugins/pyenv-update ]; then
    git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
fi


export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VERSION="$PY3"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pip install poetry

pyenv install $PY3

pyenv virtualenv-delete neovim3
pyenv virtualenv $PY3 neovim3

pyenv shell neovim3
pip install pip --upgrade
poetry install
pyenv which python  # Note the path

pyenv global $PY3
pip install pip --upgrade
