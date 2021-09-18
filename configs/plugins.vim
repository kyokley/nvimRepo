" Install Plugins {{{
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
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'luochen1990/rainbow'
Plug 'kyokley/vim-colorschemes'
Plug 'whiteinge/diffconflicts'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vader.vim'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'kana/vim-textobj-user'
Plug 'thalesmello/vim-textobj-multiline-str'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'moll/vim-bbye'
Plug 'liuchengxu/vista.vim'
Plug 'shime/vim-livedown'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'

Plug '~/.config/nvim/manual/togglecomment'
Plug '~/.config/nvim/manual/pyfold'
Plug '~/.config/nvim/manual/visincr'
Plug '~/.config/nvim/manual/django-custom'
call plug#end()

filetype plugin indent on
" }}}

" Bufferline {{{
" let g:bufferline_fname_mod = ':p'
let g:bufferline_pathshorten = 1
let g:bufferline_rotate = 2
" }}}

" QuickSilver Config {{{
let g:QSMatchFn = 'fuzzy'
let g:QSIgnore = ".*\.pyc$;.*\.swp$;__pycache__$"
" }}}

" NERDTree {{{
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.pyc$', '\.swp$']
" }}}

" Python configs {{{
let g:loaded_python_provider = 0
let g:python3_dir = $HOME . '/.pyenv/versions/neovim3/bin/'

let g:python3_host_prog = g:python3_dir . 'python'
" }}}

" SuperTab {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" }}}

" Rainbow Config {{{
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
" }}}

" ALE Config {{{
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_executable = g:python3_dir . 'flake8'
let g:ale_completion_enabled = 0
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
" Check functions.vim for highlighting settings
" }}}

" GitGutter {{{
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
" }}}

" Jedi {{{
let g:jedi#completions_enabled = 0
let g:jedi#documentation_command=''
let g:jedi#show_call_signatures = "0"
" }}}

" CoC {{{

" }}}

" AsyncRun {{{
let g:asyncrun_open = 10
let g:asyncrun_bell = 1
" }}}

" Rooter {{{
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1
" }}}

" Semshi {{{
let g:semshi#error_sign = v:false
" }}}

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        -- disable = { "python", },  -- list of language that will be disabled
    },
}
EOF

" {{{ Vista
let g:vista_highlight_whole_line = 1
let g:vista_blank = [0, 0]
let g:vista_top_level_blink = [0, 0]
let g:vista_echo_cursor = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_cursor_delay = 1000
" }}}

" {{{ FZF
nnoremap <silent> <C-p> :<C-u>exe
        \ finddir('.git', ';') != ''
        \   ? 'GFiles'
        \   : findfile('.git', ';') != ''
        \       ? 'GFiles' : 'Files'<CR>

nnoremap <silent> <leader>8 :<C-u>call ProjectGrep(1, expand("<cword>"))<CR>

nnoremap <leader>a :<C-u>call ProjectGrep(0)<CR>
" }}}
