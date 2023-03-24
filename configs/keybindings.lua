
-- Keybindings!!!!!!!!!!!!!!
nmap('<Leader>c', ':set cursorline!<CR>')

nmap('<up>', '<nop>')
nmap('<down>', '<nop>')
nmap('<left>', '<nop>')
nmap('<right>', '<nop>')
imap('<up>', '<nop>')
imap('<down>', '<nop>')
imap('<left>', '<nop>')
imap('<right>', '<nop>')

nmap('<F2>', ':set nonumber!<CR>:set foldcolumn=0<CR>')
nmap('<F3>', ':NERDTreeToggle<CR>')
nmap('<F4>', ':Vista!!<CR>')
nmap('<F5>', ':MundoToggle<CR>')
nmap('<F6>', ':set nolist!<CR>')

imap('jj', '<Esc>')
imap('kk', '<Esc>')
imap('JJ', '<Esc>')
imap('KK', '<Esc>')

nmap('M', ':join<CR>')
xmap('M', ':join<CR>')
nmap('gM', ':join!<CR>')
xmap('gM', ':join!<CR>')

vmap('<C-j>', ":m '>+1<CR>gv=gv")
vmap('<C-k>', ":m '<-2<CR>gv=gv")

imap('<C-r>', '<C-r><C-o>')

cmap('w!!', 'w !sudo tee % > /dev/null')

-- A little macro to remove special aligning
vim.cmd([[
let @u = ':silent! s/\(\S\)\s\{2,\}/\1 /g:silent! s/\S\zs\s\+\ze[:\])]//g'
]])
nmap('<leader>u', ':norm @u<CR>')
xmap('<leader>u', ':norm @u<CR>')

-- A macro to capitalize SQL keywords
vim.cmd([[
let @i = ':silent! s/\<\(desc\|trigger\|after\|for\|each\|row\|returns\|replace\|function\|execute\|procedure\|with\|case\|when\|then\|else\|end\|type\|using\|foreign\|references\|cascade\|if\|check\|coalesce\|boolean\|union\|false\|true\|integer\|text\|serial\|primary\|key\|into\|insert\|drop\|limit\|unique\|index\|default\|column\|add\|table\|create\|alter\|delete\|interval\|set\|begin\|order by\|group by\|commit\|update\|rollback\|as\|select\|distinct\|from\|null\|or\|is\|inner\|right\|outer\|join\|in\|not\|exists\|on\|where\|and\|constraint\|having\)\>\c/\U&/g'
]])
nmap('<leader>s', ':norm @i<CR><CR>')

nmap('<leader>sp', ':%!docker run --rm -i kyokley/sqlparse<CR>')
xmap('<leader>sp', ':!docker run --rm -i kyokley/sqlparse<CR>')

nmap('<leader>j', ':%!python -m json.tool<CR>')
xmap('<leader>j', ':!python -m json.tool<CR>')

-- Add some mappings
nmap(',#', ":call CommentLineToEnd('# ')<CR>+")
xmap(',#', ":call CommentLineToEnd('# ')<CR>+")
nmap(',*', ":call CommentLinePincer('/* ', ' */')<CR>+")
xmap(',*', ":call CommentLinePincer('/* ', ' */')<CR>+")

-- Allow command to accept a count
silent_nmap('<S-j>', "@='20j'<CR>")
silent_xmap('<S-j>', "@='20j'<CR>")
silent_nmap('<S-k>', "@='20k'<CR>")
silent_xmap('<S-k>', "@='20k'<CR>")

nmap('<S-l>', ':bnext<CR>')
nmap('<S-h>', ':bprev<CR>')
xmap('<S-l>', '5l')
xmap('<S-h>', '5h')
nmap('<S-y>', 'y$')
nmap('<S-Left>', ':bprev<CR>')
nmap('<S-Right>', ':bnext<CR>')

nmap('<leader>h', ':nohlsearch<CR>')

tmap('<Esc>', '<C-\\><C-n>')
tmap('<C-h>', '<C-\\><C-n><C-w>h')
tmap('<C-j>', '<C-\\><C-n><C-w>j')
tmap('<C-k>', '<C-\\><C-n><C-w>k')
tmap('<C-l>', '<C-\\><C-n><C-w>l')

nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')
nmap('<C-h>', '<C-w>h')
nmap('<C-Down>', '<C-w>j')
nmap('<C-Up>', '<C-w>k')
nmap('<C-Right>', '<C-w>l')
nmap('<C-Left>', '<C-w>h')

nmap('<leader>gb', ':<C-U>tabnew \\| terminal svn blame <C-R>=expand("%:p") <CR> \\| color_svn_blame \\| less +<C-R>=max([0, line(\'.\') - winline()]) <CR><CR>')
vmap('<leader>sb', ':<C-U>tabnew \\| terminal svn blame <C-R>=expand("%:p") <CR> \\| sed -n <C-R>=line("\'<") <CR>,<C-R>=line("\'>") <CR>p \\| color_svn_blame \\| less <CR>')

nmap('<leader>gb', ':<C-U>tabnew \\| terminal git blame <C-R>=expand("%:p") <CR> \\| color_git_blame \\| less +<C-R>=max([0, line(\'.\') - winline()]) <CR><CR>')
vmap('<leader>gb', ':<C-U>tabnew \\| terminal git blame <C-R>=expand("%:p") <CR> \\| sed -n <C-R>=line("\'<") <CR>,<C-R>=line("\'>") <CR>p \\| color_git_blame \\| less <CR>')
nmap('<leader>gl', ':<C-U>tabnew \\| terminal git blame <C-R>=expand("%:p") <CR> \\| sed -n <C-R>=line(".") <CR>p \\| awk \'{print $1}\' \\| tr -d \'^\' \\| xargs git show <CR>')
nmap('<leader>gm', ':LivedownPreview<CR>')

-- nmap(',v', ':source $MYVIMRC<CR>')
-- nmap(',e', ':e $MYVIMRC<CR>')

nmap('<F12>', ':py3 SetBreakpoint()<cr>')
nmap('<S-F12>', ':py3 RemoveBreakpoints()<cr>')
-- Terminator wasn't responding to S-F12 but F24 seems to work
nmap('<F24>', ':py3 RemoveBreakpoints()<cr>')

-- "in indentation" (indentation level sans any surrounding empty lines)
silent_xmap('ii', ':<c-u>call InIndentation()<cr>')
silent_omap('ii', ':<c-u>call InIndentation()<cr>')

-- "around indentation" (indentation level and any surrounding empty lines)
silent_xmap('ai', ':<c-u>call AroundIndentation()<cr>')
silent_omap('ai', ':<c-u>call AroundIndentation()<cr>')

silent_nmap('<C-t>', ':call FloatTerm()<CR>')
silent_tmap('<C-t>', '<C-\\><C-n>:bd!<CR>')

silent_nmap('<C-p>', ':Telescope git_files theme=dropdown<CR>')
silent_nmap('<leader>8', ':Telescope grep_string theme=dropdown<CR>')
silent_nmap('<leader>a', ':Telescope live_grep theme=dropdown<CR>')
