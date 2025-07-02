scriptencoding utf-8
"source $VIMRUNTIME/macros/matchit.vim
" set omnifunc=syntaxcomplete#Complete

"nnoremap gf <C-W>f
"vnoremap gf <C-W>f
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap <C-]> g<C-]>

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

augroup QuickFixCmd
  autocmd! QuickFixCmdPost make,*grep* cwindow
augroup END

" https://github.com/ryanpcmcquen/fix-vim-pasting/blob/master/plugin/fix-vim-pasting.vim
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ''
endfunction
