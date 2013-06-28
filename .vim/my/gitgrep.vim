"http://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim
func! GitGrep(...)
        let save = &grepprg
        set grepprg=git\ grep\ -n\ $*
        let s = 'grep'
        for i in a:000
                let s = s . ' ' . i
        endfor
        exe s
        let &grepprg = save
endfun
command! -nargs=? G call GitGrep(<f-args>)

func! GitGrepWord()
        normal! "zyiw
        call GitGrep('-w -e ', getreg('z'))
endf
nmap <C-x>G :call GitGrepWord()<CR>
