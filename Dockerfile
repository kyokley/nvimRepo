FROM kyokley/color_blame AS color_blame

FROM python:3.8-alpine AS builder

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
            xclip \
            && \
        git clone https://github.com/neovim/neovim.git && \
        cd neovim && \
        make && \
        make install

FROM python:3.8-alpine AS py-builder
ENV VIRTUAL_ENV=/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apk add --update --no-cache \
        python3-dev \
        g++ \
        gcc \
        && \
        pip install pip python-language-server[pyflakes] pynvim neovim pyflakes flake8 bandit --upgrade --no-cache-dir

FROM python:3.8-alpine AS base

RUN apk add --update --no-cache \
        musl-dev \
        gcc \
        xclip \
        && \
        pip install pynvim pip --upgrade --no-cache-dir

COPY --from=builder /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=builder /usr/local/share/nvim /usr/local/share/nvim

WORKDIR /files
ENTRYPOINT ["nvim"]


FROM base AS custom
ENV PATH="$PATH:/color_blame_venv/bin"
COPY --from=color_blame /venv /color_blame_venv
COPY --from=py-builder /venv /nvim_venv

RUN apk add --update --no-cache \
        python3-dev \
        git \
        the_silver_searcher \
        ctags \
        less

COPY . /root/.config/nvim

RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/nvim_venv/bin/'#" /root/.config/nvim/configs/plugins.vim && \
        sed -i 's!endif!source $HOME/.config/nvim/configs/docker.vim\nendif!' /root/.config/nvim/init.vim && \
        sed -i 's!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 0!' /root/.config/nvim/configs/plugins.vim && \
        sed -i 's!autocmd BufEnter \* let \&titlestring = "nvim " \. expand("%:p")!autocmd BufEnter * let \&titlestring = exists("git_root") \? "dvim (" . g:git_root . ") " . expand("%:p")[len("/files") + 1:] : "dvim " . expand("%:p")!' /root/.config/nvim/configs/autocommands.vim && \
        nvim +'PlugInstall! --sync' +'UpdateRemotePlugins' +qa && \
        sed -i "s!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 1!" /root/.config/nvim/configs/plugins.vim && \
        find /root -name '*.git' -exec rm -rf {} \+

WORKDIR /files

ENTRYPOINT ["nvim"]
