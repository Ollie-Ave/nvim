return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true,
		message_template = "✏️  <author>, <date> • <summary>",
		message_when_not_committed = "✏️  You, <date>",
		date_format = "%r",
		virtual_text_column = 2,
		max_commit_summary_length = 45,
	},
	config = function(_, opts)
		local gitblame = require("gitblame")
		gitblame.setup(opts)

		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				local line = vim.api.nvim_win_get_cursor(0)[1] - 1

				-- Disable gitblame when *any* diagnostic exists on the current line
				local diags = vim.diagnostic.get(0, { lnum = line })

				if #diags > 0 then
					gitblame.disable()
				else
					gitblame.enable()
				end
			end,
		})
	end,
}
