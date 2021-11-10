" ApplyHighlight {{{
augroup ApplyHighlight
    autocmd!
    autocmd ColorScheme * call ApplyHighlight()
augroup END
" }}}

" TerminalSetup {{{
augroup TerminalSetup
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
    autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
augroup END
" }}}

" GeneralSetup {{{
augroup GeneralSetup
    autocmd!

    autocmd InsertEnter * if &buftype != 'nofile' | highlight LineNr ctermbg=darkred   guibg=darkred | endif
    autocmd InsertEnter * if &buftype != 'nofile' | highlight CursorLine ctermbg=darkred guibg=darkred | else | highlight CursorLine ctermbg=NONE guibg=NONE | endif
    autocmd InsertEnter * if &buftype != 'nofile' | highlight statusline ctermbg=darkred   guibg=#690000 | endif

    autocmd InsertLeave * if &buftype != 'nofile' | highlight LineNr ctermbg=NONE guibg=NONE | endif
    autocmd InsertLeave * highlight CursorLine ctermbg=18 guibg=darkblue
    autocmd InsertLeave * if &buftype != 'nofile' | highlight statusline ctermbg=darkblue   guibg=#203780 | endif

    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    autocmd VimEnter * set title

    " Highlight all tabs and trailing whitespace characters.
    autocmd VimEnter * if &filetype != 'gitcommit' | highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow | endif
    autocmd VimEnter * if &filetype != 'gitcommit' | match ExtraWhitespace /\s\+$\|\t/ | endif
    autocmd BufEnter * let &titlestring = "nvim " . expand("%:p")

    "recalculate the trailing whitespace warning when idle, and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_conflict_warning
    autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

    autocmd FocusGained,VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd FocusLost,WinLeave * setlocal nocursorline
    autocmd FocusGained * checktime

    autocmd TermClose <buffer> if &buftype == 'terminal' | bdelete! | endif

    autocmd BufWritePre * call RaiseExceptionForUnresolvedErrors()

    autocmd FileType vista,vista_kind nnoremap <buffer> <silent> / :<c-u>call vista#finder#fzf#Run()<CR>
augroup END
" }}}

" filetype_python {{{
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal foldlevel=99
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END
" }}}

" filetype_htmldjango {{{
augroup filetype_htmldjango
    autocmd!
    autocmd FileType htmldjango setlocal foldmethod=indent
    autocmd FileType htmldjango setlocal foldlevel=99
augroup END
" }}}

" filetype_html {{{
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal noexpandtab
augroup END
" }}}

" filetype_cs {{{
augroup filetype_cs
    autocmd!
    autocmd FileType cs setlocal omnifunc=syntaxcomplete#Complete
    autocmd FileType cs setlocal foldmethod=marker
    autocmd FileType cs setlocal foldmarker={,}
    autocmd FileType cs setlocal foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
    autocmd FileType cs setlocal foldlevelstart=2
    autocmd FileType cs setlocal smartindent
augroup END
" }}}

" filetype_text {{{
augroup filetype_text
    autocmd!
    autocmd FileType text setlocal spell spelllang=en_us
    autocmd FileType text setlocal noexpandtab
augroup END
" }}}

" filetype_md {{{
augroup filetype_md
    autocmd!
    autocmd FileType markdown setlocal spell spelllang=en_us
augroup END
" }}}

" filetype_help {{{
augroup filetype_help
    autocmd!
    autocmd FileType help setlocal nospell
augroup END
" }}}

" filetype_term {{{
augroup filetype_term
    autocmd!
    autocmd TermOpen * setlocal nonumber
augroup END
" }}}

" TODO: Consolidate settings for filetypes in the edit augroup
" filetype_git {{{
augroup filetype_git
    autocmd!
    autocmd FileType git,gitcommit setlocal nospell
    autocmd FileType git,gitcommit setlocal nolist

    " When amending git commits :q can accidentally succeed if a message
    " already exists. Instead, replace :q with :cq to force vim to exit with
    " an error code.
    autocmd FileType gitcommit cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline()[0] == 'q' ? 'cq' : 'q'
augroup END
" }}}

" filetype_make {{{
augroup filetype_make
    autocmd!
    autocmd FileType make setlocal noexpandtab
augroup END
" }}}

" filetype_vim {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" filetype_yaml {{{
augroup filetype_yaml
    autocmd!
    autocmd FileType yaml setlocal shiftwidth=2
augroup END
" }}}

" filetype_fzf {{{
augroup filetype_fzf
    autocmd!
    autocmd FileType fzf tnoremap <buffer> <silent> <C-j> <down>
    autocmd FileType fzf tnoremap <buffer> <silent> <C-k> <up>
    autocmd FileType fzf tnoremap <buffer> <silent> <C-h> <nop>
    autocmd FileType fzf tnoremap <buffer> <silent> <C-l> <nop>
    autocmd FileType fzf tnoremap <buffer> <silent> <Esc> <C-c>
    " autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" }}}
