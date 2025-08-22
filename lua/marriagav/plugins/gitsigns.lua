-- Keymaps
vim.keymap.set("n", "<leader>hgb", ":Gitsigns blame<cr>", { desc = "[H][G]it [B]lame" })

return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	},
}
