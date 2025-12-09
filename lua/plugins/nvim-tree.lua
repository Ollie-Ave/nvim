vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvim_tree = require("nvim-tree")

		nvim_tree.setup({
			sort = {
				sorter = "case_sensitive",
			},
			update_focused_file = {
				enable = true,
			},
			view = {
				width = 60,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		})

	end,
}
