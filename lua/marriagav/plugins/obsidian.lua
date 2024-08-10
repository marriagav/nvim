return {
	"epwalsh/obsidian.nvim",
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
		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},
		notes_subdir = "notes",
		new_notes_location = "notes_subdir",
		-- Optional, for templates (see below).
		disable_frontmatter = true,
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},
		ui = {
			-- Disable some things below here because I set these manually for all Markdown files using treesitter
			checkboxes = {},
			bullets = {},
		},
	},
}
