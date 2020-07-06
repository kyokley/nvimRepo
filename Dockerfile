FROM python:3.7-alpine AS builder

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
        git clone https://github.com/neovim/neovim.git && \
        cd neovim && \
        make && \
        make install

FROM python:3.7-alpine AS final
RUN apk add --update --no-cache \
        musl-dev \
        python3-dev \
        gcc \
        git && \
        pip install pip python-language-server[pyflakes] pynvim neovim pyflakes flake8 bandit --upgrade --no-cache-dir


COPY --from=builder /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=builder /usr/local/share/nvim /usr/local/share/nvim

COPY . /root/.config/nvim

RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/usr/local/bin/'#" /root/.config/nvim/configs/plugins.vim && \
        sed -i 's!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 0!' /root/.config/nvim/configs/plugins.vim && \
        sed -i 's!autocmd BufEnter \* let \&titlestring = "nvim " \. expand("%:p")!autocmd BufEnter * let \&titlestring = "dvim " . g:git_root . " " . expand("%:t")!' /root/.config/nvim/configs/autocommands.vim && \
        nvim +'PlugInstall! --sync' +'UpdateRemotePlugins' +qa && \
        sed -i "s!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 1!" /root/.config/nvim/configs/plugins.vim && \
        find /root -name '*.git' -exec rm -rf {} \+

WORKDIR /files

ENTRYPOINT ["nvim"]
