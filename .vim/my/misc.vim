source $VIMRUNTIME/macros/matchit.vim
set omnifunc=syntaxcomplete#Complete

"nnoremap gf <C-W>f
"vnoremap gf <C-W>f
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap <C-]> g<C-]>

nnoremap <SID>(toggle-number)         :<C-u>set number!<CR>
nnoremap <SID>(toggle-relativenumber) :<C-u>set relativenumber!<CR>
nnoremap <SID>(toggle-paste)          :<C-u>set paste!<CR>

nmap <Leader>1 <SID>(toggle-number)
nmap <Leader>2 <SID>(toggle-relativenumber)
nmap <Leader>3 <SID>(toggle-paste)

xnoremap <silent> <Leader>a :EasyAlign<cr>

nnoremap <silent> <C-l> :<C-u>nohlsearch<cr><C-l>

augroup vimrc_auto_mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

"hi MatchParen cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE guibg=NONE
"hi MatchParen cterm=bold,underline ctermfg=black ctermbg=DarkMagenta gui=bold,underline guifg=black guibg=yellow

let g:eregex_default_enable = 0

let g:gitgutter_enabled = 0

let g:niji_matching_filetypes = ['lisp', 'scheme']

let g:quickrun_config = {
\    "octave" : {
\       "command" : "octave",
\       "cmdopt"  : "--silent",
\   },
\    "ceylon" : {
\       "command" : "ceylon",
\       "cmdopt"  : "compile",
\   },
\}

let g:ref_clojure_cmd     = ['lein', 'trampoline', 'run', '-m', 'clojure.main']
let g:ref_clojure_precode = '(use ''[clojure.repl :only (doc find-doc)])'
let g:ref_javadoc_path    = '/usr/share/doc/openjdk-7-jre-headless/'

let g:syntastic_always_populate_loc_list = 1
" http://stackoverflow.com/questions/18270355/how-to-ignore-angular-directive-lint-error-with-vim-and-syntastic
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:template_vim_template_dir  = $HOME . '/.vim/template'
let g:template_vim_template_dirs = [$HOME . '/.vim/template']

let g:vimfiler_as_default_explorer = 1

let g:yankring_history_dir            = $HOME . '/.vim/history'
let g:yankring_manual_clipboard_check = 1

nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 50

let g:textobj_multiblock_blocks = [
\   [ '(', ')' ],
\   [ '[', ']' ],
\   [ '{', '}' ],
\]

" とりあえず、i だけを設定
" textobj-mutiblock と i"、i' を組み合わせる
let g:textobj_multitextobj_textobjects_i = [
\   "\<Plug>(textobj-multiblock-i)",
\   'i"',
\   "i'",
\]

let g:textobj_multitextobj_textobjects_a = [
\   "\<Plug>(textobj-multiblock-a)",
\   'a"',
\   "a'",
\]

omap ib <Plug>(textobj-multitextobj-i)
xmap ib <Plug>(textobj-multitextobj-i)
omap ab <Plug>(textobj-multitextobj-a)
xmap ab <Plug>(textobj-multitextobj-a)

let g:pandoc_no_folding = 1
let g:pandoc_use_conceal = 0

colorscheme wombat256mod

let g:vimshell_interactive_update_time = 500

"augroup incsearch-keymap
"  autocmd! VimEnter * call s:incsearch_keymap()
"augroup END
"function! s:incsearch_keymap()
"  IncSearchNoreMap <CR> <CR>
"endfunction
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
