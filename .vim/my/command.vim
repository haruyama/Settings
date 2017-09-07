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


if has('nvim')
  augroup Terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  augroup END
  function! s:REPLSend(line1, line2, string)
    let l:string = join(getline(a:line1, a:line2), "\<LF>")
    let l:string .= "\<LF>"
    call jobsend(g:last_terminal_job_id, l:string)
    call cursor(a:line2 + 1, 1)
  endfunction

  command! REPLSendLine call s:REPLSend([getline('.')])
  command! -range -nargs=? REPLSendLine call s:REPLSend(<line1>, <line2>, <q-args>)

  xnoremap <silent> <CR> :REPLSendLine<CR>
elseif has('terminal')
  augroup Terminal
    au!
    " 新規に作られた直後にこれだけだといけてない
    " もう一度 buffer に入り直す必要あり
    au BufEnter * if &l:buftype ==# 'terminal' | let g:last_terminal_bn = bufnr('%') | endif
  augroup END
  function! s:REPLSend(line1, line2, string)
    call cursor(a:line1, 1)
    let l:string = join(getline(a:line1, a:line2), "\<LF>")
    let l:string .= "\<LF>"
    call term_sendkeys(g:last_terminal_bn, l:string)
    call term_wait(g:last_terminal_bn)
    call cursor(a:line2 + 1, 1)
  endfunction

  command! REPLSendLine call s:REPLSend([getline('.')])
  command! -range -nargs=? REPLSendLine call s:REPLSend(<line1>, <line2>, <q-args>)

  xnoremap <silent> <CR> :REPLSendLine<CR>
else
  function! s:VimShellSendStringAndMove(line1, line2, string)
    let string = join(getline(a:line1, a:line2), "\<LF>")
    let string .= "\<LF>"
    execute 'VimShellSendString ' . string
    call cursor(a:line2 + 1, 1)
  endfunction
  command! -range -nargs=? VimShellSendStringAndMove call s:VimShellSendStringAndMove(<line1>, <line2>, <q-args>)
  xnoremap <silent> ,s   :VimShellSendString<CR>
  xnoremap <silent> <CR> :VimShellSendStringAndMove<CR>
endif
