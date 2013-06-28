augroup my_template
  autocmd!

  function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, '')
    call append(4, '')
    call append(5, '')
    call append(6, '1;')
    call cursor(4, 0)
    " echomsg path
  endfunction
  autocmd BufNewFile *.pm call s:pm_template()

  function! s:clj_template()
    let ns = substitute(expand('%'), '\.clj$', '', '')
    let ns = substitute(ns, '[\\/]', '.', 'g')
    let ns = substitute(ns, '_', '-', 'g')

    if ns =~ '-test$'
      let ns = substitute(ns, '.*test\.', '', '')
      let target_ns = substitute(ns, '-test$', '', '')
      call append(0, '(ns ' . ns)
      call append(1, '  (:require [clojure.test :refer :all])')
      call append(2, '  (:require [' . target_ns . ' :refer :all]))')
      call append(3, '')
      call cursor(3, 0)
    else
      let ns = substitute(ns, '.*src\.', '', '')
      call append(0, '(ns ' . ns)
      call append(1, ';  (:require [clojure.test :refer :all])')
      call append(2, '  )')
      call cursor(2, 0)
    endif
  endfunction
  autocmd BufNewFile *.clj call s:clj_template()
augroup END
