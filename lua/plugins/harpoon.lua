return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        menu = {
            width = 60,
            height = 10,
        },
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
            key = function()
                return vim.loop.cwd()
            end,
        },
    },
    config = function(_, opts)
        local harpoon = require 'harpoon'
        harpoon:setup(opts)

        -- Set up keymaps
        local keymap = vim.keymap.set
        keymap('n', '<leader>a', function()
            harpoon:list():add()
        end)
        keymap('n', '<C-e>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- Navigation using leader + number
        keymap('n', '<leader>1', function()
            harpoon:list():select(1)
        end)
        keymap('n', '<leader>2', function()
            harpoon:list():select(2)
        end)
        keymap('n', '<leader>3', function()
            harpoon:list():select(3)
        end)
        keymap('n', '<leader>4', function()
            harpoon:list():select(4)
        end)

        -- Clear the entire Harpoon list
        keymap('n', '<leader>hc', function()
            harpoon:list():clear()
            print 'Cleared all files from Harpoon list'
        end)
    end,
}
