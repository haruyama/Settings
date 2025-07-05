vim.opt_local.path:append('/usr/include/x86_64-linux-gnu')
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.omnifunc = 'ccomplete#Complete'

vim.g.syntastic_c_compiler_options = ' -std=gnu11 -I ./inc -I ./include'

local augroup = vim.api.nvim_create_augroup('after_ftplugin_c', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})
