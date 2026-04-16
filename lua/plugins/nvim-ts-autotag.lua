return {
    'windwp/nvim-ts-autotag',
    config = function()
        require('nvim-ts-autotag').setup {
            aliases = {
                razor = 'html',
                cshtml = 'html',
            },
            per_filetype = {
                razor = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false,
                },
                cshtml = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false,
                },
            },
        }
    end,
}
