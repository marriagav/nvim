return {
	"mbbill/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		-- Keymaps
		vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
	end,
}
