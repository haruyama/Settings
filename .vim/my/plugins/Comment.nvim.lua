require('Comment').setup({
    ignore = '^$',
})
vim.keymap.set('x', '<leader>x', '<Plug>(comment_toggle_linewise_visual)')
