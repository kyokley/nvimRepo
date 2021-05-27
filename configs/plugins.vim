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
Plug 'mileszs/ack.vim'
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
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'skywind3000/asyncrun.vim'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'Shougo/denite.nvim'
Plug 'chemzqm/denite-git'
Plug 'drzel/vim-line-no-indicator'
Plug 'wellle/context.vim'
" Plug 'romainl/vim-cool'
Plug 'kana/vim-textobj-user'
Plug 'thalesmello/vim-textobj-multiline-str'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'moll/vim-bbye'
Plug 'liuchengxu/vista.vim'
Plug 'shime/vim-livedown'

Plug '~/.config/nvim/manual/togglecomment'
Plug '~/.config/nvim/manual/pyfold'
Plug '~/.config/nvim/manual/visincr'
Plug '~/.config/nvim/manual/django-custom'
call plug#end()

filetype plugin indent on
" }}}

" Context Settings {{{
let g:context_add_mappings = 0
let g:context_enabled = 0
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
" highlight link ALEWarning WildMenu
highlight clear ALEWarning
highlight link ALEWarningSign WildMenu
highlight link ALEError SpellBad
highlight link ALEErrorSign ALEError
" set completeopt=menu,menuone,preview,noselect,noinsert " Need this for ALE completion to work right?
"
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

" Deoplete {{{
let g:deoplete#enable_at_startup = 1

" Only run deoplete setup if enabled at start up
" This is required for the docker install
if g:deoplete#enable_at_startup
    call deoplete#custom#option({
                \ 'auto_complete_delay': 100,
                \ 'smart_case': v:true,
                \ })
endif
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

" Define Denite mappings {{{
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
    call deoplete#disable()
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    call deoplete#disable()
endfunction


function! Reset_denite_changes() abort
    set cursorline
    call deoplete#enable()
endfunction

" Borrowed from
" https://github.com/ctaylo21/jarvis/blob/master/config/nvim/init.vim#L58
"
" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
"\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'PmenuSel',
\ 'highlight_filter_background': 'PmenuSbar',
\ 'highlight_prompt': 'Special',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

if g:deoplete#enable_at_startup
    call s:profile(s:denite_options)
    "call denite#custom#var('menu', 'menus', s:menus)

    " Ag command on grep source
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Define alias
    call denite#custom#alias('source', 'file/rec/git', 'file/rec')
    call denite#custom#var('file/rec/git', 'command',
                \ ['git', 'ls-files', '-co', '--exclude-standard'])

    call denite#custom#alias('source', 'file/rec/py', 'file/rec')
    call denite#custom#var('file/rec/py', 'command',
                \ ['scantree.py', '--path', ':directory'])

    " Change ignore_globs
    call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
                \ [ '.git/', '.ropeproject/', '__pycache__/',
                \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Change file/rec command.
" call denite#custom#var('file/rec', 'command',
"             \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Change matchers.
    call denite#custom#source(
                \ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
    call denite#custom#source(
                \ 'file/rec', 'matchers', ['matcher/cpsm'])

    " Change sorters.
    call denite#custom#source(
                \ 'file/rec', 'sorters', ['sorter/sublime'])

    " Change default action.
    call denite#custom#kind('file', 'default_action', 'switch')

endif

nnoremap <silent> <C-p> :<C-u>DeniteProjectDir
        \ `finddir('.git', ';') != ''
        \   ? 'file/rec/git'
        \   : findfile('.git', ';') != ''
        \       ? 'file/rec/git' : 'file/rec'`
        "\ -split=floating
        "\ -highlight-window-background=statuslinenc
        "\ -highlight-filter-background=statusline
        "\ -highlight-matched-char=none
        "\ -auto-resize
        "\ -filter-split-direction=floating
        \ -start-filter<CR>

nnoremap <leader>a :<C-u>Denite
        \ grep:`GetGitDir()`
        "\ -split=floating
        "\ -highlight-window-background=statuslinenc
        "\ -highlight-filter-background=statusline
        "\ -highlight-matched-char=none
        "\ -auto-resize
        "\ -filter-split-direction=floating
        \ -sorters='sorter/path'
        \ <CR>

nnoremap <silent> <leader>8 :<C-u>DeniteCursorWord
        \ grep:`GetGitDir()`
        "\ -split=floating
        "\ -highlight-window-background=statuslinenc
        "\ -highlight-filter-background=statusline
        "\ -highlight-matched-char=none
        "\ -filter-split-direction=floating
        \ -sorters='sorter/path'
        \ <CR>

nnoremap <leader>r :<C-u>Denite -resume -cursor-pos=+1<CR>
nnoremap <leader><C-r> :<C-u>Denite register:.<CR>
" }}}

" LineNoIndicator {{{
"let g:line_no_indicator_chars = ['⎺', '⎻', '⎼', '⎽'] " on Linux

" one char wide solid vertical bar
let g:line_no_indicator_chars = [
  \  '█',
  \  '▇',
  \  '▆',
  \  '▅',
  \  '▄',
  \  '▃',
  \  '▂',
  \  '▁',
  \  ' '
  \  ]
"
"let g:line_no_indicator_chars = [
"  \ '  ', '░ ', '▒ ', '▓ ', '█ ', '█░', '█▒', '█▓', '██'
"  \ ]
" }}}

" {{{ Vista
let g:vista_highlight_whole_line = 1
let g:vista_blank = [0, 0]
let g:vista_top_level_blink = [0, 0]
let g:vista_echo_cursor = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_cursor_delay = 1000
" }}}
