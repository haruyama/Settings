vim.g.ale_cpp_cc_options = ' -Wall -std=c++2a -I ./inc -I ./include'
vim.g.ale_cpp_gcc_options = ' -Wall -std=c++2a -I ./inc -I ./include'
vim.g.ale_cpp_clang_options = ' -Wall -std=c++2a -I ./inc -I ./include'

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.omnifunc = 'ccomplete#Complete'

vim.opt_local.path:append {'src', 'inc', 'include'}
vim.opt_local.suffixesadd:append('.hpp,.cpp')

local augroup = vim.api.nvim_create_augroup('after_ftplugin_cpp', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})
