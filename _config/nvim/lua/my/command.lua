-- ~/.vim/my/command.vim converted to Lua

-- Define a command to trim trailing whitespace
local function rtrim()
  local current_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, current_pos)
end
vim.api.nvim_create_user_command('RTrim', rtrim, {})

-- Define commands to edit files with specific encodings
vim.api.nvim_create_user_command('Cp932', 'edit ++enc=cp932', { nargs = '?' })
vim.api.nvim_create_user_command('Eucjp', 'edit ++enc=euc-jp', { nargs = '?' })
vim.api.nvim_create_user_command('Iso2022jp', 'edit ++enc=iso-2202-jp', { nargs = '?' })
vim.api.nvim_create_user_command('Utf8', 'edit ++enc=utf-8', { nargs = '?' })
vim.api.nvim_create_user_command('Jis', 'Iso2022jp', { nargs = '?' })
vim.api.nvim_create_user_command('Sjis', 'edit ++enc=cp932', { nargs = '?' })

-- Define a command to change directory to the current file's directory
vim.api.nvim_create_user_command('CdCurrent', 'cd %:p:h', {})

-- Define a command to reload the vimrc
vim.api.nvim_create_user_command('ReloadVimrc', 'source $MYVIMRC', {})


-- Autocommand to store the job ID of the last opened terminal
local term_augroup = vim.api.nvim_create_augroup('TerminalREPL', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = term_augroup,
  callback = function()
    vim.g.last_terminal_job_id = vim.b.terminal_job_id
  end,
})

-- Function to send text to the last opened terminal
-- It handles both single lines (in normal mode) and ranges (in visual mode)
local function repl_send(opts)
  local text
  local next_line

  if opts.range == 0 then
    -- No range was provided, so we send the current line.
    text = vim.fn.getline(opts.line1) .. '\n'
    next_line = opts.line1 + 1
  else
    -- A range was provided (e.g., from a visual selection).
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    text = table.concat(lines, '\n') .. '\n'
    next_line = opts.line2 + 1
  end

  if vim.g.last_terminal_job_id and vim.fn.chansend(vim.g.last_terminal_job_id, text) == 0 then
    -- Move cursor to the line after the sent text
    vim.api.nvim_win_set_cursor(0, { next_line, 0 })
  else
    vim.notify("No active terminal job found or channel is closed.", vim.log.levels.WARN)
  end
end

-- Create a user command that can be called with or without a range.
vim.api.nvim_create_user_command('REPLSendLine', repl_send, { range = true })

-- In visual mode, pressing <CR> will send the selection to the REPL.
vim.keymap.set('x', '<CR>', ':<C-u>REPLSendLine<CR>', { silent = true, noremap = true })
