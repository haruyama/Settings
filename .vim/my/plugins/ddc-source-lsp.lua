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

local lspconfig = vim.lsp.config

-- https://zenn.dev/catatsumuri/articles/beb6595d295906
local on_attach = function(client, bufnr)
    -- キーマッピングでシグネチャヘルプを呼び出す
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })

    if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

-- https://zenn.dev/mochi/articles/e6b2735108157c
lspconfig('denols',{
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
    root_markers = { "deno.json"},
})
lspconfig('ts_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_markers = { "package.json"},
})
lspconfig('rust_analyzer', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_markers = { "Cargo.toml" },
})
lspconfig('clangd', {capabilities = capabilities})
lspconfig('intelephense', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_markers = { "composer.json" },
})
lspconfig('cmake', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_markers = { "CMakeLists.txt" },
})
lspconfig('gopls',{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = false,
                shadow = false,
                modernize = true,
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
    root_markers = { "go.mod" },
})
lspconfig('clojure_lsp', {
    capabilities = capabilities,
    on_attach = on_attach,
})
lspconfig('pyright', {
    capabilities = capabilities,
    on_attach = on_attach,
})
lspconfig('terraformls', {
    capabilities = capabilities,
    on_attach = on_attach,
})
lspconfig('zls', {
    capabilities = capabilities,
    on_attach = on_attach,
})
