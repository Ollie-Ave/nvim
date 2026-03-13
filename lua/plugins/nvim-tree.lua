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
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				preserve_window_proportions = true,
				width = 60,
			},
		})
	end,
}
