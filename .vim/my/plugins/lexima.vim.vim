let g:lexima_no_default_rules = 0
let g:lexima_accept_pum_with_enter = 0
call lexima#set_default_rules()
inoremap <silent><expr> <CR> pum#visible() ? "\<Cmd>call pum#map#confirm()\<CR>" :
      \ "\<C-r>=lexima#expand('<LT>CR>', 'i')\<CR>"
