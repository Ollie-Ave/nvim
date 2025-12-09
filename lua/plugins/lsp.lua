return {
	"mason-org/mason-lspconfig.nvim",
    lazy = false,
	opts = function(_, opts)
		opts.automatic_enable = true
		opts.automatic_setup = true
		opts.ensure_installed = {
			"lua_ls",
			"omnisharp",
		}

		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 2 },
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local remap_opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, remap_opts)
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation()
		end, remap_opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, remap_opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, remap_opts)

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, remap_opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, remap_opts)

		vim.keymap.set("n", "<leader>.", function()
			vim.lsp.buf.code_action()
		end, remap_opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, remap_opts)
		vim.keymap.set("n", "<leader>r", function()
			vim.lsp.buf.rename()
		end, remap_opts)
		vim.keymap.set("n", "<leader>i", function()
			vim.lsp.buf.signature_help()
		end, remap_opts)

		vim.lsp.config("omnisharp", {
			cmd = {
				"dotnet",
				"C:\\Users\\Oliver\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
				"--languageserver",
				"--hostPID",
				tostring(vim.fn.getpid()),
			},
			filetypes = { "cs", "csx", "sln" },
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
			init_options = {
				useModernNet = true,
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "bufnr" },
					},
				},
			},
		})
	end,
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		"neovim/nvim-lspconfig",
	},
}
