syntax on

set number
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
set nowrapscan
set textwidth=0
set mouse=""
set autoread
set background=dark

highlight MatchParen ctermbg=4

set cursorline

colorscheme CandyPaper
highlight CursorLine cterm=NONE ctermbg=18 ctermfg=white guibg=darkblue guifg=white
highlight colorcolumn cterm=NONE ctermbg=black guibg=black
highlight LineNr cterm=NONE ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow
highlight search cterm=NONE ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
highlight signcolumn cterm=NONE ctermbg=black guibg=black
highlight Pmenu cterm=NONE ctermbg=darkgreen ctermfg=white guibg=darkgreen guifg=white
highlight PmenuSel cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
highlight visual cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
highlight statusline cterm=NONE ctermbg=4 ctermfg=white
highlight statuslinenc cterm=NONE ctermbg=black ctermfg=white

highlight TermCursorNC ctermbg=1 ctermfg=15
highlight Normal ctermbg=none
highlight NonText ctermbg=none

highlight SpellBad cterm=NONE ctermbg=darkred ctermfg=yellow guibg=darkred guifg=yellow

set incsearch
set hlsearch

set timeout
set timeoutlen=400
set ttimeoutlen=100

highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow
highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow
