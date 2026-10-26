---@diagnostic disable: missing-fields -- vibing.setup() merges with defaults; partial config is valid
require("vibing").setup({
	ai = {
		chat = { agent = "pi" },
		agents = {
			pi = {
				extensions = {
					web_search = "auto",
				},
			},
		},
	},
})
