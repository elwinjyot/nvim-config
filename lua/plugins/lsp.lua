return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		vim.diagnostic.config({
			severity_sort = true,
			underline = true,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local servers = require("plugins.lsp-setups")

		local ensure_installed = vim.tbl_keys(servers or {})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					vim.lsp.config("*", {
						capabilities = capabilities,
					})
					vim.lsp.config(server_name, server)
				end,
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end

				map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Actions", { "n", "x" })
				map("<leader>ld", vim.lsp.buf.definition, "Goto Definition")
				map("<leader>lD", vim.lsp.buf.declaration, "Goto Declaration")

				-- Highlight the word under the cursor when cursor does not move
				local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				-- Remove the highlight when cursor is moved away
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				-- Remove and clear highlights when LSP is detached
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
					end,
				})
			end,
		})
	end,
}
