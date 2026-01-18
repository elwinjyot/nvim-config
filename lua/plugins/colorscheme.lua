return {
	"rose-pine/neovim",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "main",
		})
	end,
}
