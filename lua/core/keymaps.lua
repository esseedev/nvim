vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

keymap.set('v', 'J', ":m '>+1<CR>gv=gv")                                             -- move highlighted line down
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")                                             -- move highlighted line up

keymap.set('n', 'J', 'mzJ`z')                                                        -- do not move cursor after appended line
keymap.set('n', '<C-d>', '<C-d>zz')                                                  -- cursor in the center of page after C-d, C-u
keymap.set('n', '<C-u>', '<C-u>zz')                                                  -- cursor in the center of page after C-d, C-u

keymap.set('n', 'n', 'nzzzv')                                                        -- when jumping after search, searched string is in the middle
keymap.set('n', 'N', 'Nzzzv')                                                        -- when jumping after search, searched string is in the middlkeymap.set("n", "<leader>nh", ":nohl<CR>") -- Clear search highlights
keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- change all occurences under cursor

keymap.set('x', '<leader>p', [["_dP"]])
keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
keymap.set('n', '<leader>fo', vim.lsp.buf.format)

keymap.set('n', '<leader>e', ':Explore<CR>') -- Go to explorer
-- Then use this stored variable for your mapping
keymap.set('n', '<leader>E', function()
    vim.cmd('Explore ' .. vim.fn.getcwd())
end)
keymap.set('n', '<leader>v', '<C-w>v')
keymap.set('n', '<leader>h', '<C-w>s')
keymap.set('n', '<leader>xs', ':close<CR>')
keymap.set('n', '<leader>nh', ':noh<CR>')

keymap.set('n', '<C-k>', ':wincmd k<CR>')
keymap.set('n', '<C-j>', ':wincmd j<CR>')
keymap.set('n', '<C-h>', ':wincmd h<CR>')
keymap.set('n', '<C-l>', ':wincmd l<CR>')

keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

keymap.set('n', '<F1>', vim.diagnostic.goto_next)
keymap.set('n', '<F2>', vim.diagnostic.goto_prev)

keymap.set('n', '<leader>pr', ':silent %!prettier %<CR>')
