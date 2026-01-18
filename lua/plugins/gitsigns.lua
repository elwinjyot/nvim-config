return {
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

			vim.keymap.set("n", "<leader>hB", ":Gitsigns blame<CR>", { desc = "Blame line" })
		end,
	},
}
