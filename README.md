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

## Usage
```
yokley@saturn|~ $ nvim --version
NVIM 0.1.7
Build type: None
Compilation: /usr/bin/cc -g -O2 -fdebug-prefix-map=/build/neovim-wew7PE/neovim-0.1.7=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -DDISABLE_LOG -Wconversion -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1  -Wall -Wextra -pedantic -Wno-unused-parameter -Wstrict-prototypes -std=gnu99 -Wvla -fstack-protector-strong -fdiagnostics-color=auto -DINCLUDE_GENERATED_DECLARATIONS -DHAVE_CONFIG_H -D_GNU_SOURCE -I/build/neovim-wew7PE/neovim-0.1.7/build/config -I/build/neovim-wew7PE/neovim-0.1.7/src -I/usr/include -I/usr/include -I/usr/include -I/usr/include -I/usr/include -I/usr/include -I/usr/include -I/build/neovim-wew7PE/neovim-0.1.7/build/src/nvim/auto -I/build/neovim-wew7PE/neovim-0.1.7/build/include
Compiled by pkg-vim-maintainers@lists.alioth.debian.org

Optional features included (+) or not (-): +acl   +iconv    +jemalloc +tui
For differences from Vim, see :help vim-differences

   system vimrc file: "$VIM/sysinit.vim"
  fall-back for $VIM: "/usr/share/nvim"
```
```
yokley@saturn|~ $ nvim hello_world.txt
```
