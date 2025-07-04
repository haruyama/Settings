-- misc.vim
vim.api.nvim_set_keymap('c', '<C-p>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-n>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-]>', 'g<C-]>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-l>', ':nohlsearch<CR><C-l>', { noremap = true, silent = true })

-- Auto-create directory on save
local augroup = vim.api.nvim_create_augroup('vimrc_auto_mkdir', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    local force = vim.v.cmdbang
    if vim.fn.isdirectory(dir) == 0 then
      if force == 1 or vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir))
          :match('^[yY]') then
        vim.fn.mkdir(dir, 'p')
      end
    end
  end,
})

vim.g.eregex_default_enable = 0

vim.g.textobj_multiblock_blocks = {
  { '(', ')' },
  { '[', ']' },
  { '{', '}' },
}

vim.g.textobj_multitextobj_textobjects_i = {
  '<Plug>(textobj-multiblock-i)',
  'i"',
  "i'",
}

vim.g.textobj_multitextobj_textobjects_a = {
  '<Plug>(textobj-multiblock-a)',
  'a"',
  "a'",
}

vim.api.nvim_set_keymap('o', 'ib', '<Plug>(textobj-multitextobj-i)', { noremap = true })
vim.api.nvim_set_keymap('x', 'ib', '<Plug>(textobj-multitextobj-i)', { noremap = true })
vim.api.nvim_set_keymap('o', 'ab', '<Plug>(textobj-multitextobj-a)', { noremap = true })
vim.api.nvim_set_keymap('x', 'ab', '<Plug>(textobj-multitextobj-a)', { noremap = true })

local qf_augroup = vim.api.nvim_create_augroup('QuickFixCmd', { clear = true })
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = qf_augroup,
  pattern = 'make,*grep*',
  command = 'cwindow',
})

vim.cmd([[
  let &t_SI .= "\<Esc>[?2004h"
  let &t_EI .= "\<Esc>[?2004l"

  function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ''
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
]])