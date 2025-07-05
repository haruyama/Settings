function SelectGitCommitType()
  local line = vim.fn.substitute(vim.fn.getline('.'), '^#\\s*', '', 'g')
  local title = string.format('%s: ', vim.fn.split(line, ' ')[1])

  vim.cmd('silent! normal! "_dip')
  vim.fn.setreg('"', title, 'l')
  vim.cmd('silent! put!')
  vim.cmd('silent! startinsert!')
end

vim.api.nvim_buf_set_keymap(0, 'n', '<CR><CR>', '<Cmd>lua SelectGitCommitType()<CR>', { noremap = true, silent = true })

