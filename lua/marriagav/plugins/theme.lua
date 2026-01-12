-- Catpuccin
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	opts = {
-- 		transparent_background = true,
-- 		float = { transparent = true, solid = false },
-- 	},
-- 	init = function()
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 		vim.cmd.hi("Comment gui=none")
-- 	end,
-- }

-- Koda
return {
	"oskarnurm/koda.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("koda").setup({ transparent = true })
		vim.cmd("colorscheme koda")
	end,
}
