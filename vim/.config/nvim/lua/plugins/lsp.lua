local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'ruby_ls' },
  handlers = { lsp_zero.default_setup },
})

-- lspconfig.solargraph.setup({
--   -- there's a very weird problem with mason-provided solargraph
--   -- so instead I'm using the one from asdf
--   cmd = { os.getenv( "HOME" ) .. "/.asdf/shims/solargraph", 'stdio' },
--   settings = {
--     solargraph = {
--       autoformat = true,
--       completion = true,
--       diagnostic = true,
--       folding = true,
--       references = true,
--       rename = true,
--       symbols = true
--     }
--   }
-- })

lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

-- See https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#neovim-lsp
-- textDocument/diagnostic support until 0.10.0 is released
-- IMPORTANT: look into how much resources ruby-lsp consumes
local _timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      if not result then
        return
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

-- trying out ruby-lsp from Shopify
-- maybe will replace solargraph
lspconfig.ruby_ls.setup({
  cmd = { os.getenv( "HOME" ) .. "/.asdf/shims/ruby-lsp", 'stdio' },
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end,
})

lsp_zero.setup()
