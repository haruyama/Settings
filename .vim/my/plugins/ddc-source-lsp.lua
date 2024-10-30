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
-- https://zenn.dev/mochi/articles/e6b2735108157c
lspconfig.denols.setup({
    root_dir = lspconfig.util.root_pattern("deno.json"),
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
    capabilities = capabilities,
})
lspconfig.ts_ls.setup({
    root_dir = lspconfig.util.root_pattern("package.json"),
    capabilities = capabilities,
})
lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
}
lspconfig.clangd.setup{capabilities = capabilities}
lspconfig.intelephense.setup{capabilities = capabilities}
lspconfig.cmake.setup{capabilities = capabilities}
lspconfig.gopls.setup{
    capabilities = capabilities,
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
lspconfig.clojure_lsp.setup{capabilities = capabilities}
lspconfig.pyright.setup{capabilities = capabilities}
