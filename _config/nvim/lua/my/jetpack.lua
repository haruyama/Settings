vim.cmd('packadd vim-jetpack')
vim.fn['jetpack#begin']()
vim.fn['jetpack#load_toml'](vim.fn.expand('$HOME') .. '/.vim/my/jetpack.toml')
vim.fn['jetpack#add']('tani/vim-jetpack', {opt = 1}) -- bootstrap
vim.fn['jetpack#end']()
