vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.smarttab = true
vim.opt_local.iskeyword:append('$')
vim.opt_local.iskeyword:append('-')

local augroup = vim.api.nvim_create_augroup('after_ftplugin_typescript', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})
