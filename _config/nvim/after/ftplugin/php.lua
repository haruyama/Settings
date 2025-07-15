vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.omnifunc = 'phpcomplete#CompletePHP'
vim.opt_local.iskeyword:remove('-')

local augroup = vim.api.nvim_create_augroup('after_ftplugin_php', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})
