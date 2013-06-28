function! SetSmartChr()

        function! CheckOperators()
                if search('^\%#', 'bcn') || index([' ', '+', '-',  '=', '*', '/', '%', "'", '"', '\', '<', '>'],  getline('.')[col('.')  -  2]) != -1
                        return 1
                end
                return 0
        endfunction

        " 演算子の間に空白を入れる
        inoremap <buffer><expr> = CheckOperators() ? smartchr#one_of('= ', '== ', '=== ', '=') : smartchr#one_of(' = ', ' == ', ' === ', '=')
        inoremap <buffer><expr> + CheckOperators() ? smartchr#one_of('+ ', '++', '+= ', '+') : smartchr#one_of(' + ', '++', ' += ', '+')
        inoremap <buffer><expr> - CheckOperators() ? smartchr#one_of('- ', '--', '-= ', '-') : smartchr#one_of(' - ', '--', ' -= ', '-')
        inoremap <buffer><expr> < CheckOperators() ? smartchr#one_of('< ', '<= ',  '<') : smartchr#one_of(' < ', ' <= ', '<')
        inoremap <buffer><expr> > CheckOperators() ? smartchr#one_of('> ', '>=', '>') : smartchr#one_of(' > ', ' >=',  '>')

        inoremap <buffer><expr> , smartchr#one_of(', ', ',')

        " if文直後の(は自動で間に空白を入れる
        function! CheckCondtionKeywords()
                for keyword in ['for', 'if', 'foreach']
                        if search('\<' . keyword . '\%#', 'bcn')
                                return 1
                        endif
                endfor
                return 0
        endfunction

        "inoremap <buffer><expr> ( search('\<\for\%#', 'bcn') ? ' (': '('
        inoremap <buffer><expr> ( CheckCondtionKeywords() ? ' (': '('
endfunction
