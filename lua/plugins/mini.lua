return {
	{
		"nvim-mini/mini.notify",
		config = function()
			require("mini.notify").setup()

			MiniNotify.make_notify()
		end,
	},
	{
		"nvim-mini/mini.tabline",
		config = function()
			require("mini.tabline").setup()
		end,
	},
	{
		"nvim-mini/mini.statusline",
		config = function()
			require("mini.statusline").setup()
		end,
	},
}
