return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
}
