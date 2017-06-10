if exists("g:loaded_ale_clojure_nrepl_checker")
    finish
endif
let g:loaded_ale_clojure_nrepl_checker=1

function! ale_linters#clojure#nrepl#Handle(buffer, lines) abort
    let l:filename = substitute(expand('%'), getcwd() . '/', '', '')
    let l:prefix = matchstr(filename, "^\\(src\\|test\\)/")
    if empty(l:prefix)
        return []
    endif

    let l:template = '(require ''clojure.tools.namespace) (require ''clojure.test) (let [namespaces (clojure.tools.namespace/find-namespaces-in-dir (java.io.File. "%s"))] (doseq [ns namespaces] (require ns :reload)))'
    let l:exp      = printf(l:template, escape(l:filename, '"\'))
    let l:response = fireplace#client().eval(l:exp, {})
    if type(l:response) == type(0)
        echo 'error on fireplace#client().eval()'
        return []
    endif

    let l:output = []
    if has_key(l:response, 'stacktrace')
        let l:err = substitute(l:response.err, '\e\[[0-9;]\+[mK]', '', 'g')
        let l:err = substitute(l:err, '\e\[[mK]', '', 'g')
        let l:err = substitute(l:err, ').*$', ')', 'g')
        for l:match in ale#util#GetMatches(l:err, '\(.\+\)\,\ (.\+:(.\+):\(.\+)\)')
            call add(l:output, {
                        \ 'lnum': l:match[2] + 0,
                        \ 'text': l:match[1],
                        \ 'col':  l:match[3] + 0,
                        \})
        endfor
        for l:match in ale#util#GetMatches(l:err, '^\(.\+\)\, starting at line \(\d\+\)')
            call add(l:output, {
                        \ 'lnum': l:match[2] + 0,
                        \ 'text': l:match[1],
                        \})
        endfor
    endif

    return l:output

endfunction

call ale#linter#Define('clojure', {
\    'name': 'nrepl',
\    'executable': 'echo',
\    'command': 'echo',
\    'callback': 'ale_linters#clojure#nrepl#Handle',
\})

" vim: set et sts=4 sw=4:
