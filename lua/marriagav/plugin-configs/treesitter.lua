-- treesitter
require("nvim-treesitter").setup({})

local langs = {
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
}
-- install
require("nvim-treesitter").install(langs)
-- start
vim.api.nvim_create_autocmd("FileType", {
	pattern = langs,
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
