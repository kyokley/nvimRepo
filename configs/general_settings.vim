if !exists('g:syntax_on')
    syntax on
endif

set number
set relativenumber
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hidden
set noautowrite
set smarttab
set showmatch
set scrolloff=5
set visualbell
set autochdir
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*.git
set wildmode=longest:full,full
set wildmenu
set nowrapscan
set textwidth=0
set mouse=""
set autoread
set shiftround
set splitright
set splitbelow

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines
set listchars=trail:_
set list


set cursorline

if !exists('g:loaded_color')
    let g:loaded_color = 1

    set background=dark
    silent! colorscheme CandyPaper
endif

set incsearch
set hlsearch

set timeout
set timeoutlen=400
set ttimeoutlen=100

set undofile
set undolevels=1000
set undoreload=1000
set nobackup

set diffopt+=internal,algorithm:patience

set inccommand=split
set guicursor=

set termguicolors

let $PYTHONUNBUFFERED=1
