FROM python:3.7-slim-buster

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
        apt-get install -y --no-install-recommends neovim python3-neovim git && \
        git clone https://github.com/kyokley/color_blame.git /tmp/color_blame && \
        cd /tmp/color_blame && \
        pip install -r requirements.txt --force --upgrade && \
        pip install python-language-server[all] pynvim neovim pip pyflakes flake8 bandit black isort --upgrade && \
        python setup.py install --force

COPY . /root/.config/nvim
RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/usr/local/bin/'#" $HOME/.config/nvim/configs/plugins.vim && \
        sed -i "s#let g:black_virtualenv.*##" $HOME/.config/nvim/configs/plugins.vim && \
        nvim +'PlugInstall --sync' +'UpdateRemotePlugins' +qa && \
        apt-get purge -y git && \
        apt-get autoremove -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* && \
        find / -type d -name '*.git' -exec rm -rf {} \+ ; \
        find / -name '__pycache__' -exec rm -rf {} \+ ; \
        exit 0

WORKDIR /files

ENTRYPOINT ["nvim"]
