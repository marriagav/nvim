return {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"swift",
				"python",
				"typescript",
				"javascript",
				"c++",
				"php",
				"php_only",
				"go",
				"rust",
				"json",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
			autotag = {
				enable = true,
			},
		})

		require("treesitter-context").setup({
			enable = true,
			max_lines = 5,
		})
	end,
}
