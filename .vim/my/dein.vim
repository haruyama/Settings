let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1

if has('nvim-0.5.0')
  let s:dein_dir = expand('~/.cache/dein-nvim-0.5.0')
else
  let s:dein_dir = expand('~/.cache/dein')
endif
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"if !dein#load_state(s:dein_dir)
"  finish
"end

call dein#begin(s:dein_dir)

call dein#load_toml('~/.vim/my/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/my/dein_lazy.toml', {'lazy': 1})
"if has('nvim')
"  call dein#load_toml('~/.vim/my/deineo.toml', {})
"endif

if has('nvim-0.5.0')
 call dein#load_toml('~/.vim/my/ddc.toml', {})
else
 call dein#load_toml('~/.vim/my/deoplete.toml', {})
endif

call dein#end()
call dein#save_state()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif
