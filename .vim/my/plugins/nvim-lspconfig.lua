local opts = { noremap=true, silent=true }

-- https://dev.classmethod.jp/articles/eetann-change-neovim-lsp-diagnostics-format/
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  float = { border = "rounded" }
})

vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   },
-- }
--
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.updatetime = 100
vim.wo.signcolumn = "yes"

-- vim.lsp.set_log_level("debug")

-- local lspconfig = require'lspconfig'
-- lspconfig.denols.setup{capabilities = capabilities}
-- lspconfig.pyright.setup{capabilities = capabilities}
-- lspconfig.rls.setup{capabilities = capabilities}
-- lspconfig.solargraph.setup{capabilities = capabilities}
-- lspconfig.sorbet.setup{on_attach = on_attach, capabilities = capabilities}
-- lspconfig.vuels.setup{capabilities = capabilities}
-- lspconfig.zls.setup{capabilities = capabilities}
