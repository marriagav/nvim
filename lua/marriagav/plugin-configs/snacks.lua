require("snacks").setup({
	image = { enabled = true },
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	indent = { enabled = false },
	input = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = {
		enabled = true, -- Enhances Select
		win = {
			input = {
				keys = {
					["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
				},
			},
		},
		actions = {
			opencode_send = function(picker) ---@param picker snacks.Picker
				local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
					return item.file
							and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
						or item.text
				end, picker:selected({ fallback = true }))

				require("opencode").prompt(table.concat(items, ", ") .. " ")
			end,
		},
	},
	quickfile = { enabled = true },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = false },
	words = { enabled = false },
	styles = {
		notification = {},
	},
	gitbrowse = {
		enabled = true,
	},
})
