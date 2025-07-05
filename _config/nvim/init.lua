-- Neovim configuration in Lua
-- Generated from init.vim

-- Disable diagnostics for undefined globals, common in Neovim configs
---@diagnostic disable: undefined-global

-- Enable the Lua loader for faster startup
vim.loader.enable()

-- Helper function to source vimscript files
local function source_vim(file)
  local path = vim.fn.expand(file)
  if vim.fn.filereadable(path) == 1 then
    vim.cmd('source ' .. path)
  else
    print("Error: Could not source file " .. path)
  end
end

-- Source all the existing vimscript configuration files
require('my.basic')
-- source_vim('$HOME/.vim/my/basic.vim')
require('my.command')
-- source_vim('$HOME/.vim/my/command.vim')
require('my.misc')
source_vim('$HOME/.vim/my/tab.vim')
source_vim('$HOME/.vim/my/jetpack.vim')

-- Equivalent of: if has('vim_starting') && !empty(argv())
if vim.fn.has('vim_starting') == 1 and not vim.tbl_isempty(vim.fn.argv()) then
  -- Equivalent of: if execute('filetype') =~# 'OFF'
  if string.find(vim.fn.execute('filetype'), 'OFF') then
    -- Lazy loading
    vim.cmd('silent! filetype plugin indent on')
    vim.cmd('syntax enable')
    vim.cmd('filetype detect')
  end
end

-- Equivalent of: if filereadable(expand('~/.vimrc.local'))
local local_vimrc = vim.fn.expand('~/.vimrc.local')
if vim.fn.filereadable(local_vimrc) == 1 then
  source_vim(local_vimrc)
end

-- Neovim specific settings
-- Equivalent of: if has('nvim')
if vim.fn.has('nvim') == 1 then
  vim.o.mouse = '' -- set mouse=
end

-- Equivalent of: call setcellwidths(...)
vim.fn.setcellwidths({
  {0x2500, 0x25ff, 1},
  {0xE0B0, 0xE0B3, 1},
})
