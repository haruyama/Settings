vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.cinwords = 'if,elif,else,for,while,try,except,finally,def,class'
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.smarttab = true

vim.opt_local.omnifunc = 'pythoncomplete#Complete'

vim.g.python_highlight_all = 1

vim.opt_local.tags:append('~/.vim/tags/python/python.tags')

vim.opt_local.formatoptions:remove('r')
vim.opt_local.formatoptions:remove('o')

local augroup = vim.api.nvim_create_augroup('after_ftplugin_python', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})
