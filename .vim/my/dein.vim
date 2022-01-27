" let g:dein#auto_recache = v:true
let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = v:true

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

" if !dein#load_state(s:dein_dir)
"   finish
" end

call dein#begin(s:dein_dir)

call dein#load_toml('~/.vim/my/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/my/dein_lazy.toml', {'lazy': 1})
call dein#load_toml('~/.vim/my/dein_lazy_on_ft.toml', {'lazy': 1})

call dein#load_toml('~/.vim/my/ddu.toml', {'lazy': 1})
if has('nvim-0.5.0')
  call dein#load_toml('~/.vim/my/ddc-nvim.toml', {'lazy': 1})
else
  call dein#load_toml('~/.vim/my/vim-lsp.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/my/ddc-vim.toml', {'lazy': 1})
  " call dein#load_toml('~/.vim/my/deoplete.toml', {})
endif
call dein#load_toml('~/.vim/my/ddc-common.toml', {'lazy': 1})

call dein#end()
call dein#save_state()

if dein#check_install()
  call dein#install()
endif
