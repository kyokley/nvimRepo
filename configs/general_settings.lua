local vim = vim

vim.g['NERDChristmasTree'] = 1
vim.g['NERDTreeHijackNetrw'] = 1
vim.g['NERDTreeIgnore'] = {'\\.pyc$', '\\.swp$'}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 8
vim.opt.softtabstop=4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.hidden = true
vim.opt.autowrite = false
vim.opt.smarttab = true
vim.opt.showmatch = true
vim.opt.scrolloff = 5
vim.opt.visualbell = true
vim.opt.autochdir = true
vim.opt.wildignore = {'*.swp', '*.bak', '*.pyc', '*.class', '*.o', '*.obj', '*.git'}
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.wildmenu = true
vim.opt.wrapscan = false
vim.opt.textwidth = 0
vim.opt.mouse = ""
vim.opt.autoread = true
vim.opt.shiftround = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tell Vim which characters to show for expanded TABs,
-- trailing whitespace, and end-of-lines
vim.opt.listchars = 'trail:_'
vim.opt.list = true


vim.opt.cursorline = true

vim.g.codedark_italics = 1
vim.g.codedark_italics = 1
vim.cmd.colorscheme("codedark")

vim.o.background = 'dark'

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.timeout = true
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 100

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 1000
vim.opt.backup = false

vim.opt.diffopt = {'internal', 'algorithm:patience'}

vim.opt.inccommand = 'split'
vim.opt.guicursor = ''

vim.opt.termguicolors = true
