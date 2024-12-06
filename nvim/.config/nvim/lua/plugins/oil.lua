return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      -- prompt_save_on_select_new_entry = true,
      skip_confirm_for_simple_edits = true,
      default_file_explorer = false, -- so `gx` and `:GBrowse` works
      use_default_keymap = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = false,
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = false,
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
      }
    })
  end
}
