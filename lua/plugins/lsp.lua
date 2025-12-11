require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
})

local configure_keybindings = function()
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
	vim.keymap.set("i", "<C-l>", function()
		require("cmp").mapping.complete()
	end)
end

return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		automatic_enable = true,
		automatic_setup = true,
		registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		},
		ensure_installed = {
			"lua_ls",
		},
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)

		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 2 },
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		configure_keybindings()

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Enter>"] = cmp.mapping.confirm({ select = true }),
				["<C-l>"] = cmp.mapping(function()
					cmp.complete()
				end),
			}),
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
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
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
	},
}
