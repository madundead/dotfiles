local M = {}

function M.config()
  require('nvim-treesitter.configs').setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { 'bash', 'c', 'cpp', 'c_sharp', 'clojure', 'cmake', 'comment', 'commonlisp',
      'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'go', 'html', 'http', 'java',
      'javascript', 'json', 'kotlin', 'latex', 'lua', 'make', 'markdown', 'perl', 'php',
      'python', 'ruby', 'rust', 'scss', 'swift', 'toml', 'tsx', 'vim', 'vue', 'yaml' },
    -- ignore_install = { 'norg' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = nil,
    },
    indent = { enable = false },
    autopairs = { enable = true },
    autotag = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { -- syntax-aware textobjects
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        disable = {},
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['aC'] = '@class.outer',
          ['iC'] = '@class.inner',
          ['ac'] = '@conditional.outer',
          ['ic'] = '@conditional.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['is'] = '@statement.inner',
          ['as'] = '@statement.outer',
          ['am'] = '@call.outer',
          ['im'] = '@call.inner',
          ['ad'] = '@comment.outer',
          ['id'] = '@comment.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
        },
      },
    }
  }
end

return M
