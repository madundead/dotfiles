local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = { lsp_zero.default_setup },
})

lspconfig.solargraph.setup({
  -- there's a very weird problem with mason-provided solargraph
  -- so instead I'm using the one from asdf
  cmd = { os.getenv( "HOME" ) .. "/.asdf/shims/solargraph", 'stdio' },
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true
    }
  }
})

lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

lsp_zero.setup()
