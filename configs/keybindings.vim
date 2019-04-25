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
nnoremap <Leader>c :set cursorline!<CR>

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

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
inoremap jj <Esc>
inoremap kk <Esc>
inoremap JJ <Esc>
inoremap KK <Esc>

cnoremap w!! w !sudo tee % > /dev/null
"
" A little macro to remove special aligning
let @u = ':silent! s/\(\S\)\s\{2,\}/\1 /g:silent! s/\S\zs\s\+\ze[:\])]//g'
noremap <leader>u :norm @u<CR>

" A macro to capitalize SQL keywords
let @i = ':silent! s/\<\(desc\|trigger\|after\|for\|each\|row\|returns\|replace\|function\|execute\|procedure\|with\|case\|when\|then\|else\|end\|type\|using\|foreign\|references\|cascade\|if\|check\|coalesce\|boolean\|union\|false\|true\|integer\|text\|serial\|primary\|key\|into\|insert\|drop\|limit\|unique\|index\|default\|column\|add\|table\|create\|alter\|delete\|interval\|set\|begin\|order by\|group by\|commit\|update\|rollback\|as\|select\|distinct\|from\|null\|or\|is\|inner\|right\|outer\|join\|in\|not\|exists\|on\|where\|and\|constraint\)\>\c/\U&/g'

" Back to being a WIP
let @_ = ":silent! s/\\('\\)\\@<![^']\\{-}\\zs\\<\\(trigger\\|after\\|for\\|each\\|row\\|returns\\|replace\\|function\\|execute\\|procedure\\|with\\|case\\|when\\|then\\|else\\|end\\|type\\|using\\|foreign\\|references\\|cascade\\|if\\|check\\|coalesce\\|boolean\\|union\\|false\\|true\\|integer\\|text\\|serial\\|primary\\|key\\|into\\|insert\\|drop\\|limit\\|unique\\|index\\|default\\|column\\|add\\|table\\|create\\|alter\\|delete\\|interval\\|set\\|begin\\|order by\\|group by\\|commit\\|update\\|rollback\\|as\\|select\\|distinct\\|from\\|null\\|or\\|is\\|inner\\|left\\|right\\|outer\\|join\\|in\\|not\\|exists\\|on\\|where\\|and\\|constraint\\)\\>\\ze[^']\\{-}\\('\\)\\@!\\c/\\U&/g"
noremap <leader>s :norm @i<CR><CR>

nnoremap <leader>sp :.,.!sqlparse<CR>
vnoremap <leader>sp :!sqlparse<CR>

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

nnoremap <leader>h :nohlsearch<CR>

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
