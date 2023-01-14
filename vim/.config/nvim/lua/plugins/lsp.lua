-- local M = {}
--
-- function M.config()
--   local lspconfig = require('lspconfig')
--
--   lspconfig.ansiblels.setup({})
--   lspconfig.bashls.setup({})
--   lspconfig.dockerls.setup({})
--   lspconfig.gopls.setup({})
--   lspconfig.jsonls.setup({})
--   lspconfig.solargraph.setup({})
--
-- -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- require('lspconfig')['solargraph'].setup({ capabilities = capabilities })
--
--   lspconfig.marksman.setup({})
--   lspconfig.terraformls.setup({})
--   lspconfig.vimls.setup({})
--   lspconfig.pylsp.setup({})
--   lspconfig.yamlls.setup({
--     settings = {
--       yaml = {
--         format = {
--           enable = true,
--           singleQuote = true
--         }
--       }
--     }
--   })
--
--   require("mason").setup({})
--   require("mason-lspconfig").setup()
--   require("mason-tool-installer").setup({
--     -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
--     ensure_installed = { "bash-language-server", "black", "dockerfile-language-server",
--       "isort", "json-lsp", "jsonlint", "lua-language-server", "marksman", "prettierd",
--       "python-lsp-server", "rubocop", "shfmt", "solargraph", "terraform-ls",
--       "vim-language-server", "yaml-language-server",
--     },
--     auto_update = true,
--     run_on_start = true
--   })
--
--   -- Provide settings that should only apply to the "sumneko_lua" server
--   local lua_runtime_path = vim.split(package.path, ';')
--   table.insert(lua_runtime_path, "lua/?.lua")
--   table.insert(lua_runtime_path, "lua/?/init.lua")
--   table.insert(lua_runtime_path, vim.fn.stdpath('config') .. "lua/?.lua")
--
--   lspconfig.sumneko_lua.setup({
--     settings = {
--       Lua = {
--         runtime = {
--           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--           version = 'LuaJIT',
--           -- Setup your lua path
--           path = lua_runtime_path,
--         },
--         format = {
--           enable = true,
--           defaultConfig = {
--             keep_one_space_between_table_and_bracket = "false",
--           }
--         },
--         diagnostics = {
--           -- Get the language server to recognize the `vim` global
--           globals = {'vim'},
--           ["codestyle-check"] = "Any",
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--           enable = false,
--         },
--       },
--     }
--   })
-- end



local lsp = require('lsp-zero')

-- lsp.preset('recommended')
lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.setup()

-- should be after setup
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

