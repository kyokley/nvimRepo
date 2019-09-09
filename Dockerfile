FROM python:3.7-slim-buster

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
        apt-get install -y neovim python3-neovim \
        git

RUN git clone https://github.com/kyokley/color_blame.git /tmp/color_blame
RUN cd /tmp/color_blame && \
        pip install -r requirements.txt --force --upgrade && \
        pip install python-language-server[all] neovim pip pyflakes flake8 bandit black isort --upgrade && \
        python setup.py install --force

COPY . /root/.config/nvim
RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/usr/local/bin/'#" $HOME/.config/nvim/configs/plugins.vim && \
        sed -i "s#let g:black_virtualenv.*##" $HOME/.config/nvim/configs/plugins.vim
RUN nvim +'PlugInstall --sync' +'UpdateRemotePlugins' +qa

RUN rm -rf /var/lib/apt/lists/*
RUN find / -type d -name '*.git' -exec rm -rf {} \+

WORKDIR /files

ENTRYPOINT ["nvim"]
