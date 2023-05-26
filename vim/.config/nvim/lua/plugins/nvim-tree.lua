local M = {}

function M.config()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
      icons = {
        show = {
          file = false,
          folder = false,
          folder_arrow = false,
          git = false,
        }
      },
      group_empty = true,
    }
  })
end

return M
