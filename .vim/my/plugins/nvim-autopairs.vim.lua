-- nvim-autopairs の設定
require('nvim-autopairs').setup({
    disable_filetype = {},
    disable_in_macro = false,
    disable_in_visualblock = false,
    ignored_next_char = [=[[%w%%%'%[%"%.]]=],
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    break_undo = true,
    check_ts = false,
    map_cr = false,  -- disabled
    map_bs = true,
    map_c_h = false,
    map_c_w = false
})

vim.api.nvim_set_keymap('i', '<CR>',
    [[pum#visible() ? pum#map#confirm() : v:lua.require('nvim-autopairs').autopairs_cr()]],
    {expr = true, noremap = true, silent = true}
)
