local vim = vim
local M = {}

function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        local augroup = vim.api.nvim_create_augroup(group_name, {clear = true})

        for _, def in ipairs(definition) do
            vim.api.nvim_create_autocmd(def.events, {
                pattern = def.pattern,
                group = augroup,
                desc = def.description,
                command = def.command,
                callback = def.callback,
            })
        end
    end
end

local autoCommands = {
    open_folds = {
        {
            events = {"BufReadPost", "FileReadPost"},
            pattern = "*",
            command = "normal zR"
        }
    },
    file_type_fzf = {
        {
            events = "FileType",
            pattern = "fzf",
            command = "tnoremap <buffer> <silent> <C-j> <down>",
        },
        {
            events = "FileType",
            pattern = "fzf",
            command = "tnoremap <buffer> <silent> <C-k> <up>",
        },
        {
            events = "FileType",
            pattern = "fzf",
            command = "tnoremap <buffer> <silent> <C-h> <nop>",
        },
        {
            events = "FileType",
            pattern = "fzf",
            command = "tnoremap <buffer> <silent> <C-l> <nop>",
        },
        {
            events = "FileType",
            pattern = "fzf",
            command = "tnoremap <buffer> <silent> <Esc> <C-c>",
        },
    },
    file_type_yaml = {
        {
            events = "FileType",
            pattern = "yaml",
            command = "setlocal shiftwidth=2",
        },
    },
    file_type_sh = {
        {
            events = "FileType",
            pattern = "sh",
            command = "setlocal foldmethod=expr",
        },
        {
            events = "FileType",
            pattern = "sh",
            command = "setlocal foldexpr=nvim_treesitter#foldexpr()",
        },
    },
    file_type_lua = {
        {
            events = "FileType",
            pattern = "lua",
            command = "setlocal foldmethod=marker",
        },
    },
    file_type_vim = {
        {
            events = "FileType",
            pattern = "vim",
            command = "setlocal foldmethod=marker",
        },
    },
    file_type_make = {
        {
            events = "FileType",
            pattern = "make",
            command = "setlocal noexpandtab",
        },
    },
    file_type_git = {
        {
            events = "FileType",
            pattern = {"git", "gitcommit"},
            command = "setlocal nospell",
        },
        {
            events = "FileType",
            pattern = {"git", "gitcommit"},
            command = "setlocal nolist",
        },

        -- When amending git commits :q can accidentally succeed if a message
        -- already exists. Instead, replace :q with :cq to force vim to exit with
        -- an error code.
        {
            events = "FileType",
            pattern = "gitcommit",
            command = "cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline()[0] == 'q' ? 'cq' : 'q'",
        },
    },
    file_type_term = {
        {
            events = "TermOpen",
            pattern = "*",
            command = "setlocal nonumber",
        },
    },
    file_type_help = {
        {
            events = "FileType",
            pattern = "help",
            command = "setlocal nospell",
        },
    },
    file_type_json = {
        {
            events = "FileType",
            pattern = "json",
            command = "setlocal foldmethod=indent",
        },
    },
    file_type_md = {
        {
            events = "FileType",
            pattern = "markdown",
            command = "setlocal spell spelllang=en_us",
        },
    },
    file_type_text = {
        {
            events = "FileType",
            pattern = "text",
            command = "setlocal spell spelllang=en_us",
        },
        {
            events = "FileType",
            pattern = "text",
            command = "setlocal noexpandtab",
        },
    },
    file_type_cs = {
        {
            events = "FileType",
            pattern = "cs",
            command = "setlocal omnifunc=syntaxcomplete#Complete",
        },
        {
            events = "FileType",
            pattern = "cs",
            command = "setlocal foldmethod=expr",
        },
    },
    file_type_html = {
        {
            events = "FileType",
            pattern = "html",
            command = "setlocal noexpandtab",
        },
    },
    file_type_htmldjango = {
        {
            events = "FileType",
            pattern = "htmldjango",
            command = "setlocal foldmethod=indent",
        },
        {
            events = "FileType",
            pattern = "htmldjango",
            command = "setlocal foldlevel=99",
        },
    },
    file_type_python = {
        {
            events = "FileType",
            pattern = "python",
            command = "setlocal foldmethod=expr",
        },
        {
            events = "FileType",
            pattern = "python",
            command = "setlocal foldexpr=nvim_treesitter#foldexpr()",
        },
        {
            events = "FileType",
            pattern = "python",
            command = "setlocal omnifunc=pythoncomplete#Complete",
        },
    },
    general_setup = {
        {
            events = "InsertEnter",
            pattern = "*",
            command = "if &buftype != 'nofile' | highlight LineNr ctermbg=darkred   guibg=darkred | endif",
        },
        {
            events = "InsertEnter",
            pattern = "*",
            command = "if &buftype != 'nofile' && &buftype != 'prompt' | highlight CursorLine ctermbg=darkred guibg=darkred | else | highlight CursorLine ctermbg=NONE guibg=NONE | endif",
        },
        {
            events = "InsertEnter",
            pattern = "*",
            command = "if &buftype != 'nofile' | highlight statusline ctermbg=darkred   guibg=#690000 | endif",
        },

        {
            events = "InsertLeave",
            pattern = "*",
            command = "if &buftype != 'nofile' | highlight LineNr ctermbg=NONE guibg=NONE | endif",
        },
        {
            events = "InsertLeave",
            pattern = "*",
            command = "if &buftype != 'nofile' && &buftype != 'prompt' | highlight CursorLine ctermbg=18 guibg=darkblue | endif",
        },
        {
            events = "InsertLeave",
            pattern = "*",
            command = "if &buftype != 'nofile' | highlight statusline ctermbg=darkblue   guibg=#203780 | endif",
        },

        {
            events = "BufReadPost",
            pattern = "*",
            command = "if line(\"'\\\"\") > 0|if line(\"'\\\"\") <= line(\"$\")|exe(\"norm '\\\"\")|else|exe \"norm $\"|endif|endif",
        },

        -- Highlight all tabs and trailing whitespace characters.
        {
            events = "VimEnter",
            pattern = "*",
            command = "if &filetype != 'gitcommit' | highlight ExtraWhitespace ctermbg=darkred guibg=darkred ctermfg=yellow guifg=yellow | endif",
        },
        {
            events = "VimEnter",
            pattern = "*",
            command = "if &filetype != 'gitcommit' | match ExtraWhitespace /\\s\\+$\\|\\t/ | endif",
        },
        {
            events = "BufEnter",
            pattern = "*",
            command = "let &titlestring = \"nvim \" . expand(\"%:p\")",
        },

        {
            events = {"cursorhold", "bufwritepost"},
            pattern = "*",
            command = "unlet! b:statusline_trailing_space_warning",
        },
        {
            events = {"cursorhold", "bufwritepost"},
            pattern = "*",
            command = "unlet! b:statusline_conflict_warning",
        },
        {
            events = {"cursorhold", "bufwritepost"},
            pattern = "*",
            command = "unlet! b:statusline_tab_warning",
        },

        {
            events = {"FocusGained", "VimEnter", "WinEnter", "BufWinEnter"},
            pattern = "*",
            command = "setlocal cursorline",
        },
        {
            events = {"FocusLost", "WinLeave"},
            pattern = "*",
            command = "setlocal nocursorline",
        },
        {
            events = "FocusGained",
            pattern = "*",
            command = "checktime",
        },

        {
            events = "TermClose",
            pattern = "<buffer>",
            command = "if &buftype == 'terminal' | bdelete! | endif",
        },

        {
            events = "BufWritePre",
            pattern = "*",
            command = "call RaiseExceptionForUnresolvedErrors()",
        },

        {
            events = "FileType",
            pattern = {"vista", "vista_kind"},
            command = "nnoremap <buffer> <silent> / :<c-u>call vista#finder#fzf#Run()<CR>",
        },
    },

    terminal_setup = {
        {
            events = "TermOpen",
            pattern = "*",
            command = "setlocal nonumber norelativenumber bufhidden=hide",
        },
        {
            events = {"TermOpen", "BufWinEnter", "WinEnter"},
            pattern = "term://*",
            command = "startinsert",
        },
        {
            events = "BufLeave",
            pattern = "term://*",
            command = "stopinsert",
        },
    },

    apply_highlight = {
        {
            events = "ColorScheme",
            pattern = "*",
            command = "call ApplyHighlight()",
        },
    },

    telescope_augroup = {
        {
            events = "FileType",
            pattern = "TelescopePrompt",
            command = "call deoplete#custom#buffer_option('auto_complete', v:false)",
        },
        {
            events = "FileType",
            pattern = "TelescopePrompt",
            callback = function()
                vim.bo.asyncomplete_enable = 0
            end,
        },
    },
}

M.nvim_create_augroups(autoCommands)
