FROM debian:stable-slim

SHELL ["/bin/bash", "-c"]

ENV PY27 '2.7.15'
ENV PY3 '3.6.7'

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc

RUN apt-get update && \
        apt-get install -y neovim \
                           git

COPY install_pyenv.sh /root/.config/nvim/
RUN chmod a+x $HOME/.config/nvim/install_pyenv.sh && \
        $HOME/.config/nvim/install_pyenv.sh

RUN export PYENV_ROOT="$HOME/.pyenv" && \
    export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init -)" && \
    eval "$(pyenv virtualenv-init -)"

COPY . /root/.config/nvim
RUN nvim +'PlugInstall --sync' +qa

RUN cd $HOME/.config/nvim/color_blame && \
        $HOME/.pyenv/versions/$PY3/bin/pip install -r requirements.txt --force --upgrade && \
        $HOME/.pyenv/versions/$PY3/bin/python setup.py install --force

CMD ["nvim"]
