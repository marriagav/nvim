require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
require("mini.pairs").setup()

require("mini.sessions").setup({
	autoread = true,
	autowrite = true,
})

require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local filename = MiniStatusline.section_filename({ trunc_width = 1140 })
			local diagnostics = MiniStatusline.section_diagnostics({
				trunc_width = 75,
				icon = "",
			})
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = mode_hl, strings = { location } },
			})
		end,
		inactive = function()
			return MiniStatusline.section_filename({})
		end,
	},
})

vim.keymap.set("n", "<leader>mss", function()
	MiniSessions.select()
end, { desc = "[M]ini [S]ession [S]elect" })

vim.keymap.set("n", "<leader>msc", function()
	local session_name = vim.fn.input("Enter session name (or enter for local): ")
	if session_name == "" then
		MiniSessions.write(MiniSessions.config.file)
	else
		MiniSessions.write(session_name)
	end
end, { desc = "[M]ini [S]ession [C]reate" })

vim.keymap.set("n", "<leader>msw", function()
	MiniSessions.write()
end, { desc = "[M]ini [S]ession [W]rite" })

vim.keymap.set("n", "<leader>msd", function()
	local session_name = vim.fn.input("Enter session name to delete: ")
	MiniSessions.delete(session_name)
end, { desc = "[M]ini [S]ession [D]elete" })
