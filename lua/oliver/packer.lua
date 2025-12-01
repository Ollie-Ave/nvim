vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",

		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			vim.cmd("colorscheme catppuccin")
		end,
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {

			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern", "lsp" },
				patterns = { ".git", "Makefile", "package.json" },
				show_hidden = true,
			})
		end,
	})

	use({
		"nvim-telescope/telescope-project.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("project")
		end,
	})

	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.buttons.val = {
				dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
				dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			table.insert(dashboard.config.layout, 1, {
				type = "padding",
				val = math.floor(vim.fn.winheight(0) * 0.25),
			})

			alpha.setup(dashboard.config)
		end,
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("xiyaowong/transparent.nvim")
	use("nvim-tree/nvim-tree.lua")
	use("windwp/nvim-ts-autotag")
	use("github/copilot.vim")
	use("nvim-tree/nvim-web-devicons")
end)
