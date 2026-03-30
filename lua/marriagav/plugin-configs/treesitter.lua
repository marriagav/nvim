-- Treesitter highlighting and indenting are built-in to Neovim 0.12+.
-- Only treesitter-context needs explicit setup.
require("treesitter-context").setup({
	enable = true,
	max_lines = 5,
})
