vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.api.nvim_create_user_command('SbtVimShellInteractive', 'execute ":VimShellInteractive sbt"', {})

vim.opt_local.include = [[^\s*import]]
vim.opt_local.includeexpr = [[substitute(substitute(v:fname,'\.','/','g'),';','','g')]]
vim.opt_local.path:append('src/main/scala/**,src/test/scala/**,src/scala/**,test/scala/**')

vim.opt_local.suffixesadd:append('.scala')
local augroup = vim.api.nvim_create_augroup('after_ftplugin_scala', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  buffer = 0,
  command = ':RTrim',
})

vim.b.scommenter_class_author = 'HARUYAMA Seigo'
vim.b.scommenter_file_author = 'HARUYAMA Seigo'
vim.b.scommenter_extra_line_text_offset = 20

vim.api.nvim_set_keymap('n', '<M-c>', ':call ScalaCommentWriter()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-f>', ':call ScalaCommentFormatter()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cm', ':call ScalaCommentWriter()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cf', ':call ScalaCommentFormatter()<CR>', { noremap = true })
