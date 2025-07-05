vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.smarttab = true
vim.opt_local.expandtab = true

if vim.fn.executable('lein') == 1 and vim.fn.filereadable('project.clj') == 1 then
  vim.b.is_lein_available = 1
end

if vim.fn.exists('*PareditInitBuffer') == 1 then
  vim.fn.PareditInitBuffer()
  vim.api.nvim_set_keymap('n', '<Leader>4', ':PareditToggle()<CR>', { buffer = 0, noremap = true, silent = true })
end

vim.opt_local.includeexpr = [[substitute(substitute(v:fname, '/.*
vim.opt_local.path:append('src,test')
vim.opt_local.suffixesadd:append('.clj,.cljs')

vim.g.syntastic_clojure_checkers = {'nrepl'}

local augroup = vim.api.nvim_create_augroup('after_ftplugin_clojure', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})

, '', ''), '\.', '/', 'g')]]
vim.opt_local.path:append('src,test')
vim.opt_local.suffixesadd:append('.clj,.cljs')

vim.g.syntastic_clojure_checkers = {'nrepl'}

local augroup = vim.api.nvim_create_augroup('after_ftplugin_clojure', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})

