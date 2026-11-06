return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      local function set_window_colors()
        local groups = {
          'Normal',
          'NormalNC',
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

        local popup_bg = '#16181d'
        local popup_fg = '#e0def4'
        local border_fg = '#7aa2f7'
        vim.api.nvim_set_hl(0, 'NormalFloat', { fg = popup_fg, bg = popup_bg })
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = border_fg, bg = popup_bg })
        vim.api.nvim_set_hl(0, 'FloatTitle', { fg = border_fg, bg = popup_bg, bold = true })
        vim.api.nvim_set_hl(0, 'Pmenu', { fg = popup_fg, bg = popup_bg })
        vim.api.nvim_set_hl(0, 'PmenuSel', { fg = '#ffffff', bg = '#3b5070', bold = true })
        vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#343844' })
        vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = border_fg })
      end

      require('rose-pine').setup {
        styles = {
          italic = false,
        },
      }

      vim.cmd.colorscheme 'rose-pine'

      set_window_colors()
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = set_window_colors,
      })
    end,
  },
}
