vim.cmd([[
" Highlights {{{
function! ApplyHighlight() abort
    highlight MatchParen ctermbg=4

    highlight Normal ctermbg=none guibg=NONE
    highlight NonText ctermbg=none guibg=NONE

    highlight CursorLine cterm=NONE ctermbg=18 ctermfg=white guibg=darkblue guifg=white
    highlight ColorColumn cterm=NONE ctermbg=black guibg=black
    highlight TabLineFill cterm=NONE ctermbg=NONE guibg=NONE
    highlight TabLine cterm=NONE ctermbg=NONE guibg=NONE

    "highlight LineNr cterm=NONE ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow
    highlight search cterm=NONE ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
    highlight signcolumn cterm=NONE ctermbg=black guibg=NONE
    " highlight Pmenu cterm=NONE ctermbg=NONE ctermfg=white guibg=black guifg=white
    " highlight PmenuSel cterm=NONE ctermbg=NONE ctermfg=black guibg=black guifg=white
    highlight visual cterm=NONE ctermbg=white ctermfg=black guibg=white guifg=black
    "highlight statusline cterm=NONE ctermbg=4 ctermfg=white guibg=darkblue guifg=white
    highlight statusline cterm=NONE ctermbg=4 ctermfg=white guibg=#203780 guifg=white
    " highlight statuslinenc cterm=NONE ctermbg=black ctermfg=white guibg=NONE

    "highlight TermCursorNC ctermbg=1 ctermfg=15

    highlight SpellBad cterm=NONE ctermbg=darkred ctermfg=yellow guibg=darkred guifg=yellow

    highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green guibg=none guifg=Green
    highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red guibg=none guifg=Red
    highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow guibg=none guifg=Yellow
    highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow guibg=Red guifg=Yellow

    highlight default link VistaFloat statusline

    " ALE Highlighting settings
    highlight clear ALEWarning
    highlight clear ALEErrorLine
    highlight link ALEWarningSign WildMenu
    highlight link ALEError SpellBad
    highlight link ALEErrorSign ALEError

    " Diagnostic signs
    sign define DiagnosticSignError text=>> texthl=SpellBad linehl=SpellBad numhl=
    sign define DiagnosticSignWarn text=>> texthl=WildMenu linehl=WildMenu numhl=
    " sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl=
    " sign define DiagnosticSignHint text=H texthl=DiagnosticSignHint linehl= numhl=

    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
endfunction
" }}}

" Error Functions {{{
function! s:FindError(file_name, bad_str, error_msg, ...) abort
    " Sometimes need to remove a temporary buffer
    let l:remove_temp_buffer = get(a:000, 0, 0)

    let l:line = search('\c' . a:bad_str, 'nw')
    if l:line != 0
        if match(getline(l:line), '\c' . a:file_name) == -1
            let l:message = a:error_msg . ' ' . a:file_name . ':' . l:line
        else
            let l:message = a:error_msg . ' ' . getline(l:line)
        endif

        if l:remove_temp_buffer
            bdelete!
        endif

        throw l:message
    endif
endfunction

function! RaiseExceptionForUnresolvedErrors() abort
    let s:file_name = expand('%:t')

    " Check for unresolved VCS conflicts
    call s:FindError(s:file_name, '\v^[<=>]{7}( .*|$)', 'Found unresolved conflicts in')

    " Check for trailing whitespace
    call s:FindError(s:file_name, '\s\+$', 'Found trailing whitespace in')

    if &filetype == 'python'

        let current_lazyredraw = &lazyredraw

        set lazyredraw
        silent %yank p
        new
        setlocal nobuflisted buftype=nofile bufhidden=delete noswapfile
        silent 0put p

        " Open all folds before messing with the buffer
        silent normal zR
        silent $,$delete

        try
            let pyflakes_cmd = '%!' . g:python3_dir . 'ruff --stdin-filename ' . s:file_name . ' -'
            let bandit_cmd = '%!' . g:python3_dir . 'bandit -ll -s B322,B101 -'

            silent execute pyflakes_cmd

            let error_strs = ['\(unable to detect \)\@<!undefined name',
                        \ 'unexpected indent',
                        \ 'expected an indented block',
                        \ 'invalid syntax',
                        \ 'unindent does not match any outer indentation level',
                        \ 'EOL while scanning string literal',
                        \ 'redefinition of unused',
                        \ 'list comprehension redefines',
                        \ 'shadowed by loop variable',
                        \ 'syntax error',
                        \ 'referenced before assignment',
                        \ 'duplicate argument',
                        \ 'repeated with different values',
                        \ 'imports must occur at the beginning of the file',
                        \ 'outside function',
                        \ 'not properly in loop',
                        \ 'outside loop',
                        \ 'two starred expressions in assignment',
                        \ 'too many expressions in star-unpacking assignment',
                        \ 'assertion is always true',
                        \ 'trailing comma not allowed without surrounding parentheses',
                        \ 'keyword argument repeated',
                        \ 'problem decoding source',
                        \ 'EOF in multi-line statement',
                        \ 'unexpected EOF']

            for error_str in error_strs
                call s:FindError(s:file_name, error_str, 'Syntax error!', 1)
            endfor

        catch
            let &lazyredraw = current_lazyredraw
            throw v:exception
        endtry

        bdelete!

        silent %yank p
        new
        silent 0put p
        silent $,$delete
        silent execute bandit_cmd
        silent execute '%s/<stdin>/' . s:file_name . '/e'

        let s:is_res = search('^>> Issue:', 'nw')
        if s:is_res != 0
            let s:res_end = s:is_res + 2
            for item in getline(s:is_res, s:res_end)
                echohl ErrorMsg | echo item | echohl None
            endfor

            bdelete!
            let &lazyredraw = current_lazyredraw
            throw 'Bandit Error'
        endif

        bdelete!
        let &lazyredraw = current_lazyredraw
    endif
endfunction
" }}}

" Statusline {{{
function! StatuslineConflictWarning() abort
    if !exists("b:statusline_conflict_warning")

        if !&modifiable
            let b:statusline_conflict_warning = ''
            return b:statusline_conflict_warning
        endif

        if search('\v^[<=>]{7}( .*|$)', 'nw') != 0
            let b:statusline_conflict_warning = '[con!]'
        else
            let b:statusline_conflict_warning = ''
        endif
    endif
    return b:statusline_conflict_warning
endfunction

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning() abort
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight() abort
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning() abort
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning() abort
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines() abort
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums) abort
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction
" }}}

" Python Breakpoints {{{
python3 << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int(vim.eval('line(".")'))

    strLine = vim.current.line
    strWhite = re.search('^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)simport pdb; pdb.set_trace()  # %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)


def RemoveBreakpoints():
    nCurrentLine = int(vim.eval('line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:27] == "import pdb; pdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command("normal %dG" % nLine)
        vim.command("normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command("normal %dG" % nCurrentLine)

EOF
" }}}

" Initialize Directories {{{
function! InitializeDirectories() abort
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory',
              \ 'undodir': 'undodir' }

  for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "//"
      if exists("*mkdir")
          if !isdirectory(directory)
              call mkdir(directory)
          endif
      endif
      if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
      else
          let directory = substitute(directory, " ", "\\\\ ", "")
          execute "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()
" }}}

" Indentation Text Objects {{{
" Thanks to Dylan McClure for the following indent text objects. They are
" awesome!
" https://vimways.org/2018/transactions-pending/
function! InIndentation()
    " select all text in current indentation level excluding any empty lines
    " that precede or follow the current indentationt level;
    "
    " the current implementation is pretty fast, even for many lines since it
    " uses "search()" with "\%v" to find the unindented levels
    "
    " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
    "       then the entire buffer will be selected
    "
    " WARNING: python devs have been known to become addicted to this

    " magic is needed for this
    let l:magic = &magic
    set magic

    " move to beginning of line and get virtcol (current indentation level)
    " BRAM: there is no searchpairvirtpos() ;)
    normal! ^
    let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

    " pattern matching anything except empty lines and lines with recorded
    " indentation level
    let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

    " find first match (backwards & don't wrap or move cursor)
    let l:start = search(l:pat, 'bWn') + 1

    " next, find first match (forwards & don't wrap or move cursor)
    let l:end = search(l:pat, 'Wn')

    if (l:end !=# 0)
            " if search succeeded, it went too far, so subtract 1
            let l:end -= 1
    endif

    " go to start (this includes empty lines) and--importantly--column 0
    execute 'normal! '.l:start.'G0'

    " skip empty lines (unless already on one .. need to be in column 0)
    call search('^[^\n\r]', 'Wc')

    " go to end (this includes empty lines)
    execute 'normal! Vo'.l:end.'G'

    " skip backwards to last selected non-empty line
    call search('^[^\n\r]', 'bWc')

    " go to end-of-line 'cause why not
    normal! $o

    " restore magic
    let &magic = l:magic
endfunction

function! AroundIndentation()
    " select all text in the current indentation level including any emtpy
    " lines that precede or follow the current indentation level;
    "
    " the current implementation is pretty fast, even for many lines since it
    " uses "search()" with "\%v" to find the unindented levels
    "
    " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
    "       then the entire buffer will be selected
    "
    " WARNING: python devs have been known to become addicted to this

    " magic is needed for this (/\v doesn't seem work)
    let l:magic = &magic
    set magic

    " move to beginning of line and get virtcol (current indentation level)
    " BRAM: there is no searchpairvirtpos() ;)
    normal! ^
    let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

    " pattern matching anything except empty lines and lines with recorded
    " indentation level
    let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

    " find first match (backwards & don't wrap or move cursor)
    let l:start = search(l:pat, 'bWn') + 1

    " NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
    "       and l:start does not equal line('.')
    " FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
    "         everything from beginning of the buffer (if you don't like
    "         this, then you can modify the code) since this will be the
    "         equivalent of "norm! 1G" below
    " LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
    "         we want to add one to l:start since it will always match one
    "         line too high if search() succeeds

    " next, find first match (forwards & don't wrap or move cursor)
    let l:end = search(l:pat, 'Wn')

    " NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
    "       equal to line('.'), then the search succeeded.
    " FORMER: l:end is 0; we want this to match until the end-of-buffer if it
    "         fails to find a match for same reason as mentioned above;
    "         again, modify code if you do not like this); therefore, keep
    "         0--see "NOTE:" below inside the if block comment
    " LATTER: l:end is not 0, so the search() must have succeeded, which means
    "         that l:end will match a different line than line('.')

    if (l:end !=# 0)
        " if l:end is 0, then the search() failed; if we subtract 1, then it
        " will effectively do "norm! -1G" which is definitely not what is
        " desired for probably every circumstance; therefore, only subtract one
        " if the search() succeeded since this means that it will match at least
        " one line too far down
        " NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
        "       so it's ok if l:end is kept as 0. As mentioned above, this means
        "       that it will match until end of buffer, but that is what I want
        "       anyway (change code if you don't want)
        let l:end -= 1
    endif

    " finally, select from l:start to l:end
    execute 'normal! '.l:start.'G0V'.l:end.'G$o'

    " restore magic
    let &magic = l:magic
endfunction
" }}}

" Generate Functions {{{
function! GetGitDir() abort
    if finddir('.git', ';') == ''
        let l:directory = '.'
    else
        let l:directory = system("git rev-parse --show-toplevel \| tr -d '\\n'")
    endif
    return l:directory
endfunction
" }}}

" Floating Term {{{
function! FloatTerm()
    let found_winnr = 0
    for winnr in range(1, winnr('$'))
        if getbufvar(winbufnr(winnr), '&buftype') == 'terminal'
            let found_winnr = winnr
        endif
    endfor

    if found_winnr > 0
        if &buftype == 'terminal'
            " if current window is the terminal window, close it
            execute found_winnr . ' wincmd q'
        else
            " if current window is not terminal, go to the terminal window
            execute found_winnr . ' wincmd w'
        endif
    else
        let found_bufnr = 0
        for bufnr in filter(range(1, bufnr('$')), 'bufexists(v:val)')
            let buftype = getbufvar(bufnr, '&buftype')
            if buftype == 'terminal'
                let found_bufnr = bufnr
            endif
        endfor

        call s:openFloatingTerm()
    endif
endfunction

" Floating Term
function! s:openFloatingTerm()
  " Configuration
    let s:float_term_border_win = 0
    let s:float_term_win = 0
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  let border_buf = nvim_create_buf(v:false, v:true)
  let s:float_term_border_win = nvim_open_win(border_buf, v:true, border_opts)
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  hi FloatTermNormal cterm=None guibg=#17152e
  " hi FloatTermNormal term=None guibg=black ctermbg=black
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatTermNormal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:FloatTermNormal')
  terminal
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once call nvim_win_close(s:float_term_border_win, v:true)
endfunction
" }}}

" Other Funcs {{{
" Because BufWritePre can end up doing a lot of work, force vim to write files
" one at a time.
function! SyncWriteAll()
    let cur_buf = bufnr()
    bufdo update
    execute 'buffer' . cur_buf
endfunction

command! -bar -bang -nargs=0 Wa call SyncWriteAll()
]])


function _map(mode, shortcut, command, is_silent)
  vim.keymap.set(mode, shortcut, command, {remap = false, silent = is_silent})
end

function nmap(shortcut, command)
  _map('n', shortcut, command, false)
end

function silent_nmap(shortcut, command)
  _map('n', shortcut, command, true)
end

function imap(shortcut, command)
  _map('i', shortcut, command, false)
end

function xmap(shortcut, command)
  _map('x', shortcut, command, false)
end

function silent_xmap(shortcut, command)
  _map('x', shortcut, command, true)
end

function vmap(shortcut, command)
  _map('v', shortcut, command, false)
end

function cmap(shortcut, command)
  _map('c', shortcut, command, false)
end

function tmap(shortcut, command)
  _map('t', shortcut, command, false)
end

function silent_tmap(shortcut, command)
  _map('t', shortcut, command, true)
end

function omap(shortcut, command)
  _map('o', shortcut, command, false)
end

function silent_omap(shortcut, command)
  _map('o', shortcut, command, true)
end
