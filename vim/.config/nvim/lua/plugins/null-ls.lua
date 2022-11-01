local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.jq,
    require("null-ls").builtins.formatting.gofmt,
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.formatting.terraform_fmt,
    require("null-ls").builtins.diagnostics.jsonlint,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            async = false,
            filter = function(client)
              return client.name == "null-ls"
            end
          })
        end,
      })
    end
  end,
})
