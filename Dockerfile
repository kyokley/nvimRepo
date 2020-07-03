FROM python:3.7-alpine

RUN apk update && \
        apk --no-cache add \
            alpine-sdk \
            autoconf \
            automake \
            cmake \
            g++ \
            gcc \
            gettext-dev \
            git \
            icu-dev \
            libintl \
            libtool \
            lua-md5 \
            m4 \
            make \
            musl-dev \
            pkgconf \
            python3-dev \
            unzip \
            && \
        pip install pip python-language-server[pyflakes] pynvim neovim pyflakes flake8 bandit --upgrade --no-cache-dir && \
        git clone https://github.com/neovim/neovim.git && \
        cd neovim && \
        make && \
        make install && \
        cd ../ && rm -rf neovim

COPY . /root/.config/nvim
RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/usr/local/bin/'#" $HOME/.config/nvim/configs/plugins.vim && \
        nvim +'PlugInstall --sync' +'UpdateRemotePlugins' +qa && \
        find / -type d -name '*.git' -exec rm -rf {} \+ ; \
        find / -name '__pycache__' -exec rm -rf {} \+ ; \
        apk del \
            alpine-sdk \
            autoconf \
            automake \
            cmake \
            g++ \
            gcc \
            icu-dev \
            libintl \
            libtool \
            lua-md5 \
            m4 \
            make \
            pkgconf \
            python3-dev \
            unzip

WORKDIR /files

ENTRYPOINT ["nvim"]
