FROM python:3.7-slim

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
        apt-get install -y --no-install-recommends neovim python3-neovim git gcc python-dev && \
        git clone https://github.com/kyokley/color_blame.git /tmp/color_blame && \
        cd /tmp/color_blame && \
        pip install -U pip --no-cache-dir && \
        pip install -r requirements.txt --force --upgrade --no-cache-dir && \
        pip install python-language-server[all] pynvim neovim pyflakes flake8 bandit --upgrade --no-cache-dir && \
        find / -name '*.git' -exec rm -rf {} \+ ; \
        python setup.py install --force && \
        apt-get autoremove -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

COPY . /root/.config/nvim
RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/usr/local/bin/'#" $HOME/.config/nvim/configs/plugins.vim && \
        nvim +'PlugInstall --sync' +'UpdateRemotePlugins' +qa && \
        find / -type d -name '*.git' -exec rm -rf {} \+ ; \
        find / -name '__pycache__' -exec rm -rf {} \+ ; \
        exit 0

WORKDIR /files

ENTRYPOINT ["nvim"]
