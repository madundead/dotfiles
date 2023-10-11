local cmd, opt, g = vim.cmd, vim.opt, vim.g

cmd('au TextYankPost * lua vim.highlight.on_yank { timeout = 250 }')

opt.smartindent   = true            -- Autoindenting when starting a new line
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.tabstop       = 2               -- Tab counts as 2 columns
opt.shiftwidth    = 2               -- Numbers of spaces to (auto)indent
opt.expandtab     = true            -- Tabs to spaces
opt.clipboard     = 'unnamedplus'   -- Share clipboard with the OS
opt.number        = true            -- Display line numbers
opt.synmaxcol     = 500             -- Do not try to highlight lines longer than 500 characters
opt.lazyredraw    = true            -- Do not redraw while running macros
opt.showmatch     = true            -- Show matching braces
opt.matchtime     = 2               -- Show matching braces for 2 tenths of second
opt.showmode      = true            -- Shows when you are in insert mode
opt.title         = true            -- Show title in console status bar
opt.laststatus    = 3               -- Single status line
opt.wrap          = false           -- Dont wrap lines
opt.scrolloff     = 5               -- Keep 5 rows on the screen when scrolling
opt.sidescrolloff = 15              -- Horizontal scrolloff
opt.visualbell    = false           -- No visual bell
opt.backup        = false           -- No backups
opt.writebackup   = false           -- No backups
opt.swapfile      = false           -- No backups
opt.mouse         = 'a'             -- Support mouse (for proper mouse highlight)
opt.list          = true            -- List mode
opt.timeoutlen    = 1000            -- Delay for mappings
opt.ttimeoutlen   = 0               -- Delay between modes
opt.termguicolors = true            -- 24-bit RGB color

opt.listchars = {
  nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  -- tab = '  ', -- '▷─' WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
  space = ' ',
  tab = '<->'
}

opt.fillchars = {
  diff = '⣿',
  eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  vert = '│', -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
  msgsep = '‾',
  fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸'
}

-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
opt.diffopt = vim.opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
  }

opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  I = true, -- disable welcome message (:intro)
  a = true, -- shortmess for everything
  c = true,
  W = true, -- Don't show [w] or written when writing
}

if vim.fn.executable('rg') > 0 then
  vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
end

-- ignore when autocompleting
opt.wildignore = {
  '*.aux', '*.out', '*.toc', '*.o', '*.obj',
  '*.dll', '*.jar', '*.pyc', '*.rbc', '*.class',
  '*.gif', '*.ico', '*.jpg', '*.jpeg', '*.png',
  '*.avi', '*.wav', '*.*~', '*~ ', '*.swp',
  '.lock', '.DS_Store', 'tags.lock'
}

-- CtrlSF
g.ctrlsf_ackprg         = 'rg'
g.ctrlsf_regex_pattern  = 1
g.ctrlsf_case_sensitive = 'smart'
g.ctrlsf_default_root   = 'project'
g.ctrlsf_context        = '-B 1 -A 1'
g.ctrlsf_position       = 'bottom'
g.ctrlsf_winsize        = '40%'
g.ctrlsf_mapping        = {
  next = 'n',
  prev = 'N',
}

g.ruby_host_prog = 'asdf exec neovim-ruby-host'
