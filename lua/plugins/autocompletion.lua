return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
    },
    config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local s = luasnip.snippet
        local i = luasnip.insert_node
        local f = luasnip.function_node
        local fmt = require('luasnip.extras.fmt').fmt
        luasnip.config.setup {}

        local function to_pascal_case(value)
            local parts = vim.split(value or '', '[^%a%d]+', { trimempty = true })
            for index, part in ipairs(parts) do
                parts[index] = part:sub(1, 1):upper() .. part:sub(2)
            end
            return table.concat(parts)
        end

        local function project_namespace_fallback()
            local override = vim.g.cs_root_namespace
            if type(override) == 'string' and override ~= '' then
                return override
            end

            local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
            return to_pascal_case(cwd_name)
        end

        local function namespace_for_current_file()
            local override = vim.g.cs_root_namespace
            local file_dir = vim.fn.expand '%:p:h'

            local csproj = vim.fs.find(function(name)
                return name:match '%.csproj$' ~= nil
            end, { path = file_dir, upward = true, type = 'file' })[1]

            local root_namespace
            local project_dir

            if csproj then
                project_dir = vim.fs.dirname(csproj)
                root_namespace = vim.fn.fnamemodify(csproj, ':t:r')
            else
                project_dir = vim.fn.getcwd()
                root_namespace = project_namespace_fallback()
            end

            if type(override) == 'string' and override ~= '' then
                root_namespace = override
            end

            if not vim.startswith(file_dir, project_dir) then
                return root_namespace
            end

            local relative_dir = file_dir:gsub('^' .. vim.pesc(project_dir) .. '/?', '')
            if relative_dir == '' or relative_dir == '.' then
                return root_namespace
            end

            local parts = vim.split(relative_dir, '[/\\]+', { trimempty = true })
            if #parts > 0 and parts[1]:lower() == 'src' then
                table.remove(parts, 1)
            end

            if #parts == 0 then
                return root_namespace
            end

            for index, part in ipairs(parts) do
                parts[index] = to_pascal_case(part)
            end

            return root_namespace .. '.' .. table.concat(parts, '.')
        end

        luasnip.add_snippets('cs', {
            s(
                'csclass',
                fmt(
                    [[
namespace {};

public class {}
{{
    {}
}}
]],
                    {
                        f(function()
                            return namespace_for_current_file()
                        end, {}),
                        f(function()
                            local class_name = vim.fn.expand '%:t:r'
                            if class_name == '' then
                                return 'Solution'
                            end
                            return to_pascal_case(class_name)
                        end, {}),
                        i(0),
                    }
                )
            ),
            s(
                'prop',
                fmt('public {} {} {{ get; set; }}', {
                    i(1, 'string'),
                    i(2, 'Name'),
                })
            ),
        })

        local kind_icons = {
            Text = '󰉿',
            Method = 'm',
            Function = '󰊕',
            Constructor = '',
            Field = '',
            Variable = '󰆧',
            Class = '󰌗',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Snippet = '',
            Color = '󰏘',
            File = '󰈙',
            Reference = '',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰇽',
            Struct = '',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '󰊄',
        }

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert {
                -- Select the [n]ext item
                ['<C-n>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ['<CR>'] = cmp.mapping.confirm { select = true },

                -- If you prefer more traditional completion keymaps,
                -- you can uncomment the following lines
                --['<CR>'] = cmp.mapping.confirm { select = true },
                --['<Tab>'] = cmp.mapping.select_next_item(),
                --['<S-Tab>'] = cmp.mapping.select_prev_item(),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ['<C-Space>'] = cmp.mapping.complete {},

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            sources = {
                {
                    name = 'lazydev',
                    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                    group_index = 0,
                },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snippet]',
                        buffer = '[Buffer]',
                        path = '[Path]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
        }
    end,
}
