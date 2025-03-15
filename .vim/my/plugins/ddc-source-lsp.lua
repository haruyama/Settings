local capabilities = require('ddc_source_lsp').make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

local lspconfig = require('lspconfig')

-- https://zenn.dev/catatsumuri/articles/beb6595d295906
local on_attach = function(client, bufnr)
    -- キーマッピングでシグネチャヘルプを呼び出す
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })

    if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

-- https://zenn.dev/mochi/articles/e6b2735108157c
lspconfig.denols.setup({
    capabilities = capabilities,
    init_options = {
        lint = true,
        unstable = true,
        suggest = {
            imports = {
                hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true,
                },
            },
        },
    },
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json"),
})
lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("package.json"),
})
lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("Cargo.toml"),
}
lspconfig.clangd.setup{capabilities = capabilities}
lspconfig.intelephense.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("composer.json", ".git", "."),
}
lspconfig.cmake.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git", "."),
}
lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = false,
                shadow = false,
            },
            staticcheck = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
lspconfig.clojure_lsp.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.zls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
