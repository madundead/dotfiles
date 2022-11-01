require("mason").setup({})
require("mason-tool-installer").setup({
  -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  ensure_installed = { "bash-language-server", "black", "dockerfile-language-server",
    "isort", "json-lsp", "jsonlint", "lua-language-server", "marksman", "prettierd",
    "python-lsp-server", "rubocop", "shfmt", "solargraph", "terraform-ls",
    "vim-language-server", "yaml-language-server",
  },
  auto_update = true,
  run_on_start = true
})