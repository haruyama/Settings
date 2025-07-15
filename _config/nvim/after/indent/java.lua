vim.fn.GetJavaIndent_improved = function()
  local theIndent = vim.fn.GetJavaIndent()
  local lnum = vim.fn.prevnonblank(vim.v.lnum - 1)
  local line = vim.fn.getline(lnum)
  if line:match('^%s*@.*$') then
    theIndent = vim.fn.indent(lnum)
  end
  return theIndent
end
vim.opt_local.indentexpr = 'v:lua.vim.fn.GetJavaIndent_improved()'
