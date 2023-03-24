let $MYVIMRC = $HOME."/.config/nvim/init.vim"
let $PYTHONUNBUFFERED = 1

if !exists('g:vscode')
    source $HOME/.config/nvim/configs/plugins.lua
    source $HOME/.config/nvim/configs/functions.lua
    source $HOME/.config/nvim/configs/autocommands.vim
    source $HOME/.config/nvim/configs/general_settings.vim
    source $HOME/.config/nvim/configs/keybindings.lua
    source $HOME/.config/nvim/configs/status_line.lua
endif
