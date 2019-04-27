" Handle terminal windows
augroup ApplyHighlight
    autocmd!
    autocmd ColorScheme * call ApplyHighlight()
augroup END

augroup TerminalSetup
    autocmd!
    autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
augroup END

augroup GeneralSetup
    autocmd!
    autocmd InsertEnter * if &buftype != 'nofile' | highlight LineNr ctermbg=darkred   guibg=darkred | endif
    autocmd InsertEnter * if &buftype != 'nofile' | highlight CursorLine ctermbg=darkred guibg=darkred | else | highlight CursorLine ctermbg=NONE guibg=NONE | endif
    autocmd InsertLeave * if &buftype != 'nofile' | highlight LineNr ctermbg=NONE guibg=NONE | endif
    autocmd InsertLeave * highlight CursorLine ctermbg=18 guibg=darkblue

    autocmd FileType svn,*commit* setlocal spell
    autocmd FileType git,*commit* setlocal spell
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    autocmd VimEnter * set title
    autocmd BufEnter * let &titlestring = "nvim " . expand("%:p")

    "recalculate the trailing whitespace warning when idle, and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_conflict_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

augroup filetype_python
    autocmd!
    autocmd FileType python set foldmethod=indent
    autocmd FileType python set foldlevel=99
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    "autocmd FileType python BracelessEnable +indent +highlight-cc2
    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    autocmd FileType python set listchars=trail:_
    autocmd FileType python set list

    " Also highlight all tabs and trailing whitespace characters.
    autocmd FileType python highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow
    autocmd FileType python match ExtraWhitespace /\s\+$\|\t/

    autocmd BufNewFile,bufreadpost python call g:SetPyVersion('py3')
    autocmd BufEnter,bufwritepre python call functions#SetPyflakeVersion()
augroup END

augroup filetype_htmldjango
    autocmd!
    autocmd FileType htmldjango set foldmethod=indent
    autocmd FileType htmldjango set foldlevel=99
augroup END

augroup filetype_cs
    autocmd!
    autocmd FileType cs set omnifunc=syntaxcomplete#Complete
    autocmd FileType cs set foldmethod=marker
    autocmd FileType cs set foldmarker={,}
    autocmd FileType cs set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
    autocmd FileType cs set foldlevelstart=2
    autocmd FileType cs set smartindent
augroup END

augroup filetype_text
    autocmd!
    autocmd FileType text setlocal spell spelllang=en_us
    autocmd FileType text setlocal noexpandtab
augroup END

augroup filetype_md
    autocmd!
    autocmd FileType markdown setlocal spell spelllang=en_us
    autocmd FileType markdown setlocal noexpandtab
augroup END

augroup filetype_help
    autocmd!
    autocmd FileType help setlocal nospell
augroup END

augroup filetype_term
    autocmd!
    autocmd TermOpen * setlocal nonumber
augroup END

" TODO: Consolidate settings for filetypes in the edit augroup
augroup filetype_git
    autocmd!
    autocmd FileType git setlocal nospell
augroup END

augroup filetype_make
    autocmd!
    autocmd FileType make setlocal noexpandtab
augroup END
