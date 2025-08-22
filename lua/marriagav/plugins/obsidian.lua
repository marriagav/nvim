-- Keymaps
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note-template<cr>")
vim.keymap.set("n", "<leader>ob", ":ObsidianTemplate bookmark-template<cr>" .. ":/^urls:/+1<cr>" .. "A ")
vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate task-template<cr>")
vim.keymap.set("n", "<leader>om", ":ObsidianTemplate monthly-budget-template<cr>")
vim.keymap.set("n", "<leader>or", ":ObsidianBacklinks<cr>")

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
				path = "/Users/marriagav/Library/Mobile Documents/iCloud~md~obsidian/Documents/Miguel/",
			},
		},
		completion = {
			blink = true,
			min_chars = 2,
		},
		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",
		disable_frontmatter = true,
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},
		ui = {
			checkboxes = {},
			bullets = {},
		},
	},
}
