local obsidian_vault_path = os.getenv("OBSIDIAN_PATH")

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "obsidian",
				path = obsidian_vault_path,
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
		},
		ui = {
			bullets = {},
		},
		legacy_commands = false,
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		-- Set up keymaps only for Obsidian buffers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				local buf_path = vim.api.nvim_buf_get_name(0)
				if buf_path:sub(1, #obsidian_vault_path) == obsidian_vault_path then
					if vim.bo.filetype == "markdown" then
						-- Only set if Obsidian is loaded
						if package.loaded["obsidian"] then
							vim.keymap.set("n", "<leader>on", ":Obsidian template note-template<cr>", { buffer = true })
							vim.keymap.set(
								"n",
								"<leader>ob",
								":Obsidian template bookmark-template<cr>: /^urls:/+1<cr>A ",
								{ buffer = true }
							)
							vim.keymap.set("n", "<leader>ot", ":Obsidian template task-template<cr>", { buffer = true })
							vim.keymap.set(
								"n",
								"<leader>om",
								":Obsidian template monthly-budget-template<cr>",
								{ buffer = true }
							)
							vim.keymap.set("n", "<leader>or", ":Obsidian backlinks<cr>", { buffer = true })
							vim.keymap.set("n", "gf", ":Obsidian follow_link<cr>", { buffer = true })
						end
					end
				end
			end,
		})
	end,
}
