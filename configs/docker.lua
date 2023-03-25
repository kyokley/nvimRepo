-- Docker specific overrides can be applied here

nmap('<leader>sb', ':<C-U>tabnew \\| terminal svn blame <C-R>=expand("%:p") <CR> \\| /color_blame_venv/bin/python /color_blame_venv/bin/color_svn_blame \\| less -R +<C-R>=max([0, line(\'.\') - winline()]) <CR><CR>')
vmap('<leader>sb', ':<C-U>tabnew \\| terminal svn blame <C-R>=expand("%:p") <CR> \\| sed -n <C-R>=line("\'<") <CR>,<C-R>=line("\'>") <CR>p \\| /color_blame_venv/bin/python /color_blame_venv/bin/color_svn_blame \\| less -R <CR>')

nmap('<leader>gb', ':<C-U>tabnew \\| terminal git blame <C-R>=expand("%:p") <CR> \\| /color_blame_venv/bin/python /color_blame_venv/bin/color_git_blame \\| less -R +<C-R>=max([0, line(\'.\') - winline()]) <CR><CR>')
vmap('<leader>gb', ':<C-U>tabnew \\| terminal git blame <C-R>=expand("%:p") <CR> \\| sed -n <C-R>=line("\'<") <CR>,<C-R>=line("\'>") <CR>p \\| /color_blame_venv/bin/python /color_blame_venv/bin/color_git_blame \\| less -R <CR><CR>')
