vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.path:append('lib')
vim.opt_local.iskeyword:append('?')

vim.opt_local.omnifunc = 'rubycomplete#Complete'
vim.opt_local.formatoptions:remove('r')
vim.opt_local.formatoptions:remove('o')

local augroup = vim.api.nvim_create_augroup('after_ftplugin_ruby', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = {'ruby', 'eruby'},
  callback = function()
    vim.g.rubycomplete_buffer_loading = 1
    vim.g.rubycomplete_classes_in_global = 1
  end,
})

vim.g.syntastic_ruby_checkers = {'mri', 'rubocop'}
