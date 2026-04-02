local plugins = {
	-- Core libraries
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",

	-- Telescope
	"https://github.com/nvim-telescope/telescope.nvim",

	-- LSP
	"https://github.com/neovim/nvim-lspconfig",

	-- Autocompletion
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/github/copilot.vim",

	-- Treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/nvim-treesitter/nvim-treesitter",

	-- UI
	"https://github.com/folke/snacks.nvim",
	"https://github.com/oskarnurm/koda.nvim",
	"https://github.com/folke/which-key.nvim",

	-- File / Navigation
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

	-- Editing
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/ThePrimeagen/99",

	-- Personal-only
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/obsidian-nvim/obsidian.nvim",
}

if vim.fn.executable("make") == 1 then
	table.insert(plugins, "https://github.com/nvim-telescope/telescope-fzf-native.nvim")
end

if vim.g.have_nerd_font then
	table.insert(plugins, "https://github.com/nvim-tree/nvim-web-devicons")
end

vim.pack.add(plugins)

-- Build hooks
vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function(ev)
		local data = ev.data
		if data.kind == "delete" then
			return
		end
		if data.spec.name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			vim.fn.system({ "make", "-C", data.path })
		end
		if data.spec.name == "blink.cmp" and vim.fn.executable("cargo") == 1 then
			vim.fn.system({ "cargo", "build", "--release", "--manifest-path", data.path .. "/Cargo.toml" })
		end
	end,
})
