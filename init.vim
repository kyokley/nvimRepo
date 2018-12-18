" F2 toggles line numbers
" F3 toggles file browser
" F4 toggles object browser
" F5 toggles undo tree
" F10 toggles paste mode
" <leader>h clears highlighting and signify symbols
"
" jj <Esc>
" JJ <Esc>
" kk <Esc>
" KK <Esc>
"
" Shift-L :bnext
" Shift-H :bprev
" Shift-J 20 lines down
" Shift-K 20 lines up
"
" Ctrl-j Move down a window
" Ctrl-k Move up a window
" Ctrl-h Move left a window
" Ctrl-l Move right a window
"
" <Tab> Jump to next word
" Shift-<Tab> Jump back a word
"
let $MYVIMRC = $HOME."/.nvim/init.vim"

filetype off
call plug#begin('~/.nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tommcdo/vim-exchange'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'nvie/vim-flake8'
Plug 'Bogdanp/quicksilver.vim'
Plug 'mhinz/vim-signify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-bufferline'
Plug 'kyokley/JavaScript-Indent'
Plug 'jelera/vim-javascript-syntax'
Plug 'hdima/python-syntax'
Plug 'ervandew/supertab'
Plug 'chrisbra/csv.vim'
Plug 'tomlion/vim-solidity'
Plug 'luochen1990/rainbow'
Plug 'kyokley/vim-colorschemes'
Plug 'whiteinge/diffconflicts'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vader.vim'
Plug 'w0rp/ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fisadev/vim-isort'

Plug '~/.nvim/manual/togglecomment'
Plug '~/.nvim/manual/pyfold'
Plug '~/.nvim/manual/visincr'
Plug '~/.nvim/manual/django-custom'
call plug#end()
filetype plugin indent on

syntax on

" General settings
set number
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set hidden
set noautowrite
set nosmartindent
set smarttab
set showmatch
set scrolloff=5
set visualbell
set autochdir
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*.git
set nowrapscan
set textwidth=0
set mouse=""
set autoread
set background=dark

highlight MatchParen ctermbg=4

set cul

colo CandyPaper
hi CursorLine cterm=NONE ctermbg=18 ctermfg=white guibg=darkblue guifg=white
hi colorcolumn cterm=NONE ctermbg=black guibg=black
hi LineNr cterm=NONE ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow
hi search cterm=NONE ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
hi signcolumn cterm=NONE ctermbg=black guibg=black
hi Pmenu cterm=NONE ctermbg=darkgreen ctermfg=white guibg=darkgreen guifg=white
hi PmenuSel cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
hi visual cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
hi statusline cterm=NONE ctermbg=4 ctermfg=white
hi statuslinenc cterm=NONE ctermbg=black ctermfg=white

hi TermCursorNC ctermbg=1 ctermfg=15

nnoremap <Leader>c :set cursorline!<CR>

hi SpellBad cterm=NONE ctermbg=darkred ctermfg=yellow guibg=darkred guifg=yellow

set incsearch
set hlsearch

set timeout
set timeoutlen=400
set ttimeoutlen=100

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>
nnoremap <F5> :MundoToggle<CR>
nnoremap <F6> :set nolist!<CR>
nnoremap <silent> <leader>h :noh<CR>:silent! call flake8#Flake8UnplaceMarkers()<CR>:sign unplace *<CR>
nnoremap <silent> <leader>g :redir @g<CR>:g//<CR>:redir END<CR>:new<CR>:put! g<CR>

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
inoremap jj <Esc>
inoremap kk <Esc>
inoremap JJ <Esc>
inoremap KK <Esc>

cnoremap w!! w !sudo tee % > /dev/null

" A little macro to remove special aligning
let @u = ':silent! s/\(\S\)\s\{2,\}/\1 /g:silent! s/\S\zs\s\+\ze[:\])]//g'
noremap <leader>u :norm @u<CR>

