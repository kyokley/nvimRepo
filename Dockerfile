ARG BASE_IMAGE=python:3.9-alpine

FROM kyokley/color_blame AS color_blame

FROM ${BASE_IMAGE} AS builder

RUN apk update && \
        apk --no-cache add \
            alpine-sdk \
            autoconf \
            automake \
            cmake \
            g++ \
            gettext-dev \
            git \
            icu-dev \
            libintl \
            libtool \
            jansson-dev \
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
        make install && \
        cd - && \
        git clone https://github.com/universal-ctags/ctags.git && \
        cd ctags && \
        ./autogen.sh && \
        ./configure && \
        make && \
        make install


FROM ${BASE_IMAGE} AS py-builder
ENV VIRTUAL_ENV=/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apk update && apk add --no-cache \
        python3-dev \
        g++ \
        && \
        pip install \
        --upgrade --no-cache-dir \
        pip \
        python-language-server[pyflakes] \
        pynvim \
        neovim \
        pyflakes \
        flake8 \
        bandit \
        wheel

FROM ${BASE_IMAGE} AS base

RUN apk update && apk add --no-cache \
        musl-dev \
        g++ \
        xclip \
        && \
        pip install wheel pynvim pip --upgrade --no-cache-dir

COPY --from=builder /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=builder /usr/local/share/nvim /usr/local/share/nvim

WORKDIR /files
ENTRYPOINT ["nvim"]


FROM base AS custom
ENV PATH="$PATH:/color_blame_venv/bin"

RUN apk update && apk add --no-cache \
        python3-dev \
        git \
        jansson \
        the_silver_searcher \
        fzf \
        bash \
        ripgrep \
        less

COPY --from=color_blame /venv /color_blame_venv
COPY --from=py-builder /venv /venv

COPY --from=builder /usr/local/bin/ctags /usr/local/bin/ctags


COPY . /root/.config/nvim

RUN sed -i "s#let g:python3_dir.*#let g:python3_dir = '/venv/bin/'#" /root/.config/nvim/configs/plugins.vim && \
        sed -i 's!endif!source $HOME/.config/nvim/configs/docker.vim\nendif!' /root/.config/nvim/init.vim && \
        sed -i 's!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 0!' /root/.config/nvim/configs/plugins.vim && \
        sed -i 's!autocmd BufEnter \* let \&titlestring = "nvim " \. expand("%:p")!autocmd BufEnter * let \&titlestring = exists("git_root") \? "dvim (" . g:git_root . ") " . expand("%:p")[len("/files") + 1:] : "dvim " . expand("%:p")!' /root/.config/nvim/configs/autocommands.vim && \
        sed -Ei 's!" (autocmd cursorhold \* execute "mode")!\1!' /root/.config/nvim/configs/autocommands.vim && \
        sed -i 's!docker run --rm -i kyokley/sqlparse!python -c "import sys, sqlparse; lines = \\"\\n\\".join(sys.stdin.readlines()); print(sqlparse.format(lines, reindent=True))"!' /root/.config/nvim/configs/keybindings.vim && \
        nvim +'PlugInstall! --sync' +'UpdateRemotePlugins' +qa && \
        sed -i "s!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 1!" /root/.config/nvim/configs/plugins.vim && \
        git config --global --add safe.directory /files && \
        find /root -name '*.git' -exec rm -rf {} \+

WORKDIR /files

ENTRYPOINT ["nvim"]
