-- ~/.vim/my/basic.vim converted to Lua

-- Set encoding (not directly needed in Lua, but good practice)
-- vim.cmd('scriptencoding utf-8')

-- Set options
vim.opt.autoindent = true
vim.opt.history = 500
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.modeline = true
vim.opt.shiftround = true
vim.opt.infercase = true
vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.backspace = '2' -- Equivalent to bs=2

vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,full'
vim.opt.textwidth = 0
vim.opt.foldmethod = 'manual'

if vim.fn.has('clipboard') == 1 then
  if vim.fn.has('unnamedplus') == 1 then
    vim.opt.clipboard = 'unnamed,unnamedplus'
  else
    vim.opt.clipboard = 'unnamed'
  end
end

vim.opt.completeopt = 'menuone'
vim.opt.backspace = {'indent', 'start', 'eol'}
vim.opt.listchars = {tab = '»-', trail = '_', extends = '»', precedes = '«', nbsp = '%'}
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.matchpairs:append('<:>')
vim.opt.nrformats:remove('octal')

vim.g.netrw_liststyle = 1

vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.viewoptions = 'folds,options,cursor,unix,slash'
vim.opt.iskeyword:remove('.')
vim.opt.iskeyword:remove('#')

vim.opt.ttyfast = true
vim.opt.lazyredraw = true

vim.opt.report = 0
vim.opt.synmaxcol = 200

vim.opt.hlsearch = true

vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'ucs-bom,iso-2022-jp,utf-8,euc-jp,cp932,default,latin'
vim.opt.fileformats = 'unix,dos,mac'

vim.opt.ambiwidth = 'double'

vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
vim.opt.display = 'lastline'
vim.opt.pumheight = 11

if vim.fn.has('nvim') == 1 then
  vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
end
