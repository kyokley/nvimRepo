-- Install Plugins {{{
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('scrooloose/nerdtree', { on = 'NERDTreeToggle' })
Plug('tpope/vim-fugitive')
Plug('tpope/vim-surround')
Plug('tpope/vim-repeat')
Plug('tpope/vim-abolish')
Plug('tommcdo/vim-exchange')
Plug('simnalamburt/vim-mundo', { on = 'MundoToggle'})
Plug('kyokley/quicksilver.vim')
Plug('airblade/vim-gitgutter')
Plug('mileszs/ack.vim')
-- Plug 'kyokley/JavaScript-Indent'
-- Plug 'jelera/vim-javascript-syntax'
Plug('numirias/semshi', {
    ['do'] = function()
        vim.cmd('UpdateRemotePlugins')
    end
})
-- Plug('ervandew/supertab')
Plug('tomlion/vim-solidity')
Plug('luochen1990/rainbow')
Plug('kyokley/vim-colorschemes')
Plug('whiteinge/diffconflicts')
Plug('kshenoy/vim-signature')
Plug('junegunn/vader.vim')
Plug('w0rp/ale')
Plug('davidhalter/jedi-vim')
Plug('zchee/deoplete-jedi')
Plug('Shougo/deoplete.nvim', {
    ['do'] = function()
        vim.cmd('UpdateRemotePlugins')
    end
})
Plug('skywind3000/asyncrun.vim')
Plug('airblade/vim-rooter')
Plug('mhinz/vim-startify')
Plug('drzel/vim-line-no-indicator')
Plug('wellle/context.vim')
-- Plug 'romainl/vim-cool'
Plug('kana/vim-textobj-user')
Plug('thalesmello/vim-textobj-multiline-str')
Plug('Vimjas/vim-python-pep8-indent')
Plug('dstein64/nvim-scrollview', { branch = 'main' })
Plug('moll/vim-bbye')
Plug('liuchengxu/vista.vim')
Plug('shime/vim-livedown')
Plug('junegunn/fzf', {
    ['do'] = function()
        vim.fn['fzf#install']()
    end
})
Plug('junegunn/fzf.vim')
Plug('tomasiser/vim-code-dark')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('kyazdani42/nvim-web-devicons')

Plug('willothy/nvim-cokeline')
Plug('neovim/nvim-lspconfig')

Plug('hrsh7th/nvim-cmp') -- Autocompletion plugin
Plug('hrsh7th/cmp-nvim-lsp') -- LSP source for nvim-cmp
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/cmp-nvim-lua')
Plug('saadparwaiz1/cmp_luasnip') -- Snippets source for nvim-cmp
Plug('L3MON4D3/LuaSnip') -- Snippets plugin
Plug('rafamadriz/friendly-snippets') -- Snippets plugin

Plug('~/.config/nvim/manual/togglecomment')
Plug('~/.config/nvim/manual/pyfold')
Plug('~/.config/nvim/manual/visincr')
Plug('~/.config/nvim/manual/django-custom')
vim.call('plug#end')
-- }}}

vim.diagnostic.config({ virtual_text = true, signs = false })

-- Context Settings {{{
vim.g.context_add_mappings = 0
vim.g.context_enabled = 0
-- }}}

-- QuickSilver Config {{{
vim.g['QSMatchFn'] = "fuzzy"
vim.g['QSIgnore'] = ".*.pyc$;.*.swp$;__pycache__$"
-- }}}

-- NERDTree {{{
vim.g['NERDChristmasTree'] = 1
vim.g['NERDTreeHijackNetrw'] = 1
vim.g['NERDTreeIgnore'] = {'.pyc$', '.swp$'}
-- }}}

-- Python configs {{{
vim.g.loaded_python_provider = 0
vim.g.python3_dir = vim.fn.substitute(vim.fn.system("dirname $(pyenv which python3)"), '\\n\\+$', '', '') .. '/'
vim.g.python3_host_prog = vim.g.python3_dir .. 'python'
-- }}}

-- ALE Config {{{
vim.g.ale_python_flake8_use_global = 1
vim.g.ale_python_flake8_executable = vim.g.python3_dir .. 'flake8'
vim.g.ale_completion_enabled = 0
vim.g.ale_completion_delay = 100
vim.g.ale_lint_on_enter = 1
vim.g.ale_enabled = 1
vim.g.ale_set_signs = 1
vim.g.ale_sign_offset = 2000
vim.g.ale_set_highlights = 1
vim.g.ale_sign_warning = '->'
vim.g.ale_linters = {python = {'ruff'}}
vim.g.ale_virtualtext_cursor = 'disabled'
-- }}}

