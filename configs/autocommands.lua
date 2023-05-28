local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end


local autoCommands = {
    -- other autocommands
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    },
    file_type_fzf = {
        {"FileType", "fzf", "tnoremap <buffer> <silent> <C-j> <down>"},
        {"FileType", "fzf", "tnoremap <buffer> <silent> <C-k> <up>"},
        {"FileType", "fzf", "tnoremap <buffer> <silent> <C-h> <nop>"},
        {"FileType", "fzf", "tnoremap <buffer> <silent> <C-l> <nop>"},
        {"FileType", "fzf", "tnoremap <buffer> <silent> <Esc> <C-c>"},
    },
    file_type_yaml = {
        {"FileType", "yaml", "setlocal shiftwidth=2"},
    },
    file_type_sh = {
        {"FileType", "sh", "setlocal foldmethod=expr"},
        {"FileType", "sh", "setlocal foldexpr=nvim_treesitter#foldexpr()"},
    },
    file_type_lua = {
        {"FileType", "lua", "setlocal foldmethod=marker"},
    },
    file_type_vim = {
        {"FileType", "vim", "setlocal foldmethod=marker"},
    },
    file_type_make = {
        {"FileType", "make", "setlocal noexpandtab"},
    },
    file_type_git = {
        {"FileType", "git,gitcommit", "setlocal nospell"},
        {"FileType", "git,gitcommit", "setlocal nolist"},

    -- When amending git commits :q can accidentally succeed if a message
    -- already exists. Instead, replace :q with :cq to force vim to exit with
    -- an error code.
    {"FileType", "gitcommit", "cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline()[0] == 'q' ? 'cq' : 'q'"},
    },
    file_type_term = {
        {"TermOpen", "*", "setlocal nonumber"},
    },
    file_type_help = {
        {"FileType", "help", "setlocal nospell"},
    },
    file_type_json = {
        {"FileType", "json", "setlocal foldmethod=indent"},
    },
    file_type_md = {
        {"FileType", "markdown", "setlocal spell spelllang=en_us"},
    },
    file_type_text = {
        {"FileType", "text", "setlocal spell spelllang=en_us"},
        {"FileType", "text", "setlocal noexpandtab"},
    },
    file_type_cs = {
        {"FileType", "cs", "setlocal omnifunc=syntaxcomplete#Complete"},
        {"FileType", "cs", "setlocal foldmethod=marker"},
        {"FileType", "cs", "setlocal foldmarker={,}"},
        {"FileType", "cs", "setlocal foldtext=substitute(getline(v:foldstart),'{.*','{...}',)"},
        {"FileType", "cs", "setlocal foldlevelstart=2"},
        {"FileType", "cs", "setlocal smartindent"},
    },
    file_type_html = {
        {"FileType", "html", "setlocal noexpandtab"},
    },
    file_type_htmldjango = {
        {"FileType", "htmldjango", "setlocal foldmethod=indent"},
        {"FileType", "htmldjango", "setlocal foldlevel=99"},
    },
    file_type_python = {
        {"FileType", "python", "setlocal foldmethod=expr"},
        {"FileType", "python", "setlocal foldexpr=nvim_treesitter#foldexpr()"},
        {"FileType", "python", "setlocal omnifunc=pythoncomplete#Complete"},
    },
    general_setup = {
        {"InsertEnter", "*", "if &buftype != 'nofile' | highlight LineNr ctermbg=darkred   guibg=darkred | endif"},
        {"InsertEnter", "*", "if &buftype != 'nofile' && &buftype != 'prompt' | highlight CursorLine ctermbg=darkred guibg=darkred | else | highlight CursorLine ctermbg=NONE guibg=NONE | endif"},
        {"InsertEnter", "*", "if &buftype != 'nofile' | highlight statusline ctermbg=darkred   guibg=#690000 | endif"},

        {"InsertLeave", "*", "if &buftype != 'nofile' | highlight LineNr ctermbg=NONE guibg=NONE | endif"},
        {"InsertLeave", "*", "if &buftype != 'nofile' && &buftype != 'prompt' | highlight CursorLine ctermbg=18 guibg=darkblue | endif"},
        {"InsertLeave", "*", "if &buftype != 'nofile' | highlight statusline ctermbg=darkblue   guibg=#203780 | endif"},

        {"BufReadPost", "*", "if line(\"'\\\"\") > 0|if line(\"'\\\"\") <= line(\"$\")|exe(\"norm '\\\"\")|else|exe \"norm $\"|endif|endif"},

        -- Highlight all tabs and trailing whitespace characters.
        {"VimEnter", "*", "if &filetype != 'gitcommit' | highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow | endif"},
        {"VimEnter", "*", "if &filetype != 'gitcommit' | match ExtraWhitespace /\\s\\+$\\|\\t/ | endif"},
        {"BufEnter", "*", "let &titlestring = \"nvim \" . expand(\"%:p\")"},

        -- recalculate the trailing whitespace warning when idle, and after saving
        {"cursorhold,bufwritepost", "*", "unlet! b:statusline_trailing_space_warning"},
        {"cursorhold,bufwritepost", "*", "unlet! b:statusline_conflict_warning"},
        {"cursorhold,bufwritepost", "*", "unlet! b:statusline_tab_warning"},

        {"FocusGained,VimEnter,WinEnter,BufWinEnter", "*", "setlocal cursorline"},
        {"FocusLost,WinLeave", "*", "setlocal nocursorline"},
        {"FocusGained", "*", "checktime"},

        {"TermClose", "<buffer>", "if &buftype == 'terminal' | bdelete! | endif"},

        {"BufWritePre", "*", "call RaiseExceptionForUnresolvedErrors()"},

        {"FileType", "vista,vista_kind", "nnoremap <buffer> <silent> / :<c-u>call vista#finder#fzf#Run()<CR>"},
    },

    terminal_setup = {
        {"TermOpen", "*", "setlocal nonumber norelativenumber bufhidden=hide"},
        {"TermOpen,BufWinEnter,WinEnter", "term://*", "startinsert"},
        {"BufLeave", "term://*", "stopinsert"},
    },

    apply_highlight = {
        {"ColorScheme", "*", "call ApplyHighlight()"},
    },
}

M.nvim_create_augroups(autoCommands)

-- {{{ Telescope Prompts
local telescope_augroup = vim.api.nvim_create_augroup('telescope_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'TelescopePrompt',
  group = telescope_augroup,
  command = "call deoplete#custom#buffer_option('auto_complete', v:false)"
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'TelescopePrompt',
    group = telescope_augroup,
    callback = function()
        vim.bo.asyncomplete_enable = 0
    end
})
-- }}}
