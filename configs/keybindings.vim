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

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :Vista!!<CR>
nnoremap <F5> :MundoToggle<CR>
nnoremap <F6> :set nolist!<CR>

inoremap jj <Esc>
inoremap kk <Esc>
inoremap JJ <Esc>
inoremap KK <Esc>

nnoremap M :join<CR>
xnoremap M :join<CR>
nnoremap gM :join!<CR>
xnoremap gM :join!<CR>

" Center search results
" nnoremap n nzzzv
" nnoremap N Nzzzv

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

inoremap <C-r> <C-r><C-o>

cnoremap w!! w !sudo tee % > /dev/null
"
" A little macro to remove special aligning
let @u = ':silent! s/\(\S\)\s\{2,\}/\1 /g:silent! s/\S\zs\s\+\ze[:\])]//g'
nnoremap <leader>u :norm @u<CR>
xnoremap <leader>u :norm @u<CR>

" A macro to capitalize SQL keywords
let @i = ':silent! s/\<\(desc\|trigger\|after\|for\|each\|row\|returns\|replace\|function\|execute\|procedure\|with\|case\|when\|then\|else\|end\|type\|using\|foreign\|references\|cascade\|if\|check\|coalesce\|boolean\|union\|false\|true\|integer\|text\|serial\|primary\|key\|into\|insert\|drop\|limit\|unique\|index\|default\|column\|add\|table\|create\|alter\|delete\|interval\|set\|begin\|order by\|group by\|commit\|update\|rollback\|as\|select\|distinct\|from\|null\|or\|is\|inner\|right\|outer\|join\|in\|not\|exists\|on\|where\|and\|constraint\|having\)\>\c/\U&/g'
noremap <leader>s :norm @i<CR><CR>

nnoremap <leader>sp :%!docker run --rm -i kyokley/sqlparse<CR>
xnoremap <leader>sp :!docker run --rm -i kyokley/sqlparse<CR>

nnoremap <leader>j :%!python -m json.tool<CR>
xnoremap <leader>j :!python -m json.tool<CR>

" Add some mappings
nnoremap ,# :call CommentLineToEnd('# ')<CR>+
xnoremap ,# :call CommentLineToEnd('# ')<CR>+
nnoremap ,* :call CommentLinePincer('/* ', ' */')<CR>+
xnoremap ,* :call CommentLinePincer('/* ', ' */')<CR>+

"Allow command to accept a count
noremap <silent> <S-j> @='20j'<CR>
xnoremap <silent> <S-j> @='20j'<CR>
noremap <silent> <S-k> @='20k'<CR>
xnoremap <silent> <S-k> @='20k'<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprev<CR>
xnoremap <S-l> 5l
xnoremap <S-h> 5h
noremap <S-y> y$
nnoremap <S-Left> :bprev<CR>
nnoremap <S-Right> :bnext<CR>

nnoremap <leader>h :nohlsearch<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l
nnoremap <C-Left> <C-w>h

nnoremap <leader>gb :<C-U>tabnew \| terminal svn blame <C-R>=expand("%:p") <CR> \| color_svn_blame \| less +<C-R>=max([0, line('.') - winline()]) <CR><CR>
vnoremap <leader>sb :<C-U>tabnew \| terminal svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p \| color_svn_blame \| less <CR>

nnoremap <leader>gb :<C-U>tabnew \| terminal git blame <C-R>=expand("%:p") <CR> \| color_git_blame \| less +<C-R>=max([0, line('.') - winline()]) <CR><CR>
vnoremap <leader>gb :<C-U>tabnew \| terminal git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p \| color_git_blame \| less <CR>
nnoremap <leader>gl :<C-U>tabnew \| terminal git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line(".") <CR>p \| awk '{print $1}' \| tr -d '^' \| xargs git show <CR>
nnoremap <leader>gm :LivedownPreview<CR>

nnoremap ,v :source $MYVIMRC<CR>
nnoremap ,e :e $MYVIMRC<CR>

noremap <F12> :py3 SetBreakpoint()<cr>
noremap <S-F12> :py3 RemoveBreakpoints()<cr>
" Terminator wasn't responding to S-F12 but F24 seems to work
noremap <F24> :py3 RemoveBreakpoints()<cr>

" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call InIndentation()<cr>
onoremap <silent> ii :<c-u>call InIndentation()<cr>

" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call AroundIndentation()<cr>
onoremap <silent> ai :<c-u>call AroundIndentation()<cr>

nnoremap  <silent> <C-t>           :call FloatTerm()<CR>
tnoremap <silent> <C-t>           <C-\><C-n>:bd!<CR>
