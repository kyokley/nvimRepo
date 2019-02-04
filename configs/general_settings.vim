syntax on

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
hi Normal ctermbg=none
hi NonText ctermbg=none

hi SpellBad cterm=NONE ctermbg=darkred ctermfg=yellow guibg=darkred guifg=yellow

set incsearch
set hlsearch

set timeout
set timeoutlen=400
set ttimeoutlen=100

highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red
highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow
highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow
