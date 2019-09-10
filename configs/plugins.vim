filetype off
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tommcdo/vim-exchange'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'kyokley/quicksilver.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-bufferline'
" Plug 'kyokley/JavaScript-Indent'
" Plug 'jelera/vim-javascript-syntax'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'ervandew/supertab'
Plug 'tomlion/vim-solidity'
Plug 'luochen1990/rainbow'
Plug 'kyokley/vim-colorschemes'
Plug 'whiteinge/diffconflicts'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vader.vim'
Plug 'w0rp/ale'
" Plug 'Vimjas/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fisadev/vim-isort'
Plug 'skywind3000/asyncrun.vim'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'
Plug 'ambv/black'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-startify'
Plug 'ctrlpvim/ctrlp.vim'

Plug '~/.config/nvim/manual/togglecomment'
Plug '~/.config/nvim/manual/pyfold'
Plug '~/.config/nvim/manual/visincr'
Plug '~/.config/nvim/manual/django-custom'
call plug#end()

filetype plugin indent on

" Polyglot
let g:polyglot_disabled = ['csv']

"Black
let g:black_virtualenv = '~/.pyenv/versions/neovim3'

"QuickSilver Config
let g:QSMatchFn = 'fuzzy'
let g:QSIgnore = ".*\.pyc$;.*\.swp$"

"NERDTree
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.pyc$', '\.swp$']

"Tagbar
let g:tagbar_autofocus = 1

" Python configs
let g:loaded_python_provider = 0
let g:python3_dir = $HOME . '/.pyenv/versions/neovim3/bin/'

let g:python3_host_prog = g:python3_dir . 'python'

"SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

"NVim configs
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
set inccommand=split
set guicursor=

" Rainbow Config
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['darkmagenta', 'darkgreen', 'darkyellow', 'blue', 'lightred'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \       'diff': 0,
    \   }
    \}

" ALE Config
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_executable = g:python3_dir . 'flake8'
let g:ale_python_isort_use_global = 1
let g:ale_python_isort_executable = g:python3_dir . 'isort'
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 100
let g:ale_lint_on_enter = 1
let g:ale_enabled = 1
let g:ale_set_signs = 1
let g:ale_sign_offset = 2000
let g:ale_set_highlights = 1
let g:ale_sign_warning = '->'
let g:ale_linters = {
            \ 'python': ['flake8'],
            \}
" highlight link ALEWarning WildMenu
highlight clear ALEWarning
highlight link ALEWarningSign WildMenu
highlight link ALEError SpellBad
highlight link ALEErrorSign ALEError
" set completeopt=menu,menuone,preview,noselect,noinsert " Need this for ALE completion to work right?
"

" GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#documentation_command=''

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 100

" AsyncRun
let g:asyncrun_open = 10
let g:asyncrun_bell = 1

" Rooter
let g:rooter_silent_chdir = 1

" Semshi
let g:semshi#error_sign = v:false

" Python PEP-8 Indent
let g:python_pep8_indent_hang_closing = 0

" GitMessenger (https://github.com/rhysd/git-messenger.vim)
let g:git_messenger_always_into_popup = v:true
