require 'core.keymaps'
require 'core.options'
require 'core.filetypes'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    if vim.hl and vim.hl.on_yank then
      vim.hl.on_yank()
      return
    end
    vim.highlight.on_yank()
  end,
})

require('lazy').setup({
  require 'plugins.colorscheme',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.roslyn',
  require 'plugins.indent-blankline',
  require 'plugins.misc',
  require 'plugins.nvim-tmux-navigator',
  require 'plugins.nvim-ts-autotag',
  require 'plugins.trouble',
  require 'plugins.harpoon',
}, {
  rocks = {
    enabled = false,
  },
})
