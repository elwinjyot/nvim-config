return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local builtin = require("telescope.builtin")
		require("telescope").setup({
			pickers = {
				find_files = {
					theme = "ivy",
				},
				help_tags = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
				lsp_references = {
					theme = "cursor",
				},
				grep_string = {
					theme = "cursor",
				},
				git_branches = {
					theme = "ivy",
				},
				diagnostics = {
					theme = "ivy",
				},
			},
			extensions = {
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_cursor({}),
				},
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep" })
		vim.keymap.set("n", "<leader>f*", builtin.grep_string, { desc = "Search String" })
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find References" })
		vim.keymap.set("n", "<leader>fb", builtin.git_branches, { desc = "Find Git Branches" })
		vim.keymap.set("n", "<leader>fq", builtin.diagnostics, { desc = "Find Diagnostics" })

		require("telescope").load_extension("ui-select")
	end,
}