-- GitGutter {{{
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_enabled = 1
vim.g.gitgutter_sign_priority = 1
-- }}}

-- SuperTab {{{
vim.g['SuperTabDefaultCompletionType'] = "context"
vim.g['SuperTabContextDefaultCompletionType'] = "<c-n>"
-- }}}

-- Rainbow Config {{{
vim.g.rainbow_active = 1
-- }}}

-- Jedi {{{
vim.g['jedi#completions_enabled'] = 0
vim.g['jedi#documentation_command'] = ''
vim.g['jedi#show_call_signatures '] = "0"
-- }}}

-- Deoplete {{{
vim.fn['deoplete#custom#option']({
    auto_complete_delay = 100,
    smart_case = true,
})
-- }}}

-- AsyncRun {{{
vim.g.asyncrun_open = 10
vim.g.asyncrun_bell = 1
-- }}}

-- Rooter {{{
vim.g.rooter_silent_chdir = 1
vim.g.rooter_manual_only = 1
-- }}}

-- Semshi {{{
vim.g['semshi#error_sign'] = false
-- }}}

-- LineNoIndicator {{{
-- one char wide solid vertical bar
vim.g.line_no_indicator_chars = {
    '█',
    '▇',
    '▆',
    '▅',
    '▄',
    '▃',
    '▂',
    '▁',
    ' '
}
-- }}}

-- {{{ Vista
vim.g.vista_highlight_whole_line = 1
vim.g.vista_blank = {0, 0}
vim.g.vista_top_level_blink = {0, 0}
vim.g.vista_echo_cursor = 1
vim.g.vista_echo_cursor_strategy = 'floating_win'
vim.g.vista_cursor_delay = 1000
-- }}}

-- Cokeline Bufferline Config {{{
local get_hex = require('cokeline/utils').get_hex

local red = 'red'
local yellow = 'yellow'
local orange = 'orange'
local blue = "darkblue"
local green = "green"

local components = {
    space = { text = ' ' , bg = 'none'},
    left_cap = {
        text = function(buffer) return buffer.is_focused and '' or ' ' end,
        fg = function(buffer)
            return buffer.is_focused and blue or 'none'
        end,
        bg = 'none',
    },
    devicon = {
        text = function(buffer) return buffer.devicon.icon .. ' ' end,
        fg = function(buffer) return buffer.devicon.color end,
    },
    index = {
        text = function(buffer) return buffer.number .. ': ' end,
    },
    prefix = {
        text = function(buffer) return buffer.unique_prefix end,
        fg = function(buffer)
            return buffer.is_modified and orange or nil
        end,
        style = 'italic',
    },
    filename = {
        text = function(buffer)
            return buffer.filename
        end,
        fg = function(buffer)
            return buffer.is_modified and orange or nil
        end,
        style = function(buffer)
            if buffer.is_focused then
                return "bold"
            end
            return nil
        end
    },
    readonly = {
        text = function(buffer)
            if buffer.is_readonly then
                return " 🔒"
            end
            return ""
        end
    },
    unsaved = {
        text = function(buffer)
            return buffer.is_modified and ' ●' or '  '
        end,
        fg = function(buffer)
            return buffer.is_modified and "#e5c463" or nil
        end,
        truncation = { priority = 1 },
    },
    right_cap = {
        text = function(buffer) return buffer.is_focused and '' or ' ' end,
        fg = function(buffer)
            return buffer.is_focused and blue or 'none'
        end,
        bg = 'none',
    },
diagnostic_errors = {
    text = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
        or ''
    end,
    fg = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and red)
        or nil
    end,
    truncation = { priority = 1 },
  },
diagnostic_warnings = {
    text = function(buffer)
      return
        (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
        or ''
    end,
    fg = function(buffer)
      return
        (buffer.diagnostics.warnings ~= 0 and yellow)
        or nil
    end,
    truncation = { priority = 1 },
  },
}

require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and get_hex('Normal', 'fg') or 'none'
        end,
        bg = function(buffer)
            return buffer.is_focused and blue or 'none'
        end,
    },

    components = {
        components.space,
        components.left_cap,
        components.devicon,
        components.index,
        components.prefix,
        components.filename,
        components.diagnostic_errors,
        components.diagnostic_warnings,
        components.readonly,
        -- components.unsaved,
        components.right_cap,
    },
})
-- }}}