" A macro to capitalize SQL keywords
let @i = ':silent! s/\<\(desc\|trigger\|after\|for\|each\|row\|returns\|replace\|function\|execute\|procedure\|with\|case\|when\|then\|else\|end\|type\|using\|foreign\|references\|cascade\|if\|check\|coalesce\|boolean\|union\|false\|true\|integer\|text\|serial\|primary\|key\|into\|insert\|drop\|limit\|unique\|index\|default\|column\|add\|table\|create\|alter\|delete\|interval\|set\|begin\|order by\|group by\|commit\|update\|rollback\|as\|select\|distinct\|from\|null\|or\|is\|inner\|right\|outer\|join\|in\|not\|exists\|on\|where\|and\|constraint\)\>\c/\U&/g'

" Back to being a WIP
let @_ = ":silent! s/\\('\\)\\@<![^']\\{-}\\zs\\<\\(trigger\\|after\\|for\\|each\\|row\\|returns\\|replace\\|function\\|execute\\|procedure\\|with\\|case\\|when\\|then\\|else\\|end\\|type\\|using\\|foreign\\|references\\|cascade\\|if\\|check\\|coalesce\\|boolean\\|union\\|false\\|true\\|integer\\|text\\|serial\\|primary\\|key\\|into\\|insert\\|drop\\|limit\\|unique\\|index\\|default\\|column\\|add\\|table\\|create\\|alter\\|delete\\|interval\\|set\\|begin\\|order by\\|group by\\|commit\\|update\\|rollback\\|as\\|select\\|distinct\\|from\\|null\\|or\\|is\\|inner\\|left\\|right\\|outer\\|join\\|in\\|not\\|exists\\|on\\|where\\|and\\|constraint\\)\\>\\ze[^']\\{-}\\('\\)\\@!\\c/\\U&/g"
noremap <leader>s :norm @i<CR><CR>

" Add some mappings
noremap ,# :call CommentLineToEnd('# ')<CR>+
noremap ,* :call CommentLinePincer('/* ', ' */')<CR>+

"Allow command to accept a count
noremap <silent> <S-j> @='20j'<CR>
noremap <silent> <S-k> @='20k'<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprev<CR>
vnoremap <S-l> 5l
vnoremap <S-h> 5h
noremap <S-y> y$
noremap <S-Up> :tabp<CR>
noremap <S-Down> :tabn<CR>
noremap <S-Left> :bprev<CR>
noremap <S-Right> :bnext<CR>

" Handle terminal windows
autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l
noremap <C-Left> <C-w>h
nnoremap <Tab> w
vnoremap <Tab> w
nnoremap <S-Tab> b
vnoremap <S-Tab> b
nnoremap <leader>a <Esc>:LAck!
nnoremap <C>a <Esc>:LAck!
noremap <leader>fc /\v^[<=>]{7}( .*\|$)<CR>

nnoremap <leader>sb :<C-U>tabnew \| te svn blame <C-R>=expand("%:p") <CR> \| color_svn_blame \| less +<C-R>=line("w0") <CR><CR>
vnoremap <leader>sb :<C-U>tabnew \| te svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p \| color_svn_blame \| less <CR><CR>

nnoremap <leader>sl :<C-U>tabnew \| te svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line(".") <CR>p \| awk '{print $1}' \| xargs svn log $T -r<CR><CR>
" nnoremap <leader>gb :<C-U>tabnew \| te git blame <C-R>=expand("%:p") <CR> \| color_git_blame \| less +<C-R>=line("w0") <CR><CR>
" Take folds into account when determining *less* offset
nnoremap <leader>gb :<C-U>tabnew \| te git blame <C-R>=expand("%:p") <CR> \| color_git_blame \| less +<C-R>=max([0, line('.') - winline()]) <CR><CR>
vnoremap <leader>gb :<C-U>tabnew \| te git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p \| color_git_blame \| less <CR><CR>
nnoremap <leader>gl :<C-U>tabnew \| te git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line(".") <CR>p \| awk '{print $1}' \| tr -d '^' \| xargs git show <CR><CR>

nnoremap ,v :source $MYVIMRC<CR>
nnoremap ,e :e $MYVIMRC<CR>

" Signify Settings
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow
highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow

"QuickSilver Config
let g:QSMatchFn = 'fuzzy'
let g:QSIgnore = ".*\.pyc$;.*\.swp$"

