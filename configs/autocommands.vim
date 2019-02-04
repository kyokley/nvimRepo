" Handle terminal windows
autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

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
    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    au FileType python set listchars=trail:_
    au FileType python set list

    " Also highlight all tabs and trailing whitespace characters.
    au FileType python highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow
    au FileType python match ExtraWhitespace /\s\+$\|\t/
    "au FileType python colo molokai
    autocmd BufNewFile,bufreadpost *.py call g:SetPyVersion('py3')
    autocmd BufEnter,bufwritepre *.py call functions#SetPyflakeVersion()
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
