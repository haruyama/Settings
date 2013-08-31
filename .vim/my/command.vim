command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2202-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis ++enc = cp932
command! -nargs=0 CdCurrent cd %:p:h
command! ReloadVimrc  source $MYVIMRC

function! s:RTrim()
  let s:cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', s:cursor)
endfunction

command! RTrim :call s:RTrim()

function! s:VimShellSendStringAndMove(line1, line2, string)
  let string = join(getline(a:line1, a:line2), "\<LF>")
  let string .= "\<LF>"
  execute "VimShellSendString " . string
  call cursor(a:line2 + 1, 1)
endfunction

command! -range -nargs=? VimShellSendStringAndMove call s:VimShellSendStringAndMove(<line1>, <line2>, <q-args>)

vnoremap <silent> ,s   :VimShellSendString<CR>
vnoremap <silent> <CR> :VimShellSendStringAndMove<CR>
