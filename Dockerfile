ARG BASE_IMAGE=python:3.11-alpine

FROM kyokley/color_blame AS color_blame

FROM ${BASE_IMAGE} AS builder

RUN apk update && \
        apk --no-cache add \
            alpine-sdk \
            autoconf \
            automake \
            bash \
            cmake \
            g++ \
            git \
            linux-headers \
            musl-dev \
            pkgconf \
            samurai \
            && \
        git clone https://github.com/universal-ctags/ctags.git && \
        cd ctags && \
        ./autogen.sh && \
        ./configure && \
        make && \
        make install && \
        cd / && \
        git clone https://github.com/LuaLS/lua-language-server && \
        cd lua-language-server && \
        ./make.sh


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
        python-lsp-server \
        pynvim \
        neovim \
        pyflakes \
        flake8 \
        bandit \
        ruff \
        ruff-lsp \
        sqlparse \
        wheel

FROM ${BASE_IMAGE} AS base

RUN apk update && apk add --no-cache \
        neovim \
        xclip \
        && \
        pip install wheel pynvim pip --upgrade --no-cache-dir

WORKDIR /files
ENTRYPOINT ["nvim"]


FROM base AS custom
ENV COLORIZE_VERSION=0.4.0
ENV PATH="$PATH:/venv/bin:/color_blame_venv/bin:/lua-language-server/bin"

RUN apk update && apk add --no-cache \
        g++ \
        git \
        jansson \
        fzf \
        bash \
        ripgrep \
        libffi-dev \
        less

COPY --from=py-builder /venv /venv

COPY --from=builder /usr/local/bin/ctags /usr/local/bin/ctags
COPY --from=builder /lua-language-server /lua-language-server

COPY --from=color_blame /venv /color_blame_venv
COPY --from=color_blame /color_blame_src /color_blame_src

WORKDIR /color_blame_src/dist
RUN /color_blame_venv/bin/pip install colorize-*-py3-none-any.whl

WORKDIR /files

COPY . /root/.config/nvim

# Pre-setup steps before installing plugins
# Specifically we need to temporarily disable deoplete
RUN sed -i "s#^vim.g.python3_dir.*#vim.g.python3_dir = '/venv/bin/'#" /root/.config/nvim/configs/plugins.lua && \
        sed -i 's!endif!source $HOME/.config/nvim/configs/docker.lua\nendif!' /root/.config/nvim/init.vim && \
        sed -i 's!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 0!' /root/.config/nvim/configs/plugins.lua && \
        sed -i 's!autocmd BufEnter \* let \&titlestring = "nvim " \. expand("%:p")!autocmd BufEnter * let \&titlestring = exists("git_root") \? "dvim (" . g:git_root . ") " . expand("%:p")[len("/files") + 1:] : "dvim " . expand("%:p")!' /root/.config/nvim/configs/autocommands.lua && \
        sed -i 's!docker run --rm -i kyokley/sqlparse!python -c "import sys, sqlparse; lines = \\"\\n\\".join(sys.stdin.readlines()); print(sqlparse.format(lines, reindent=True))"!' /root/.config/nvim/configs/keybindings.lua

# Install plugins and re-enable deoplete
RUN nvim --headless +'PlugInstall! --sync' +'UpdateRemotePlugins' +qa && \
        sed -i "s!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 1!" /root/.config/nvim/configs/plugins.lua && \
        git config --global --add safe.directory /files && \
        find /root -name '*.git' -exec rm -rf {} \+ && \
        nvim --headless +'TSInstallSync python bash' +qa
