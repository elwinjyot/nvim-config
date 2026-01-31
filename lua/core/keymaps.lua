local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = true, silent = true }

-- save file without auto-formatting
keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- delete character without yanking
keymap.set("n", "x", '"_x', otps)

-- vertical scroll and center screen
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- find and center
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- resize buffers with arrow keys
keymap.set("n", "<Up>", ":resize -2<CR>", opts)
keymap.set("n", "<Down>", ":resize +2<CR>", opts)
keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffer
keymap.set("n", "<C-Tab>", ":bnext<CR>", opts)
keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap.set("n", "<leader>x", ":bdelete!<CR>", opts)
keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts)

-- Window management
keymap.set("n", "<leader>v", "<C-w>v", opts)
keymap.set("n", "<leader>h", "<C-w>s", opts)
keymap.set("n", "<leader>se", "<C-w>=", opts)
keymap.set("n", "<leader>xs", ":close<CR>", opts)

-- Window navigation
keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
-- keymap.set('n', '<leader>to', ':wincmd k<cr>', opts)
-- keymap.set('n', '<c-k>', ':wincmd k<cr>', opts)
-- keymap.set('n', '<c-k>', ':wincmd k<cr>', opts)
-- keymap.set('n', '<c-k>', ':wincmd k<cr>', opts)

-- stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when replacing
keymap.set("v", "p", '"_dP', opts)

-- Diagnostics
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic" })
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Press jk fast to exit insert mode
keymap.set("i", "jj", "<ESC>", opts)

-- Toggle line wrap
keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Clear search highlights
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Better paste (don't replace clipboard)
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Copy to system clipboard (normal mode)
keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

-- Copy to system clipboard (visual mode)
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- Paste from system clipboard (normal mode)
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard after cursor" })
keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard before cursor" })

-- Paste from system clipboard (visual mode - replaces selection)
keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Paste from system clipboard (insert mode)
keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

-- Delete to black hole register (doesn't affect clipboard)
keymap.set("v", "<leader>D", '"_d', { desc = "Delete without yanking" })

-- Copy entire file to clipboard
keymap.set("n", "<leader>ya", 'gg"+yG', { desc = "Copy entire file to system clipboard" })
