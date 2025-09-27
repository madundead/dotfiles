local au = vim.api.nvim_create_augroup('LspAttach', { clear = true })

return {
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        opts = {
            ensure_installed = {},
            registries = {
                'github:mason-org/mason-registry',
            },
        },
        config = function(_, opts)
            require('mason').setup(opts)

            local registry = require 'mason-registry'
            registry:on('package:install:success', function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require('lazy.core.handler.event').trigger {
                        event = 'FileType',
                        buf = vim.api.nvim_get_current_buf(),
                    }
                end, 100)
            end)

            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local package = registry.get_package(tool)
                    if not package:is_installed() then
                        package:install()
                    end
                end
            end

            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPost', 'BufNewFile' },
        init = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = au,
                desc = 'LSP keymaps',
                callback = function(args)
                    local bufnr = args.buf
                    local function map(mode, lhs, rhs)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
                    end

                    map('n', 'gD', vim.lsp.buf.declaration)
                    map('n', 'gd', vim.lsp.buf.definition)
                    map('n', 'K', vim.lsp.buf.hover)
                    map('n', 'gi', vim.lsp.buf.implementation)
                    -- map({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help)
                    -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
                    -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
                    -- map('n', '<leader>wl', function()
                    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    -- end)
                    map('n', '<leader>D', vim.lsp.buf.type_definition)
                    -- map('n', '<leader>r', function()
                    --     require('conf.nui_lsp').lsp_rename()
                    -- end)
                    map('n', 'gr', function()
                        require('trouble').open { mode = 'lsp_references' }
                    end)
                    map('n', '<leader>li', vim.lsp.buf.incoming_calls)
                    map('n', '<leader>lo', vim.lsp.buf.outgoing_calls)
                    -- vim.opt.shortmess:append 'c'
                end,
            })


            vim.api.nvim_create_autocmd('LspAttach', {
                group = au,
                desc = 'LSP inlay hints',
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if
                        client
                        and client.supports_method 'textDocument/inlayHint'
                        and pcall(require, 'vim.lsp.inlay_hint') -- NOTE: check that API exists
                    then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = au,
                desc = 'LSP code actions',
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if
                        client
                        and client.supports_method 'textDocument/codeAction'
                    then
                        vim.keymap.set(
                            { 'n', 'v' },
                            '<leader>ca',
                            vim.lsp.buf.code_action,
                            { buffer = bufnr }
                        )
                    end
                end,
            })
        end,
        dependencies = {
            -- {
            --     'folke/neoconf.nvim',
            --     cmd = 'Neoconf',
            --     config = false,
            --     dependencies = { 'nvim-lspconfig' },
            -- },
            -- { 'folke/neodev.nvim', opts = {} },
            'hrsh7th/cmp-nvim-lsp',
            'mason.nvim',
            {
                'williamboman/mason-lspconfig.nvim',
                opts = {
                    ensure_installed = {
                        'lua_ls',
                        -- 'dockerls',
                        -- 'docker_compose_language_service',
                        -- 'yamlls',
                        -- 'jsonls',
                        -- 'html',
                        -- 'cssls',
                        -- 'gopls',
                        'clangd',
                        'texlab',
                        -- 'ts_ls',
                        -- 'vtsls',
                        'terraformls',
                        'helm_ls',
                        -- 'bashls'
                    },
                    handlers = {
                        function(server_name)
                            require('lspconfig')[server_name].setup {}
                        end,
                        ['yamlls'] = function()
                            require('lspconfig').yamlls.setup {
                                single_file_support = true,
                                filetypes = {
                                    'yaml',
                                    'yaml.gha',
                                },
                                root_dir = function(filename)
                                    return require('lspconfig.util').find_git_ancestor(
                                        filename
                                    ) or vim.uv.cwd()
                                end,
                                settings = {
                                    yaml = {
                                        editor = { formatOnType = true },
                                        schemas = {
                                            -- GitHub CI workflows
                                            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
                                            -- Helm charts
                                            ['https://json.schemastore.org/chart.json'] = '/templates/*',
                                        },
                                        customTags = {
                                            -- mkdocs
                                            'tag:yaml.org,2002:python/name:material.extensions.emoji.twemoji',
                                            'tag:yaml.org,2002:python/name:material.extensions.emoji.to_svg',
                                            'tag:yaml.org,2002:python/name:pymdownx.superfences.fence_code_format',
                                        },
                                    },
                                },
                            }
                            require('lspconfig').yamlls.setup {
                                name = 'yamlls GitLab',
                                filetypes = { 'yaml.gitlab' },
                                settings = {
                                    yaml = {
                                        customTags = {
                                            '!reference sequence',
                                            '!reference scalar',
                                        },
                                    },
                                },
                            }
                        end,
                        ['dockerls'] = function()
                            require('lspconfig').dockerls.setup {
                                settings = {
                                    docker = {
                                        languageserver = {
                                            formatter = {
                                                ignoreMultilineInstructions = true,
                                            },
                                        },
                                    },
                                },
                            }
                        end,
                        ['jsonls'] = function()
                            require('lspconfig').jsonls.setup {
                                filetypes = { 'json', 'jsonc' },
                                settings = {
                                    json = {
                                        schemas = {
                                            {
                                                fileMatch = { 'package.json' },
                                                url = 'https://json.schemastore.org/package.json',
                                            },
                                            {
                                                fileMatch = { 'tsconfig*.json' },
                                                url = 'https://json.schemastore.org/tsconfig.json',
                                            },
                                            {
                                                fileMatch = {
                                                    '.prettierrc',
                                                    '.prettierrc.json',
                                                    'prettier.config.json',
                                                },
                                                url = 'https://json.schemastore.org/prettierrc.json',
                                            },
                                            {
                                                fileMatch = {
                                                    '.eslintrc',
                                                    '.eslintrc.json',
                                                },
                                                url = 'https://json.schemastore.org/eslintrc.json',
                                            },
                                            {
                                                fileMatch = {
                                                    '.stylelintrc',
                                                    '.stylelintrc.json',
                                                    'stylelint.config.json',
                                                },
                                                url = 'http://json.schemastore.org/stylelintrc.json',
                                            },
                                        },
                                    },
                                },
                            }
                        end,
                        ['html'] = function()
                            require('lspconfig').html.setup {
                                settings = {
                                    html = {
                                        format = {
                                            templating = true,
                                            wrapLineLength = 120,
                                            wrapAttributes = 'auto',
                                        },
                                        hover = {
                                            documentation = true,
                                            references = true,
                                        },
                                    },
                                },
                            }
                        end,
                        ['tsserver'] = function()
                            require('lspconfig').tsserver.setup {
                                autostart = false,
                                root_dir = require('lspconfig.util').root_pattern 'package.json',
                                commands = {
                                    OrganizeImports = {
                                        function()
                                            local params = {
                                                command = '_typescript.organizeImports',
                                                arguments = {
                                                    vim.api.nvim_buf_get_name(
                                                        0
                                                    ),
                                                },
                                                title = '',
                                            }
                                            vim.lsp.buf.execute_command(params)
                                        end,
                                    },
                                },
                            }
                        end,
                        ['lua_ls'] = function()
                            require('lspconfig').lua_ls.setup {
                                settings = {
                                    Lua = {
                                        completion = {
                                            callSnippet = 'Replace',
                                        },
                                        workspace = { checkThirdParty = false },
                                        telemetry = { enable = false },
                                        diagnostics = {
                                            unusedLocalExclude = { '_*' },
                                            globals = { 'vim' }
                                        },
                                        format = { enable = false },
                                        hint = {
                                            enable = true,
                                            arrayIndex = 'Disable',
                                        },
                                    },
                                },
                            }
                        end,
                    },
                },
            },
        },
    },
}
