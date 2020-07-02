FROM python:3.7-slim

RUN apt-get update && \
        apt-get install -y --no-install-recommends neovim python3-neovim git gcc python-dev && \
        pip install python-language-server[all] pynvim neovim pyflakes flake8 bandit --upgrade --no-cache-dir && \
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
