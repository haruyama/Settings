vim.opt_local.tabstop = 4
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.smarttab = true

local augroup = vim.api.nvim_create_augroup('after_ftplugin_go', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = '*.go',
  command = 'silent !goimports -w %',
})
