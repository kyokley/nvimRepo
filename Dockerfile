FROM python:3.7-alpine

RUN apk update && \
        apk --no-cache add git \
                           g++ \
                           libtool \
                           autoconf \
                           musl-dev \
                           gcc \
                           python3-dev \
                           make \
                           cmake \
                           pkgconf \
                           lua-md5 \
                           alpine-sdk \
                           unzip \
                           gettext-dev \
                           libintl \
                           icu-dev \
                           musl-dev && \
        pip install pip python-language-server[pyflakes] pynvim neovim pyflakes flake8 bandit --upgrade --no-cache-dir && \
        git clone https://github.com/neovim/neovim.git && \
        cd neovim && \
        make && \
        make install && \
        cd ../ && rm -rf nvim

COPY . /root/.config/nvim
RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/usr/local/bin/'#" $HOME/.config/nvim/configs/plugins.vim && \
        nvim +'PlugInstall --sync' +'UpdateRemotePlugins' +qa && \
        find / -type d -name '*.git' -exec rm -rf {} \+ ; \
        find / -name '__pycache__' -exec rm -rf {} \+ ; \
        exit 0

WORKDIR /files

ENTRYPOINT ["nvim"]
