-- treesitter
require("nvim-treesitter").setup({})

-- install
require("nvim-treesitter").install({
	"rust",
	"javascript",
	"php",
	"hack",
	"python",
	"swift",
	"cpp",
	"lua",
	"kotlin",
	"markdown",
})
-- start
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"rs",
		"php",
		"swift",
		"md",
		"cpp",
		"h",
		"mm",
		"kt",
		"lua",
		"js",
		"py",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

-- indent (experimental)
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- treesitter-context
require("treesitter-context").setup({
	enable = true,
	max_lines = 5,
})
