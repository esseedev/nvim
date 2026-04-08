return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      local function set_black_background()
        local groups = {
          'Normal',
          'NormalNC',
          'NormalFloat',
          'SignColumn',
          'EndOfBuffer',
          'TelescopeNormal',
          'TelescopeBorder',
          'TelescopePromptNormal',
          'TelescopePromptBorder',
          'TelescopeResultsNormal',
          'TelescopeResultsBorder',
          'TelescopePreviewNormal',
          'TelescopePreviewBorder',
        }

        for _, group in ipairs(groups) do
          vim.api.nvim_set_hl(0, group, { bg = '#000000' })
        end
      end

      require('rose-pine').setup {
        styles = {
          italic = false,
        },
      }

      vim.cmd.colorscheme 'rose-pine'

      set_black_background()
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = set_black_background,
      })
    end,
  },
}
