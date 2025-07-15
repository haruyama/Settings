vim.opt_local.iskeyword:append('!')

vim.g.quickrun_config = vim.fn.get(vim.g, 'quickrun_config', {})
vim.g.quickrun_config.rust = {
  exec = 'cargo run',
}
