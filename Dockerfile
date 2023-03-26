ARG BASE_IMAGE=python:3.11-alpine

FROM kyokley/color_blame AS color_blame

FROM ${BASE_IMAGE} AS builder

RUN apk update && \
        apk --no-cache add \
            alpine-sdk \
            autoconf \
            automake \
            cmake \
            g++ \
            git \
            musl-dev \
            pkgconf \
            && \
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
        python-lsp-server[all] \
        pynvim \
        neovim \
        pyflakes \
        flake8 \
        bandit \
        ruff \
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
ENV PATH="$PATH:/venv/bin:/color_blame_venv/bin"

RUN apk update && apk add --no-cache \
        git \
        jansson \
        fzf \
        bash \
        ripgrep \
        less

COPY --from=color_blame /venv /color_blame_venv
COPY --from=py-builder /venv /venv

COPY --from=builder /usr/local/bin/ctags /usr/local/bin/ctags


COPY . /root/.config/nvim

# Pre-setup steps before installing plugins
# Specifically we need to temporarily disable deoplete
RUN sed -i "s#^vim.g.python3_dir.*#vim.g.python3_dir = '/venv/bin/'#" /root/.config/nvim/configs/plugins.lua && \
        sed -i 's!endif!source $HOME/.config/nvim/configs/docker.lua\nendif!' /root/.config/nvim/init.vim && \
        sed -i 's!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 0!' /root/.config/nvim/configs/plugins.lua && \
        sed -i 's!autocmd BufEnter \* let \&titlestring = "nvim " \. expand("%:p")!autocmd BufEnter * let \&titlestring = exists("git_root") \? "dvim (" . g:git_root . ") " . expand("%:p")[len("/files") + 1:] : "dvim " . expand("%:p")!' /root/.config/nvim/configs/autocommands.lua && \
        sed -i 's!docker run --rm -i kyokley/sqlparse!python -c "import sys, sqlparse; lines = \\"\\n\\".join(sys.stdin.readlines()); print(sqlparse.format(lines, reindent=True))"!' /root/.config/nvim/configs/keybindings.lua

# Install plugins and re-enable deoplete
RUN nvim +'PlugInstall! --sync' +'UpdateRemotePlugins' +qa && \
        sed -i "s!let g:deoplete#enable_at_startup.*!let g:deoplete#enable_at_startup = 1!" /root/.config/nvim/configs/plugins.lua && \
        git config --global --add safe.directory /files && \
        find /root -name '*.git' -exec rm -rf {} \+
