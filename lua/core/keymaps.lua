vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move highlighted line down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move highlighted line up 

keymap.set("n", "J", "mzJ`z") -- do not move cursor after appended line 
keymap.set("n", "<C-d>", "<C-d>zz") -- cursor in the center of page after C-d, C-u
keymap.set("n", "<C-u>", "<C-u>zz") -- cursor in the center of page after C-d, C-u

keymap.set("n", "n", "nzzzv") -- when jumping after search, searched string is in the middle
keymap.set("n", "N", "Nzzzv") -- when jumping after search, searched string is in the middlkeymap.set("n", "<leader>nh", ":nohl<CR>") -- Clear search highlights
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- change all occurences under cursor
keymap.set("n", "<leader>e", ":Explore<CR>") -- Go to explorere

keymap.set("n", "<leader>v", "<C-w>v", opts) 
keymap.set("n", "<leader>h", "<C-w>s", opts) 
keymap.set("n", "<leader>xs", ":close<CR>", opts) 
keymap.set("n", "<leader>nh", ":noh<CR>", opts)

keymap.set("n", "<C-k>", ":wincmd k<CR>", opts) 
keymap.set("n", "<C-j>", ":wincmd j<CR>", opts) 
keymap.set("n", "<C-h>", ":wincmd h<CR>", opts) 
keymap.set("n", "<C-l>", ":wincmd l<CR>", opts) 

keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)
