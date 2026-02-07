return {
	clangd = { filetypes = "c" },
	angularls = { filetypes = { "htmlangular" } },
	svelte = { filetypes = { "svelte" } },
	ts_ls = {
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	},
	html = { filetypes = { "html", "htmlangular", "typescriptreact" } },
	cssls = {},
	tailwindcss = {
		filetypes = { "html", "css", "typescriptreact", "htmlangular" },
	},
	rust_analyzer = {},
	biome = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				runtime = { version = "LuaJIT" },
			},
		},
	},
}
