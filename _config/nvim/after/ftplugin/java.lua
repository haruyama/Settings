vim.opt_local.include = [[^\s*import]]
vim.opt_local.includeexpr = [[substitute(substitute(v:fname,'\.','/','g'),';','','g')]]
vim.opt_local.path:append('src/main/java/**,src/test/java/**,src/java/**,src/test/**,src/core/**')

vim.g.java_highlight_all = 1
vim.g.java_highlight_functions = "style"
vim.g.java_highlight_debug = 1
vim.g.java_space_errors = 1
vim.g.java_allow_cpp_keywords = 1

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
