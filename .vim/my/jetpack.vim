packadd vim-jetpack
call jetpack#begin()
call jetpack#load_toml($HOME . '/.vim/my/jetpack.toml')
call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap
call jetpack#end()
