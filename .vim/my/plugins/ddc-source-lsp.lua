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

lspconfig('*', {
    root_markers = { "package.json"},
})

-- https://zenn.dev/mochi/articles/e6b2735108157c
lspconfig('denols',{
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
    root_markers = { "deno.json" },
})
vim.lsp.enable('denols')
lspconfig('ts_ls', {
    root_markers = { "package.json" },
})
vim.lsp.enable('ts_ls')
lspconfig('rust_analyzer', {
    root_markers = { "Cargo.toml" },
})
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')
lspconfig('intelephense', {
    root_markers = { "composer.json" },
})
vim.lsp.enable('intelephense')
lspconfig('cmake', {
    root_markers = { "CMakeLists.txt" },
})
vim.lsp.enable('cmake')
lspconfig('gopls',{
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
vim.lsp.enable('gopls')
vim.lsp.enable('clojure_lsp')
vim.lsp.enable('pyright')
vim.lsp.enable('terraformls')
vim.lsp.enable('zls')
vim.lsp.enable('idris2_lsp')
