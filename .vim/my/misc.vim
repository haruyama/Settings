command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2202-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis ++enc = cp932
command! -nargs=0 CdCurrent cd %:p:h
command! ReloadVimrc  source $MYVIMRC

source $VIMRUNTIME/macros/matchit.vim

set omnifunc=syntaxcomplete#Complete

let g:yankring_history_dir  = $HOME . '/.vim/history'
let g:yankring_manual_clipboard_check = 1

function! RTrim()
  let s:cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', s:cursor)
endfunction

command! Rtrim :call RTrim()

augroup my_filetype
  autocmd!
  autocmd BufRead,BufNewFile *.scala set filetype=scala
  autocmd BufRead,BufNewFile *.clj   set filetype=clojure
augroup END

augroup my_import
  autocmd!
  autocmd BufRead,BufNewFile *.{java,scala} setl include=^#\s*import
  autocmd BufRead,BufNewFile *.{java,scala} setl includeexpr=substitute(v:fname,'\\.','/','g')
augroup END

map gf <C-W>f

augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

let g:template_vim_template_dir = $HOME . '/.vim/template'
let g:template_vim_template_dirs = [$HOME . '/.vim/template']

nnoremap <SID>(toggle-paste)          :<C-u>set paste!<CR>
nnoremap <SID>(toggle-number)         :<C-u>set number!<CR>
nnoremap <SID>(toggle-relativenumber) :<C-u>set relativenumber!<CR>

nmap <Leader>1 <SID>(toggle-number)
nmap <Leader>2 <SID>(toggle-relativenumber)
nmap <Leader>3 <SID>(toggle-paste)

let g:ref_clojure_cmd =['lein', 'trampoline', 'run', '-m', 'clojure.main']
let g:ref_clojure_precode = '(use ''[clojure.repl :only (doc find-doc)])'
let g:ref_javadoc_path = '/usr/share/doc/openjdk-7-jre-headless/'

function! Ref(source)
  exe 'Ref ' . a:source . ' ' . expand("<cfile>")
endfunction

function! VimShellSendStringAndMove(line1, line2, string)
  let string = join(getline(a:line1, a:line2), "\<LF>")
  let string .= "\<LF>"
  execute "VimShellSendString " . string
  call cursor(a:line2 + 1, 1)
endfunction

command! -range -nargs=? VimShellSendStringAndMove call VimShellSendStringAndMove(<line1>, <line2>, <q-args>)

vnoremap <silent> ,s :VimShellSendString<CR>
vnoremap <silent> <CR> :VimShellSendStringAndMove<CR>

let g:vimfiler_as_default_explorer = 1
hi MatchParen cterm=underline ctermbg=NONE gui=underline guibg=NONE

"augroup my_rainbow_parentheses
"  autocmd!
"  au VimEnter * RainbowParenthesesToggle
"  au Syntax * RainbowParenthesesLoadRound
"  au Syntax * RainbowParenthesesLoadSquare
"  au Syntax * RainbowParenthesesLoadBraces
"augroup END

"http://cohama.hateblo.jp/entry/20121017/1350482411
let g:endwise_no_mappings = 1
augroup my_endwise_with_smartinput
  autocmd!
  autocmd FileType lua,ruby,sh,zsh,vb,vbnet,aspvbs,vim imap <buffer> <CR> <CR><Plug>DiscretionaryEnd
augroup END

let g:niji_matching_filetypes = ['lisp', 'scheme']

vnoremap <silent> <Enter> :EasyAlign<cr>
