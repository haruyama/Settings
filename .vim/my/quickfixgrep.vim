function! QuickFixGrep(tool)
  setl lazyredraw
  let l:grepformat_save = &grepformat
  let l:grepprogram_save = &grepprg
  setl grepformat&vim
  let &grepformat = '%f:%l:%m'
  let &grepprg = a:tool
  if &readonly == 0 | update | endif
  silent! grep! %
  let &grepformat = l:grepformat_save
  let &grepprg = l:grepprogram_save
  execute 'cw'
  setl nolazyredraw
  redraw!
endfunction

function! CustomQuickFix(makeprg, errorformat)
  setl lazyredraw
  let old_makeprg = &l:makeprg
  let old_errorformat = &l:errorformat
  let &l:makeprg = a:makeprg
  let &l:errorformat = a:errorformat
  if &readonly == 0 | update | endif
  silent! make!
  let &l:makeprg = old_makeprg
  let &l:errorformat = old_errorformat
  execute 'cw'
  setl nolazyredraw
  redraw!
endfunction

