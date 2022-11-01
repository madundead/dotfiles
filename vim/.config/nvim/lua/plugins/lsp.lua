require("mason-lspconfig").setup()
local lspconfig = require('lspconfig')
lspconfig.ansiblels.setup({})
lspconfig.bashls.setup({})
lspconfig.dockerls.setup({})
lspconfig.gopls.setup({})
lspconfig.jsonls.setup({})
lspconfig.solargraph.setup({})
lspconfig.marksman.setup({})
lspconfig.terraformls.setup({})
lspconfig.vimls.setup({})
lspconfig.pylsp.setup({})
lspconfig.yamlls.setup({})

-- Provide settings that should only apply to the "sumneko_lua" server
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, "lua/?.lua")
table.insert(lua_runtime_path, "lua/?/init.lua")
table.insert(lua_runtime_path, vim.fn.stdpath('config') .. "lua/?.lua")

lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = lua_runtime_path,
      },
      format = {
        enable = true,
        defaultConfig = {
          keep_one_space_between_table_and_bracket = "false",
        }
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
        ["codestyle-check"] = "Any",
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
})
