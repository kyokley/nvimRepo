vim.cmd([[
" Install Plugins {{{
filetype off
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tommcdo/vim-exchange'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'kyokley/quicksilver.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
" Plug 'kyokley/JavaScript-Indent'
" Plug 'jelera/vim-javascript-syntax'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'ervandew/supertab'
Plug 'tomlion/vim-solidity'
Plug 'luochen1990/rainbow'
Plug 'kyokley/vim-colorschemes'
Plug 'whiteinge/diffconflicts'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vader.vim'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'skywind3000/asyncrun.vim'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'drzel/vim-line-no-indicator'
Plug 'wellle/context.vim'
" Plug 'romainl/vim-cool'
Plug 'kana/vim-textobj-user'
Plug 'thalesmello/vim-textobj-multiline-str'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'moll/vim-bbye'
Plug 'liuchengxu/vista.vim'
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'kyazdani42/nvim-web-devicons' " If you want devicons
Plug 'noib3/nvim-cokeline'

Plug '~/.config/nvim/manual/togglecomment'
Plug '~/.config/nvim/manual/pyfold'
Plug '~/.config/nvim/manual/visincr'
Plug '~/.config/nvim/manual/django-custom'
call plug#end()
" }}}

" Context Settings {{{
let g:context_add_mappings = 0
let g:context_enabled = 0
" }}}

" QuickSilver Config {{{
let g:QSMatchFn = 'fuzzy'
let g:QSIgnore = ".*\.pyc$;.*\.swp$;__pycache__$"
" }}}

" NERDTree {{{
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.pyc$', '\.swp$']
" }}}

" Python configs {{{
let g:loaded_python_provider = 0
let g:python3_dir = substitute(system("dirname $(pyenv which python3)"), '\n\+$', '', '') . '/'

let g:python3_host_prog = g:python3_dir . 'python'
" }}}

" SuperTab {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" }}}

" Rainbow Config {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['darkmagenta', 'darkgreen', 'darkyellow', 'blue', 'lightred'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \       'diff': 0,
    \   }
    \}
" }}}

" ALE Config {{{
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_executable = g:python3_dir . 'flake8'
let g:ale_completion_enabled = 0
let g:ale_completion_delay = 100
let g:ale_lint_on_enter = 1
let g:ale_enabled = 1
let g:ale_set_signs = 1
let g:ale_sign_offset = 2000
let g:ale_set_highlights = 1
let g:ale_sign_warning = '->'
let g:ale_linters = {
            \ 'python': ['flake8'],
            \}
" Check functions.vim for highlighting settings
" }}}

" GitGutter {{{
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
" }}}

" Jedi {{{
let g:jedi#completions_enabled = 0
let g:jedi#documentation_command=''
let g:jedi#show_call_signatures = "0"
" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1

" Only run deoplete setup if enabled at start up
" This is required for the docker install
if g:deoplete#enable_at_startup
    call deoplete#custom#option({
                \ 'auto_complete_delay': 100,
                \ 'smart_case': v:true,
                \ })
endif
" }}}

" AsyncRun {{{
let g:asyncrun_open = 10
let g:asyncrun_bell = 1
" }}}

" Rooter {{{
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1
" }}}

" Semshi {{{
let g:semshi#error_sign = v:false
" }}}

" LineNoIndicator {{{
"let g:line_no_indicator_chars = ['⎺', '⎻', '⎼', '⎽'] " on Linux

" one char wide solid vertical bar
let g:line_no_indicator_chars = [
  \  '█',
  \  '▇',
  \  '▆',
  \  '▅',
  \  '▄',
  \  '▃',
  \  '▂',
  \  '▁',
  \  ' '
  \  ]
"
"let g:line_no_indicator_chars = [
"  \ '  ', '░ ', '▒ ', '▓ ', '█ ', '█░', '█▒', '█▓', '██'
"  \ ]
" }}}

" {{{ Vista
let g:vista_highlight_whole_line = 1
let g:vista_blank = [0, 0]
let g:vista_top_level_blink = [0, 0]
let g:vista_echo_cursor = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_cursor_delay = 1000
" }}}

" {{{ FZF
nnoremap <silent> <C-p> :<C-u>exe
        \ finddir('.git', ';') != ''
        \   ? 'GFiles'
        \   : findfile('.git', ';') != ''
        \       ? 'GFiles' : 'Files'<CR>

nnoremap <silent> <leader>8 :<C-u>call ProjectGrep(1, expand("<cword>"))<CR>

nnoremap <leader>a :<C-u>call ProjectGrep(0)<CR>
" }}}
]])

-- Cokeline Bufferline Config {{{
local get_hex = require('cokeline/utils').get_hex

local green = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3
local blue = "darkblue"

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
      fg = get_hex('Comment', 'fg'),
      style = 'italic',
    },
    filename = {
                    text = function(buffer)
                        return buffer.filename
                    end,
                    -- fg = function(buffer)
                    --     -- if buffer.is_focused then
                    --     --     return "#78dce8"
                    --     -- end
                    --     if buffer.is_modified then
                    --         return "#e5c463"
                    --     end
                    --     -- if buffer.lsp.errors ~= 0 then
                    --     --     return "#fc5d7c"
                    --     -- end
                    -- end,
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
      components.readonly,
      components.unsaved,
      components.right_cap,
      },
})
-- }}}
