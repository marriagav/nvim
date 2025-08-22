return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		transparent_background = true,
		float = { transparent = true, solid = false },
	},
	init = function()
		vim.cmd.colorscheme("catppuccin-mocha")
		vim.cmd.hi("Comment gui=none")
	end,
}
