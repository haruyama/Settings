" http://calcurio.com/blog/vim_mark.html

" 最初からマークを表示する
aug show-marks-sync
        au!
        au BufReadPost * sil! DoShowMarks
aug END
"----------------------------------------------
" vimのマーク機能をできるだけ活用してみる - Make 鮫 noise
" http://saihoooooooo.hatenablog.com/entry/2013/04/30/001908
" mを押すことで現在位置に対して自動的にアルファベットを割り振る
"----------------------------------------------
" マーク設定 : {{{
" 基本マップ
nnoremap [Mark] <Nop>
nmap m [Mark]
" 現在位置をマーク
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]m :<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction
" 次にマークする文字を設定するExコマンドを定義
command! -nargs=? SetNextMarkChar call s:set_next_mark_char(<f-args>)
function! s:set_next_mark_char(...)
  if a:0 >= 1
    let b:markrement_pos=index(g:markrement_char,a:1)-1
  else
    echo "Next:".g:markrement_char[b:markrement_pos+1]
  end
endfunction
" 次にマークする文字を設定する
nnoremap [Mark]sa :SetNextMarkChar a<CR>
nnoremap [Mark]sb :SetNextMarkChar b<CR>
nnoremap [Mark]sc :SetNextMarkChar c<CR>
nnoremap [Mark]sd :SetNextMarkChar d<CR>
nnoremap [Mark]se :SetNextMarkChar e<CR>
nnoremap [Mark]sf :SetNextMarkChar f<CR>
nnoremap [Mark]sg :SetNextMarkChar g<CR>
nnoremap [Mark]sh :SetNextMarkChar h<CR>
nnoremap [Mark]si :SetNextMarkChar i<CR>
nnoremap [Mark]sj :SetNextMarkChar j<CR>
nnoremap [Mark]sk :SetNextMarkChar k<CR>
nnoremap [Mark]sl :SetNextMarkChar l<CR>
nnoremap [Mark]sm :SetNextMarkChar m<CR>
nnoremap [Mark]sn :SetNextMarkChar n<CR>
nnoremap [Mark]so :SetNextMarkChar o<CR>
nnoremap [Mark]sp :SetNextMarkChar p<CR>
nnoremap [Mark]sq :SetNextMarkChar q<CR>
nnoremap [Mark]sr :SetNextMarkChar r<CR>
nnoremap [Mark]ss :SetNextMarkChar s<CR>
nnoremap [Mark]st :SetNextMarkChar t<CR>
nnoremap [Mark]su :SetNextMarkChar u<CR>
nnoremap [Mark]sv :SetNextMarkChar v<CR>
nnoremap [Mark]sw :SetNextMarkChar w<CR>
nnoremap [Mark]sx :SetNextMarkChar x<CR>
nnoremap [Mark]sy :SetNextMarkChar y<CR>
nnoremap [Mark]sz :SetNextMarkChar z<CR>
" 次にマークする文字を設定して，同時にマークする
nnoremap [Mark]fa :SetNextMarkChar a<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fb :SetNextMarkChar b<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fc :SetNextMarkChar c<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fd :SetNextMarkChar d<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fe :SetNextMarkChar e<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]ff :SetNextMarkChar f<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fg :SetNextMarkChar g<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fh :SetNextMarkChar h<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fi :SetNextMarkChar i<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fj :SetNextMarkChar j<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fk :SetNextMarkChar k<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fl :SetNextMarkChar l<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fm :SetNextMarkChar m<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fn :SetNextMarkChar n<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fo :SetNextMarkChar o<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fp :SetNextMarkChar p<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fq :SetNextMarkChar q<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fr :SetNextMarkChar r<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fs :SetNextMarkChar s<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]ft :SetNextMarkChar t<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fu :SetNextMarkChar u<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fv :SetNextMarkChar v<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fw :SetNextMarkChar w<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fx :SetNextMarkChar x<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fy :SetNextMarkChar y<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
nnoremap [Mark]fz :SetNextMarkChar z<CR>:<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
" 次/前のマーク
nnoremap [Mark]n ]`
nnoremap [Mark]p [`
" 一覧表示
nnoremap [Mark]l :<C-u>PreviewMarks<CR>
" マークの全削除を行うコマンドを設定する
com! -bar MarksDelete sil :delm! | :delm 0-9A-Z | :wv! | :DoShowMarks
nn <silent>[Mark]d :MarksDelete<CR>
" }}}
