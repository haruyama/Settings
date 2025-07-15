local augroup = vim.api.nvim_create_augroup('after_ftplugin_scheme', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'scheme',
  callback = function()
    vim.b.is_gauche = 1
  end,
})

if vim.fn.exists('*PareditInitBuffer') == 1 then
  vim.fn.PareditInitBuffer()
  vim.api.nvim_set_keymap('n', '<Leader>4', ':PareditToggle()<CR>', { noremap = true })
end

vim.g.gosh_enable_auto_use = 1

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.scm',
  callback = function()
    print("g:last_terminal_job_id: " .. tostring(vim.g.last_terminal_job_id))
  end,
})

