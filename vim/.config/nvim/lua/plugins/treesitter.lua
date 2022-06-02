-- Tree-sitter
require('nvim-treesitter.configs').setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { 'bash', 'c', 'cpp', 'c_sharp', 'clojure', 'cmake', 'comment', 'commonlisp',
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'go', 'html', 'http', 'java',
    'javascript', 'json', 'kotlin', 'latex', 'lua', 'make', 'markdown', 'perl', 'php',
    'python', 'ruby', 'rust', 'scss', 'swift', 'toml', 'tsx', 'vim', 'vue', 'yaml' },
  -- ignore_install = { 'norg' },
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
}
