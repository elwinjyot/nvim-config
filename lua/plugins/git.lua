return {
	{
		"tpope/vim-fugitive",
		config = function()
			local function get_blame_window()
				local wins = vim.api.nvim_tabpage_list_wins(0)
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == "fugitiveblame" then
						return win
					end
				end
				return nil
			end

			-- Toggle Git Blame
			vim.keymap.set("n", "<leader>gb", function()
				local win_id = get_blame_window()
				if win_id then
					vim.api.nvim_win_close(win_id, true)
				else
					vim.cmd("Git blame")
				end
			end, { desc = "Toggle Git Blame" })

			-- Git Status
			vim.keymap.set("n", "<leader>gg", function()
				vim.cmd("Git")
			end, { desc = "Git Status" })

			-- Git Add All
			vim.keymap.set("n", "<leader>ga", function()
				vim.cmd("Git add .")
				vim.notify("Staged all files!")
			end, { desc = "Git Add All" })

			-- Git Commit
			vim.keymap.set("n", "<leader>gc", function()
				vim.cmd("Git commit")
			end, { desc = "Git Commit" })

			-- Git Push
			vim.keymap.set("n", "<leader>gp", function()
				vim.cmd("Git push")
				vim.notify("Changes pushed!")
			end, { desc = "Git Push" })

			vim.keymap.set("n", "<leader>gP", function()
				vim.ui.input({
					prompt = "Pull from (remote branch): ",
					default = "origin ",
				}, function(input)
					if not input or input == "" then
						return
					end

					local cmd = "git pull " .. input
					local output = vim.fn.system(cmd)
					local exit_code = vim.v.shell_error

					if exit_code == 0 then
						vim.notify("Pulled and synced from " .. input, vim.log.levels.INFO)
					else
						if output:find("CONFLICT") then
							local conflict_count =
								vim.fn.system("git diff --name-only --diff-filter=U | wc -l"):gsub("%s+", "")
							vim.notify("Pulled with " .. conflict_count .. " conflict(s)", vim.log.levels.WARN)
						else
							vim.notify("Pull failed: " .. output, vim.log.levels.ERROR)
						end
					end

					vim.cmd("checktime")
				end)
			end, { desc = "Git Pull" })
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			-- Git Diff
			vim.keymap.set("n", "<leader>gd", function()
				vim.cmd("DiffviewOpen --layout=diff3_mixed")
			end, {
				desc = "Git Diff",
			})

			vim.keymap.set("n", "<leader>gdc", function()
				vim.cmd("DiffviewClose")
			end, {
				desc = "Close Git Diff",
			})
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
