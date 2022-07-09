require('plugins')

-- General settings
vim.o.background = 'dark'
vim.cmd('colorscheme pablo')
vim.cmd('highlight Normal ctermbg=NONE')
vim.cmd('highlight nonText ctermbg=NONE')
vim.opt.cmdheight = 2
vim.opt.synmaxcol = 256
vim.opt.list = true
vim.opt.listchars = {
  tab = '> ',
  eol = '¬',
  trail = '·',
}
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- autocmd - Strip whitespace on close.
function StripTrailingWhitespaces()
  local l = vim.fn.line('.')
  local c = vim.fn.col('.')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.cursor(l, c)
end
vim.cmd([[
let StripTrailingWhitespaces = luaeval('StripTrailingWhitespaces')
autocmd BufWritePre * call StripTrailingWhitespaces()
]])

-- plugin_config - lightline.vim
function CtClient()
  local pattern = os.getenv('GOOG') .. os.getenv('USER') .. '/(.*)/google3'
  local full_path = vim.fn.expand('%:p')
  local match = full_path:match(pattern)
  return match == null and '' or match
end

vim.cmd([[
let CtClient = luaeval('CtClient')
]])

vim.o.showmode = false
vim.g.lightline = {
  colorscheme = 'one',
  active = {
    left = {
      {'mode', 'paste'},
      {'ct', 'gitbranch', 'readonly', 'filename', 'modified'},
    },
  },
  component_function = {
    gitbranch = 'FugitiveHead',
    ct = 'CtClient',
  },
}
