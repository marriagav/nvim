---@diagnostic disable: missing-fields -- vibing.setup() merges with defaults; partial config is valid
require("vibing").setup({
	dependencies = {
		"stevearc/oil.nvim", -- optional: add context straight from the file browser
  	},
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