" ctrlp
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_map = '<c-p>'
nnoremap <leader>t :let g:ctrlp_working_path_mode = 'c'<CR>:CtrlP<CR>:let g:ctrlp_working_path_mode = 'r'<CR>
nnoremap <leader>p :let g:ctrlp_working_path_mode = 'r'<CR>:CtrlP<CR>
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
" If ag is available use it as filename list generator instead of 'find'
let g:ackprg = 'ag --nogroup --nocolor --column'
set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --ignore ''**/*.pyc'' --hidden -g ""'

"let g:ctrlp_user_command = {
"    \ 'types': {
"      \ 1: ['.git', 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'],
"      \ 2: ['.svn', 'ag %s -i --nocolor --nogroup --ignore ''.svn'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'],
"      \ },
"    \ 'fallback': 'find %s -type f'
"    \ }

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:100'

"NERDTree
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.pyc$', '\.swp$']

"Tagbar
let g:tagbar_autofocus = 1

" Python configs
let g:python2_dir = $HOME . '/.pyenv/versions/neovim2/bin/'
let g:python3_dir = $HOME . '/.pyenv/versions/neovim3/bin/'

let g:python_host_prog = g:python2_dir . 'python'
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
let g:ale_set_quickfix = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_executable = g:python3_dir . 'flake8'
let g:ale_python_isort_use_global = 1
let g:ale_python_isort_executable = g:python3_dir . 'isort'
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 100
let g:ale_enabled = 1
let g:ale_set_signs = 1
let g:ale_set_highlights = 1
let g:ale_sign_warning = '->'
let g:ale_linters = {
            \ 'python': ['pyflakes', 'flake8'],
            \}
" highlight link ALEWarning WildMenu
highlight clear ALEWarning
highlight link ALEWarningSign WildMenu
highlight link ALEError SpellBad
highlight link ALEErrorSign ALEError
" set completeopt=menu,menuone,preview,noselect,noinsert " Need this for ALE completion to work right?

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#documentation_command=''

" Deoplete
let g:deoplete#enable_at_startup = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '[OK]' : printf(
    \   '[%dW %dE]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Python PEP-8 Indent
let g:python_pep8_indent_hang_closing = 0


"statusline setup
set statusline=
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%{GetPyVersion()!='[Err]'?GetPyVersion():''}
set statusline+=%#warningmsg#
set statusline+=%{GetPyVersion()=='[Err]'?'[py2/3\ Err]':''}
set statusline+=%*

set statusline+=%{fugitive#statusline()}

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator

set statusline+=%#warningmsg#
set statusline+=%{LinterStatus()!='[OK]'?LinterStatus():''}
set statusline+=%*
set statusline+=%{LinterStatus()=='[OK]'?'[OK]':''}
set statusline+=%{StatuslineConflictWarning()}
set statusline+=%*
"
"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#warningmsg#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}\ " Space at the end of the line left intentionally
set statusline+=%{StatuslineLongLineWarning()}\ " Space at the end of the line left intentionally

set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2


" AutoCommands!
augroup EditVim
    autocmd!
    au InsertEnter * if &buftype != 'nofile' | hi LineNr ctermbg=darkred   guibg=darkred | endif
    au InsertEnter * if &buftype != 'nofile' | hi CursorLine ctermbg=darkred guibg=darkred | else | hi CursorLine ctermbg=NONE guibg=NONE | endif
    au InsertLeave * if &buftype != 'nofile' | hi LineNr ctermbg=NONE guibg=NONE | endif
    au InsertLeave * hi CursorLine ctermbg=18 guibg=darkblue

    au FileType svn,*commit* setlocal spell
    au FileType git,*commit* setlocal spell
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    au VimEnter * set title
    au BufEnter * let &titlestring = "nvim " . expand("%:p")
    "recalculate the trailing whitespace warning when idle, and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_conflict_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
augroup END

augroup filetype_python
    autocmd!
    au FileType python set foldmethod=indent
    au FileType python set foldlevel=99
    au FileType python set omnifunc=pythoncomplete#Complete
    "au FileType python BracelessEnable +indent +highlight-cc2
    au FileType python map <buffer> <leader>8 :call Flake8()<CR>
    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    au FileType python set listchars=trail:_
    au FileType python set list

    " Also highlight all tabs and trailing whitespace characters.
    au FileType python highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow
    au FileType python match ExtraWhitespace /\s\+$\|\t/
    let python_highlight_all = 1
    "au FileType python colo molokai
    autocmd BufNewFile,bufreadpost *.py call g:SetPyVersion()
    autocmd BufEnter,bufwritepre *.py call s:SetPyflakeVersion()
augroup END

augroup filetype_htmldjango
    autocmd!
    au FileType htmldjango set foldmethod=indent
    au FileType htmldjango set foldlevel=99
augroup END

augroup filetype_cs
    autocmd!
    au FileType cs set omnifunc=syntaxcomplete#Complete
    au FileType cs set foldmethod=marker
    au FileType cs set foldmarker={,}
    au FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
    au FileType cs set foldlevelstart=2
    au FileType cs set smartindent
augroup END

augroup filetype_text
    autocmd!
    au FileType text setlocal spell spelllang=en_us
    au FileType text setlocal noexpandtab
augroup END

augroup filetype_md
    autocmd!
    au FileType markdown setlocal spell spelllang=en_us
    au FileType markdown setlocal noexpandtab
augroup END

augroup filetype_help
    autocmd!
    au FileType help setlocal nospell
augroup END

augroup filetype_term
    autocmd!
    au TermOpen * setlocal nonumber
augroup END

" TODO: Consolidate settings for filetypes in the edit augroup
augroup filetype_git
    autocmd!
    au FileType git setlocal nospell
augroup END

augroup filetype_make
    autocmd!
    au FileType make setlocal noexpandtab
augroup END

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

function! s:FindError(file_name, bad_str, error_msg, ...)
    " Sometimes need to remove a temporary buffer
    let l:remove_temp_buffer = get(a:000, 0, 0)

    let l:line = search(a:bad_str, 'nw')
    if l:line != 0
        if match(getline(l:line), '\c' . a:file_name) == -1
            let l:message = a:error_msg . ' ' . a:file_name . ':' . l:line
        else
            let l:message = a:error_msg . ' ' . getline(l:line)
        endif

        if l:remove_temp_buffer
            bd!
        endif

        throw l:message
    endif
endfunction

function! RaiseExceptionForUnresolvedErrors()
    let s:file_name = expand('%:t')

    " Check for unresolved VCS conflicts
    call s:FindError(s:file_name, '\v^[<=>]{7}( .*|$)', 'Found unresolved conflicts in')

    " Check for trailing whitespace
    call s:FindError(s:file_name, '\s\+$', 'Found trailing whitespace in')

    if &filetype == 'python'

        let py_version = GetPyVersion()

        silent %yank p
        new
        silent 0put p
        silent $,$d

        try
            if py_version == '[py3]'
                let pyflakes_cmd = '%!' . g:python3_dir . 'pyflakes'
                let bandit_cmd = '%!' . g:python3_dir . 'bandit -ll -s B322,B101 -'
            elseif py_version == '[py2]'
                let pyflakes_cmd = '%!' . g:python2_dir . 'pyflakes'
                let bandit_cmd = '%!' . g:python2_dir . 'bandit -ll -s B101 -'
            else
                bd!
                throw 'Could not determine python version!'
            endif

            silent exe pyflakes_cmd
            silent exe '%s/<stdin>/' . s:file_name . '/e'

            call s:FindError(s:file_name, '\(unable to detect \)\@<!undefined name', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'unexpected indent', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'expected an indented block', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'invalid syntax', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'unindent does not match any outer indentation level', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'EOL while scanning string literal', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'redefinition of unused', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'list comprehension redefines', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'shadowed by loop variable', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'syntax error', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'referenced before assignment', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'duplicate argument', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'repeated with different values', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'imports must occur at the beginning of the file', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'outside function', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'not properly in loop', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'outside loop', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'two starred expressions in assignment', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'too many expressions in star-unpacking assignment', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'assertion is always true', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'trailing comma not allowed without surrounding parentheses', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'keyword argument repeated', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'problem decoding source', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'unexpected EOF', 'Syntax error!', 1)
        catch
            throw v:exception
        endtry

        bd!

        silent %yank p
        new
        silent 0put p
        silent $,$d
        silent exe bandit_cmd
        silent exe '%s/<stdin>/' . s:file_name . '/e'

        let s:is_res = search('^>> Issue:', 'nw')
        if s:is_res != 0
            let s:res_end = s:is_res + 2
            for item in getline(s:is_res, s:res_end)
                echohl ErrorMsg | echo item | echohl None
            endfor

            bd!
            throw 'Bandit Error'
        endif

        bd!
    endif
endfunction
autocmd BufWritePre * call RaiseExceptionForUnresolvedErrors()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! StatuslineConflictWarning()
    if !exists("b:statusline_conflict_warning")

        if !&modifiable
            let b:statusline_conflict_warning = ''
            return b:statusline_conflict_warning
        endif

        if search('\v^[<=>]{7}( .*|$)', 'nw') != 0
            let b:statusline_conflict_warning = '[con!]'
        else
            let b:statusline_conflict_warning = ''
        endif
    endif
    return b:statusline_conflict_warning
endfunction

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

function! DetectPyVersion()
    silent %yank p
    new
    silent 0put p

    silent! exe '%!' . g:python3_host_prog . ' -c "import ast; import sys; ast.parse(sys.stdin.read())"'
    bd!
    if v:shell_error == 0
        return 'py3'
    endif

    silent %yank p
    new
    silent 0put p

    silent! exe '%!' . g:python_host_prog . ' -c "import ast; import sys; ast.parse(sys.stdin.read())"'
    bd!
    if v:shell_error == 0
        return 'py2'
    endif

    return 'Err'
endfunction

function! g:SetPyVersion(...)
    let b:py_version = ''

    if &filetype == 'python'
        let in_version = get(a:000, 0, '')

        if in_version != 'py2' && in_version != 'py3'
            let in_version = DetectPyVersion()
        endif

        let b:py_version = '[' . in_version . ']'

        call s:SetPyflakeVersion()
    endif

    return b:py_version
endfunction
com! SetPyVersion call SetPyVersion()
com! SetPyVersion2 call SetPyVersion('py2')
com! SetPyVersion3 call SetPyVersion('py3')

function! GetPyVersion()
    if exists("b:py_version")
        return b:py_version
    else
        return ''
    endif
endfunction

function! s:SetPyflakeVersion()
    if &filetype == 'python'
        if exists("b:py_version") && b:py_version == '[py2]'
            let g:syntastic_python_pyflakes_exec = g:python2_dir . 'pyflakes'
            let g:syntastic_python_bandit_exec = g:python2_dir . 'bandit'
            let g:ale_python_flake8_executable = g:python2_dir . 'flake8'
            let g:ale_python_isort_executable = g:python2_dir . 'isort'
        else
            let g:syntastic_python_pyflakes_exec = g:python3_dir . 'pyflakes'
            let g:syntastic_python_bandit_exec = g:python3_dir . 'bandit -s B322'
            let g:ale_python_flake8_executable = g:python3_dir . 'flake8'
            let g:ale_python_isort_executable = g:python3_dir . 'isort'
        endif
    endif
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int(vim.eval('line(".")'))

    strLine = vim.current.line
    strWhite = re.search('^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)simport pdb; pdb.set_trace()  # %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'noremap <F12> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    nCurrentLine = int(vim.eval('line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:27] == "import pdb; pdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command("normal %dG" % nLine)
        vim.command("normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command("normal %dG" % nCurrentLine)

vim.command("noremap <F24> :py RemoveBreakpoints()<cr>")
EOF
"vim:syntax=vim

set nobackup

if version >= 703
    set undofile
    set undolevels=1000
    set undoreload=1000
    if !has('nvim')
        set cm=blowfish
    endif
endif

function! InitializeDirectories()
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory',
              \ 'undodir': 'undodir' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "//"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          if version < 703
              if settingname == 'undodir'
                  continue
              endif
          endif
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()
