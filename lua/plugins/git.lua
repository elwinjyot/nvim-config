local function is_blame_open()
	local wins = vim.api.nvim_tabpage_list_wins(0)

	for _, win in ipairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "fugitiveblame" then
			return true, win
		end
	end

	return false, nil
end

return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gb", function()
				local is_open, win_id = is_blame_open()

				if is_open then
					vim.api.nvim_win_close(win_id, true)
				else
					vim.cmd("Git blame")
				end
			end, { desc = "Toggle line blame" })

			vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git Status" })
			vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { desc = "Git Add" })
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
			vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { desc = "Open File Diff" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,

			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				vim.keymap.set("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame line" })

				vim.keymap.set("n", "<leader>hB", ":Gitsigns blame<CR>", { desc = "Blame file" })
			end,
		},
	},
}
