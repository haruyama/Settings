if exists("g:loaded_syntastic_clojure_nrepl_checker")
    finish
endif
let g:loaded_syntastic_clojure_nrepl_checker=1

function! SyntaxCheckers_clojure_nrepl_IsAvailable()
    return executable('lein') && filereadable('project.clj')
endfunction

function! SyntaxCheckers_clojure_nrepl_GetLocList()
    let filename = substitute(expand('%'), getcwd() . '/', '', '')
    let prefix = matchstr(filename, "^\\(src\\|test\\)/")
    if empty(prefix)
        return []
    endif

    let template = '(require ''clojure.tools.namespace) (require ''clojure.test) (let [namespaces (clojure.tools.namespace/find-namespaces-in-dir (java.io.File. "%s"))] (doseq [ns namespaces] (prn ns) (require ns :reload) (if (re-find #"-test\z" (name ns)) (clojure.test/run-tests ns) (let [test-ns (symbol (str (name ns) "-test"))] (prn test-ns) (require test-ns :reload) (clojure.test/run-tests test-ns)))))'
    let exp      = printf(template, escape(filename, '"\'))
    let response = fireplace#client().eval(exp, {'session': 1})

    if type(response) == type(0)
        echo 'error on fireplace#client().eval()'
        return []
    endif

    if get(response, 'err', '') !=# ''
        let makeprg = syntastic#makeprg#build({
                    \ 'exe': 'echo',
                    \ 'fname': shellescape(substitute(response.err, 'compiling:(', 'compiling:(' . prefix, 'g')),
                    \ 'filetype': 'clojure',
                    \ 'subchecker': 'nrepl' })

        let errorformat = 'CompilerException java.lang.RuntimeException: %m\, compiling:(%f:%l:%c) '
        return SyntasticMake({
                    \ 'makeprg': makeprg,
                    \ 'errorformat': errorformat,})
    else
        echo substitute(response.out, '\r\|\n$', '', 'g')
        return []
    endif
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype': 'clojure',
            \ 'name': 'nrepl'})
" vim: set et sts=4 sw=4:
