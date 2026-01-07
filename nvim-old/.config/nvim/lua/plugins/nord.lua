return {
    'gbprod/nord.nvim', name = 'nord',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = false
        vim.g.nord_cursorline_transparent = false
        vim.g.nord_enable_sidebar_background = false
        vim.g.nord_italic = true
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = false
        vim.cmd [[colorscheme nord]]
    end
}
