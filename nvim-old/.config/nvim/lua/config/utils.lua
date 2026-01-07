local function trim_trailing_whitespace()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[silent keepjumps keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
end
vim.api.nvim_create_user_command('TrimWhitespace', trim_trailing_whitespace, {})
