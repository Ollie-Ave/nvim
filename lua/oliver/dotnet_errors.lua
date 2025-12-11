local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
	return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function get_dotnet_errors()
	local handle = io.popen("dotnet build -v q") -- quiet build output
	if not handle then
		return {}
	end
	local result = handle:read("*a")
	handle:close()

	local entries = {}
	for line in result:gmatch("[^\r\n]+") do
		-- Example: Program.cs(10,15): error CS1002: ; expected
		local file, lnum, col, msg = line:match("^(.-)%((%d+),(%d+)%)[:]?%s*error%s+%w+:%s*(.+)$")
		if file and lnum and col and msg then
			table.insert(entries, {
				text = string.format("%s:%s:%s: %s", file, lnum, col, msg),
				file = vim.fn.fnamemodify(file, ":p"), -- make absolute path
				lnum = tonumber(lnum),
				col = tonumber(col) - 1, -- convert to 0-indexed
			})
		end
	end
	return entries
end

local function dotnet_errors_picker()
	local results = get_dotnet_errors()
	if #results == 0 then
		print("No errors found.")
		return
	end

	pickers
		.new({}, {
			prompt_title = "Dotnet Build Errors",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.text,
						ordinal = entry.text,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(_, map)
				map("i", "<CR>", function(prompt_bufnr)
					local selection = action_state.get_selected_entry().value
					actions.close(prompt_bufnr)
					vim.cmd("edit " .. selection.file)
					vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
				end)
				map("n", "<CR>", function(prompt_bufnr)
					local selection = action_state.get_selected_entry().value
					actions.close(prompt_bufnr)
					vim.cmd("edit " .. selection.file)
					vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
				end)
				return true
			end,
		})
		:find()
end

vim.api.nvim_create_user_command("DotnetErrors", dotnet_errors_picker, {})
