return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("xcodebuild").setup({
			code_coverage = {
				enabled = true,
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>XC", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
	end,
}
