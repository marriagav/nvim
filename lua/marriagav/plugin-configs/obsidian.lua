local obsidian_vault_path = os.getenv("OBSIDIAN_PATH")

require("obsidian").setup({
	workspaces = {
		{
			name = "obsidian",
			path = obsidian_vault_path or
			"/Users/marriagav/Library/Mobile Documents/iCloud~md~obsidian/Documents/Miguel/",
		},
	},
	completion = {
		blink = true,
		min_chars = 2,
	},
	notes_subdir = "inbox",
	new_notes_location = "notes_subdir",
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M:%S",
		substitutions = {}
	},
	legacy_commands = false,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local buf_path = vim.api.nvim_buf_get_name(0)
		if buf_path:sub(1, #obsidian_vault_path) == obsidian_vault_path then
			if vim.bo.filetype == "markdown" then
				if package.loaded["obsidian"] then
					vim.keymap.set("n", "<leader>on", ":Obsidian template note-template<cr>",
						{ buffer = true })
					vim.keymap.set(
						"n",
						"<leader>ob",
						":Obsidian template bookmark-template<cr>: /^urls:/<cr>o\t- ",
						{ buffer = true }
					)
					vim.keymap.set("n", "<leader>ot", ":Obsidian template task-template<cr>",
						{ buffer = true })
					vim.keymap.set("n", "<leader>or", ":Obsidian backlinks<cr>", { buffer = true })
					vim.keymap.set("n", "gf", ":Obsidian follow_link<cr>", { buffer = true })
				end
			end
		end
	end,
})
