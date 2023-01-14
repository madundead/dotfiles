local M = {}

function M.config()
  vim.filetype.add({
    extension = {
      yml = 'yaml',
      docker = 'dockerfile',
    },
    filename = {
      ['.gitignore'] = 'conf',
      Podfile = 'ruby',
      Brewfile = 'ruby',
      Vagrantfile = 'ruby',
    },
    pattern = {
      ['*.gradle'] = 'groovy',
      ['*.env.*'] = 'env',
    },
  })
end

return M
