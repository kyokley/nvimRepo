function! ApplyHighlight() abort
    highlight MatchParen ctermbg=4

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

    highlight DiffAdd           cterm=bold ctermbg=none ctermfg=Green
    highlight DiffDelete        cterm=bold ctermbg=none ctermfg=Red
    highlight DiffChange        cterm=bold ctermbg=none ctermfg=Yellow
    highlight DiffText        cterm=bold ctermbg=Red ctermfg=Yellow
endfunction

function! s:FindError(file_name, bad_str, error_msg, ...) abort
    " Sometimes need to remove a temporary buffer
    let l:remove_temp_buffer = get(a:000, 0, 0)

    let l:line = search(a:bad_str, 'nw')
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

        let py_version = GetPyVersion()

        silent %yank p
        new
        silent 0put p
        silent $,$delete

        try
            if py_version == '[py3]'
                let pyflakes_cmd = '%!' . g:python3_dir . 'pyflakes'
                let bandit_cmd = '%!' . g:python3_dir . 'bandit -ll -s B322,B101 -'
            elseif py_version == '[py2]'
                let pyflakes_cmd = '%!' . g:python2_dir . 'pyflakes'
                let bandit_cmd = '%!' . g:python2_dir . 'bandit -ll -s B101 -'
            else
                bdelete!
                throw 'Could not determine python version!'
            endif

            silent execute pyflakes_cmd
            silent execute '%s/<stdin>/' . s:file_name . '/e'

            call s:FindError(s:file_name, '\(unable to detect \)\@<!undefined name', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'unexpected indent', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'expected an indented block', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'invalid syntax', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'unindent does not match any outer indentation level', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'EOL while scanning string literal', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'redefinition of unused', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'list comprehension redefines', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'shadowed by loop variable', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'syntax error', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'referenced before assignment', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'duplicate argument', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'repeated with different values', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'imports must occur at the beginning of the file', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'outside function', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'not properly in loop', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'outside loop', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'two starred expressions in assignment', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'too many expressions in star-unpacking assignment', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'assertion is always true', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'trailing comma not allowed without surrounding parentheses', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'keyword argument repeated', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'problem decoding source', 'Syntax error!', 1)
            call s:FindError(s:file_name, 'unexpected EOF', 'Syntax error!', 1)
        catch
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
            throw 'Bandit Error'
        endif

        bdelete!
    endif
endfunction
autocmd BufWritePre * call RaiseExceptionForUnresolvedErrors()

function! s:DiffWithSaved() abort
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call s:DiffWithSaved()

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

function! DetectPyVersion() abort
    silent %yank p
    new
    silent 0put p

    silent! execute '%!' . g:python3_host_prog . ' -c "import ast; import sys; ast.parse(sys.stdin.read())"'
    bdelete!
    if v:shell_error == 0
        return 'py3'
    endif

    silent %yank p
    new
    silent 0put p

    silent! execute '%!' . g:python_host_prog . ' -c "import ast; import sys; ast.parse(sys.stdin.read())"'
    bdelete!
    if v:shell_error == 0
        return 'py2'
    endif

    return 'Err'
endfunction

function! g:SetPyVersion(...) abort
    let b:py_version = ''

    if &filetype == 'python'
        let in_version = get(a:000, 0, '')

        if in_version != 'py2' && in_version != 'py3'
            let in_version = DetectPyVersion()
        endif

        let b:py_version = '[' . in_version . ']'

        call functions#SetPyflakeVersion()
    endif

    return b:py_version
endfunction
command! SetPyVersion call SetPyVersion()
command! SetPyVersion2 call SetPyVersion('py2')
command! SetPyVersion3 call SetPyVersion('py3')

function! GetPyVersion() abort
    if exists("b:py_version")
        return b:py_version
    else
        return ''
    endif
endfunction

function! functions#SetPyflakeVersion() abort
    if &filetype == 'python'
        if exists("b:py_version") && b:py_version == '[py2]'
            let g:ale_python_flake8_executable = g:python2_dir . 'flake8'
            let g:ale_python_isort_executable = g:python2_dir . 'isort'
        else
            let g:ale_python_flake8_executable = g:python3_dir . 'flake8'
            let g:ale_python_isort_executable = g:python3_dir . 'isort'
        endif
    endif
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

python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int(vim.eval('line(".")'))

    strLine = vim.current.line
    strWhite = re.search('^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)simport pdb; pdb.set_trace()  # %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'noremap <F12> :py SetBreakpoint()<cr>')

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

vim.command("noremap <F24> :py RemoveBreakpoints()<cr>")
EOF
"vim:syntax=vim

set nobackup

if version >= 703
    set undofile
    set undolevels=1000
    set undoreload=1000
    if !has('nvim')
        set cm=blowfish
    endif
endif

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
          if version < 703
              if settingname == 'undodir'
                  continue
              endif
          endif
          let directory = substitute(directory, " ", "\\\\ ", "")
          execute "set " . settingname . "=" . directory
      endif
  endfor
endfunction
call InitializeDirectories()
