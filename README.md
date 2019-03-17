# NeoVim Config!

To use the dockerized version of this, add a function similar to the following to .bashrc (.zshenv):
```
nvim() {
    docker run \
        --rm -it \
        -v $(pwd):/files \
        kyokley/neovim:latest \
        "$@"
       }
```
