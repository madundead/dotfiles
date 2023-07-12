local M = {}

function M.setup()
  vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true }) end)
  vim.keymap.set('n', '<leader>fo', function() require('telescope.builtin').find_files({ cwd = '~/Syncthing/Obsidian/Personal/', search_file = '*.md' }) end)
  vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end)
  -- require('telescope.builtin').find_files({ hidden = true })
end

function M.config()
    local telescope = require 'telescope'

    telescope.setup {
        defaults = {
            layout_strategy = 'vertical',
            winblend = 7,
            set_env = { COLORTERM = 'truecolor' },
            color_devicons = true,
            scroll_strategy = 'limit',
        },
        pickers = {
            live_grep = {
                only_sort_text = true,
                path_display = { 'shorten' },
                layout_strategy = 'horizontal',
                layout_config = { preview_width = 0.4 },
            },
            git_files = {
                path_display = {},
                hidden = true,
                show_untracked = true,
                layout_strategy = 'horizontal',
                layout_config = { preview_width = 0.65 },
            },
        },
        extensions = {
            fzf = {
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
        },
    }

    -- pcall(require('telescope').load_extension, 'fzf')
    -- Enable telescope fzf native, if installed
    telescope.load_extension('fzf')
end

-- Telescope
-- TODO: change to Telescope
-- nmap('<leader>ft', ':Files ~/Tmp<CR>')
-- nmap('<leader>fo', ":call fzf#run(fzf#wrap(fzf#vim#with_preview({ 'source': 'fd . --type f --extension=md --follow --exclude .git ~/Syncthing/Obsidian/Personal' })))<CR>", { silent = true })

return M
