if not vim.filetype then
  return
end

-- vim.g.did_load_filetypes = 0 -- deactivate vim based filetype detection
-- vim.g.do_filetype_lua = 1 -- enable lua ft detection
-- 
-- vim.filetype.add({
--   extension = {
--     -- yml = 'yaml',
--     docker = 'dockerfile',
--   },
--   filename = {
--     ['.gitignore'] = 'conf',
--     Podfile = 'ruby',
--     Brewfile = 'ruby',
--     Vagrantfile = 'ruby',
--   },
--   pattern = {
--     ['*.gradle'] = 'groovy',
--     ['*.env.*'] = 'env',
--   },
-- })
